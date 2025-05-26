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
    stateVersion = "25.05";
    homeDirectory = "/Users/martin.gondermann";
    sessionVariables = {
      ANDROID_SDK = "$HOME/Library/Android/sdk";
      PUPPETEER_EXECUTABLE_PATH = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
    };
    sessionPath = [
      "$HOME/.dotnet/tools"
    ];
  };
}
