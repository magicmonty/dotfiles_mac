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
    stateVersion = "23.11";
    homeDirectory = "/Users/martin.gondermann";
    sessionVariables = {
      ANDROID_SDK = "~/Library/Android/sdk";
    };
    sessionPath = [
      "~/.dotnet/tools"
    ];
  };
}
