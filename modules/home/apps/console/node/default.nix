_: {
  programs.zsh = {
    initExtra = ''
      export NVM_DIR="$HOME/.nvm"

      # load NVM
      [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"

      # This loads nvm bash_completion
      [ -s "$HOMEBREW_PREFIXopt/nvm/etc/bash_completion.d/nvm" ] && . "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
    '';
  };
}
