_: {
  programs = {
    home-manager.enable = true;
  };

  mgnix.apps = {
    console = {
      git = {
        userName = "Martin Gondermann";
        email = "martin.gondermann@bayoo.net";
      };
    };
  };

  home = {
    stateVersion = "24.11";
    homeDirectory = "/Users/martin.gondermann";
    sessionVariables = {
      ANDROID_SDK = "$HOME/Library/Android/sdk";
    };
    sessionPath = [
      "$HOME/.dotnet/tools"
    ];
  };
}
