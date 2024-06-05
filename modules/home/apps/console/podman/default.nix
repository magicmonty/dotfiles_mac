{
  osConfig,
  lib,
  ...
}:
with lib; {
  config = let
    aliases = {
      docker = "podman";
      "docker-compose" = "podman-compose";
      "start-sql-server" = "podman run --arch=amd64 --rm --name sqlserver -e \"MSSQL_PID=Developer\" -e \"ACCEPT_EULA=Y\" -e \"MSSQL_SA_PASSWORD=Dev0nly!\" -v \"$HOME/.local/share/sqlserver/data:/var/opt/mssql/data:Z,U\" -v \"$HOME/.local/share/sqlserver/secrets:/var/opt/mssql/secrets:Z,U\" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest";
      "stop-sql-server" = "podman stop sqlserver";
    };
  in
    mkIf osConfig.mgnix.apps.podman.enable {
      programs.zsh.shellAliases = aliases;
      programs.bash.shellAliases = aliases;
    };
}
