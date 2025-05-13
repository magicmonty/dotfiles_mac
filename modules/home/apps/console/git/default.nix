{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.mgnix; {
  options.mgnix.apps.console.git = {
    enable = mkBoolOption true "Whether to enable Git";

    userName = mkOption {
      description = "Git user name";
      type = types.str;
      default = "Martin Gondermann";
    };

    email = mkOption {
      description = "Git email";
      type = types.str;
      default = "martin.gondermann@bayoo.net";
    };
  };

  config = let
    inherit (config.mgnix.apps.console.git) enable userName email;
    aliases = {
      g = "git";
      gci = "git commit";
      gcim = "git commit --message";
      gcima = "git commit --all --message";
      gs = "git status";
      gst = "git status";
      gstu = "git status --untracked-files=no";
      amend = "git commit --amend --no-edit";
      reword = "git commit --amend --message";
      gu = "git reset HEAD~1";
      grh = "git reset --hard";
      ga = "git add";
      gaa = "git add --all";
      unstage = "git reset HEAD";
      gco = "git checkout";
      gb = "git branch --sort=-committerdate | fzf --header \"Checkout Recent Branch\" --preview \"git diff --color=always {1} | delta\" --pointer=\"\" | xargs git checkout";
      gbr = "git branch";
      gbrs = "git branch --all -verbose";
      gp = "git push";
      gpush = "git push";
      gpushf = "git push --force-with-lease";
      gpull = "git pull";
      gpf = "git push --force-with-lease";
      gra = "git rebase --abort";
      grc = "git rebase --continue";
      grv = "git remote --verbose";
      gd = "git diff";
      gdc = "git diff --staged";
      gshow = "git diff --staged";
      gdt = "git difftool";
      gmt = "git mergetool";
      unresolve = "git checkout --conflict=merge";
      gll = "git log";
      gl = "git log --oneline --max-count=15";
      gld = "git log --oneline --max-count=15 --decorate";
      ggl = "git log --graph --oneline --decorate --branches --all";
      hsit = "git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
      gls = "git log --graph --oneline --decorate --all --color=always | fzf --ansi +s --preview='git show --color=always {2}' --bind='ctrl-d:preview-page-down' --bind='ctrl-u:preview-page-up' --bind='enter:execute:git show --color=always {2} | less -R' --bind='ctrl-x:execute:git checkout {2} .'";
      wdw = "git wdw";
      most-changed = "git log --format=%n --name-only | grep -v '^$' | sort | uniq -c |--numeric-sort --reverse | head -n 50";
      gcleanf = "git cleanf -xdf";
      gsc = "git switch -c";
    };
  in
    mkIf enable {
      home.packages = with pkgs; [
        delta
        less
      ];

      programs = {
        git = {
          enable = true;
          userName = "${userName}";
          userEmail = "${email}";
          aliases = {
            s = "status";
            st = "status";
            stu = "status --untracked-files=no";

            sc = "switch -c";

            ci = "commit";
            cim = "commit --message";
            cima = "commit --all --message";
            type = "cat-file -t";
            dump = "cat-file -p";

            # Correcting commits
            amend = "commit --amend --no-edit";
            reword = "commit --amend --message";
            undo = "reset HEAD~1";
            rh = "reset --hard";

            # index related commands
            a = "add";
            aa = "add --all";
            unstage = "reset HEAD";

            # git branch and remote
            co = "checkout";
            br = "branch";
            b = "branch";
            brs = "branch --all --verbose";

            # git remote
            rv = "remote --verbose";

            # git diff
            d = "diff";
            df = "diff";
            dc = "diff --staged";
            preview = "diff --staged";
            dt = "difftool";

            # merges
            mt = "mergetool";
            unresolve = "checkout --conflict=merge";

            # git log
            ll = "log";
            l = "log --oneline --max-count=15";
            ld = "log --oneline --max-count=15 --decorate";
            gl = "log --graph --oneline --decorate --branches --all";
            glog = "log --graph --oneline --decorate --branches --all";
            hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
            who = "log --date=relative --pretty='format:%C(yellow)%h%Creset %C(bold blue)%an%Creset %C(bold green)%cr%Creset %s'";
            wdw = "log --date=relative --pretty='format:%C(yellow)%h%Creset %C(bold blue)%an%Creset %C(bold green)%cr%Creset %s'";
            most-changed = "!git log --format=%n --name-only | grep -v '^$' | sort | uniq -c | sort --numeric-sort --reverse | head -n 50";

            # clean
            cleanf = "clean -xdf";
          };

          ignores = [
            "*~"
            ".DS_Store"
            ".fake"
            "bin"
            "*.userprefs"
            "obj"
            "deploy"
            "*.log"
          ];

          extraConfig = {
            color.ui = true;
            core = {
              autocrlf = "input";
              editor = "nvim";
            };
            merge = {
              tool = "bc";
              conflictstyle = "diff3";
            };
            mergetool = {
              prompt = false;
              bc.trustExitCode = true;
            };
            difftool.prompt = false;
            diff = {
              tool = "bc";
              colorMoved = "default";
            };
            rerere = {
              enabled = true;
              autoupdate = true;
            };
            fetch.prune = true;
            push.default = "current";
            pull = {
              rebase = true;
              ff = "only";
            };
            commit = {
              cleanup = "scissors";
            };
            init.defaultBranch = "main";
            gui.pruneDuringFetch = true;
          };

          delta = {
            enable = true;
            options = {
              features = "side-by-side line-numbers decorations";
              whitespace-error-style = "22 reverse";
              decorations = {
                commit-decoration-style = "bold yellow box ul";
                file-style = "bold yellow ul";
                file-decoration-style = "none";
              };
            };
          };
        };

        zsh.shellAliases = aliases;
        bash.shellAliases = aliases;
      };
    };
}
