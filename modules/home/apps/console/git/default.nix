{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mgnix.apps.console.git = {
    enable = mkOption {
      description = "Whether to enable Git";
      type = types.bool;
      default = true;
    };

    lazygit.enable = mkOption {
      description = "Whether to enable LazyGit";
      type = types.bool;
      default = true;
    };

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
    inherit (config.mgnix.apps.console.git) enable lazygit userName email;
  in
    mkIf enable {
      home.packages = with pkgs; [
        delta
        less
        cz-cli
        mgnix.better-commits
        (mkIf lazygit.enable pkgs.lazygit)
      ];

      programs = {
        lazygit = mkIf lazygit.enable {
          enable = true;
          settings = {
            gui = {
              showIcons = true;
              showRandomTip = false;
              nerdFontsVersion = "3";
            };
            update = {
              method = "never";
            };
            disableStartupPopups = true;
            notARepository = "quit";
          };
        };

        git = {
          enable = true;
          userName = "${userName}";
          userEmail = "${email}";
          aliases = {
            s = "status";
            st = "status";
            stu = "status --untracked-files=no";

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
      };
    };
}