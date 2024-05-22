_: {
  environment = {
    pathsToLink = ["/share/zsh"];
  };

  launchd = {
    user.envVariables = {
      ANDROID_SDK = "~/Library/Android/sdk";
      DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    };
  };
}
