{
  config,
  lib,
  pkgs,
  ...
}:
with lib; 
{
  config = {
      home = {
      	file."bin/brn".source = ./brn;
      	file."bin/tm".source = ./tm;
      };

      programs.zsh = {
        enable = true;
        autocd = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        enableSyntaxHighlighting = true;
        historySubstringSearch.enable = true;

        history = {
          size = 1000;
          save = 500;
        };

        defaultKeymap = "emacs";

        shellAliases = {
          v = "nvim";
          ls = "eza --git";
          la = "eza --git -glah --color-scale";
          ll = "eza --git -glh --color-scale";
          l = "eza --git -lh --color-scale";
          "c." = "code .";
          lg = "lazygit";
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
          wdw = "git wdw";
          most-changed = "git log --format=%n --name-only | grep -v '^$' | sort | uniq -c |--numeric-sort --reverse | head -n 50";
          gcleanf = "git cleanf -xdf";
          gv = "nvim -c \"GV\" -c \"tabonly\"";
          gitv = "nvim -c \"GV\" -c \"tabonly\"";
          gls = "git log --graph --oneline --decorate --all --color=always | fzf --ansi +s --preview='git show --color=always {2}' --bind='ctrl-d:preview-page-down' --bind='ctrl-u:preview-page-up' --bind='enter:execute:git show --color=always {2} | less -R' --bind='ctrl-x:execute:git checkout {2} .'";
          zz = "z -"; # Toggle last directory via zoxide
          cat = "bat";
          vimdiff = "nvim -d";
        };

        plugins = [
          {
            name = "zsh-nix-shell";
            file = "nix-shell.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "chisui";
              repo = "zsh-nix-shell";
              rev = "v0.5.0";
              sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
            };
          }
        ];

        initExtraFirst = ''
          if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi
        '';

        initExtraBeforeCompInit = ''
          zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
          zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
          zstyle ':completion:*' rehash true                              # automatically find new executables in path
          # Speed up completions
          zstyle ':completion:*' accept-exact '*(N)'
          zstyle ':completion:*' use-cache on
          zstyle ':completion:*' cache-path ~/.zsh/cache
        '';

        initExtra = ''
            ## Options section
            setopt correct                                                  # Auto correct mistakes
            setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
            setopt nocaseglob                                               # Case insensitive globbing
            setopt rcexpandparam                                            # Array expension with parameters
            setopt nocheckjobs                                              # Don't warn about running processes when exiting
            setopt numericglobsort                                          # Sort filenames numerically when it makes sense
            setopt nobeep                                                   # No beep
            setopt appendhistory                                            # Immediately append history instead of overwriting
            setopt histignorealldups                                        # If a new command is a duplicate, remove the older one

            # Don't consider certain characters part of the word
            WORDCHARS=''${WORDCHARS//\/[&.;]}

            if [ -e $HOME/.defaultapps ]; then
              source $HOME/.defaultapps
            fi

            bindkey '^[[1;5D' backward-word
            bindkey '^[[1;5C' forward-word

            export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
            
            if [ -e $HOME/.iterm_shell_integration.zsh ]; then
              . $HOME/.iterm2_shell_integration.zsh 
            fi
          '';
      };
  };
}
