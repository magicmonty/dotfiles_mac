{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.mgnix; {
  options.mgnix.apps.console.zsh.enable = mkBoolOption true "Whether to enable zsh";

  config = let
    inherit (config.mgnix.apps.console.zsh) enable;
  in
    mkIf enable {
      programs.zsh = {
        enable = true;
        autocd = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        historySubstringSearch.enable = true;

        history = {
          size = 1000;
          save = 500;
        };

        defaultKeymap = "emacs";

        shellAliases = {
          "c." = "code .";
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

        initContent = lib.mkMerge [
          (
            lib.mkBefore
            # sh
            ''
              if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi
            ''
          )

          (
            lib.mkOrder 550
            # sh
            ''
              zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
              zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
              zstyle ':completion:*' rehash true                              # automatically find new executables in path
              # Speed up completions
              zstyle ':completion:*' accept-exact '*(N)'
              zstyle ':completion:*' use-cache on
              zstyle ':completion:*' cache-path ~/.zsh/cache
            ''
          )

          # sh
          ''
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

            fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" }
            f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
            fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

            if [ -e $HOME/.profile ]; then
              source $HOME/.profile
            fi

            if [ -e $HOME/.zprofile ]; then
              source $HOME/.zprofile
            fi
          ''
        ];
      };
    };
}
