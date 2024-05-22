_: {
  home.sessionVariables = {
    FZF_DEFAULT_COMMAND = "rg --files | sort -u";
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--height 40%"
      "--layout reverse"
      "--border"
      "--inline-info"
    ];
  };
}
