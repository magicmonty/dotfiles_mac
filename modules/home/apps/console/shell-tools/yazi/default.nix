_: {
  programs = {
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh.shellAliases = {
      ranger = "yazi";
    };
  };
}
