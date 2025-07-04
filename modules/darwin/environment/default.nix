_: let
  sessionVariables = {
    ANDROID_SDK = "/Users/martin.gondermannbayoo.net/Library/Android/sdk";
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
  };
in {
  environment = {
    pathsToLink = ["/share/zsh"];
    variables = sessionVariables;
  };

  launchd = {
    user.envVariables = sessionVariables;
  };
}
