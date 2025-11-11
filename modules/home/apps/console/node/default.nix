{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      fnm
    ];
    shellAliases = {
      nvm = "fnm";
    };
  };
  programs.zsh = {
    initContent = ''
      eval $(fnm env)
    '';
  };
  /*
  programs.zsh = {
    initContent = ''
      export NVM_DIR="$HOME/.nvm"

      # load NVM
      [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"

      # This loads nvm bash_completion
      [ -s "$HOMEBREW_PREFIXopt/nvm/etc/bash_completion.d/nvm" ] && . "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
    '';
  };
  */
}
