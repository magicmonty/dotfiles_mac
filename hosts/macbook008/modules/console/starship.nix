{
  config,
  lib,
  ...
}:
with lib; 
let
  baseColor = "blue";
in {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;
      format = ''
        [](${baseColor})$env_var$os$username$hostname[](fg:${baseColor})
        [│](${baseColor})$directory$git_branch$git_metrics$git_state$git_status$dotnet$lua$nodejs
        [└─](${baseColor})$battery$status[>](${baseColor}) '';

      continuation_prompt = "[>](bright-black) ";
      character.success_symbol = "[▶](bold green)";

      battery = {
        disabled = false;
        full_symbol = " 󰁹 ";
        charging_symbol = " 󰂄 ";
        discharging_symbol = " 󰂃 ";
        unknown_symbol = " 󰁽 ";
        empty_symbol = " 󰂎 ";

        display = [
          {
            threshold = 80;
            style = "green";
          }
          {
            threshold = 30;
            style = "bold yellow";
          }
          {
            threshold = 20;
            style = "bold red";
          }
        ];
      };

      git_metrics = {
        disabled = false;
        format = "([$added]($added_style) )([✘$deleted]($deleted_style) )";
        command_timeout = 1000;
      };

      dotnet = {
        disabled = true;
        format = "\n[│](${baseColor})(🎯 $tfm) via $symbol($version)]($style)";
        symbol = " ";
      };

      lua = {
        symbol = " ";
        format = "\n[│](${baseColor})[$symbol($version)]($style)";
      };

      nodejs = {
        format = "\n[│](${baseColor})[$symbol($version)]($style)";
        symbol = " ";
      };

      package.disabled = true;

      status = {
        disabled = false;
        format = "[$symbol]($style)";
        map_symbol = true;
        symbol = "";
      };

      directory = {
        truncation_symbol = "…\\";
        read_only = " ";

        substitutions = {
          "Documents" = "󰈙 ";
          "Dokumente" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Musik" = " ";
          "Pictures" = " ";
          "Bilder" = " ";
          "Images" = " ";
        };
      };

      git_branch.symbol = " ";

      username = {
        show_always = true;
        style_user = "bg:${baseColor} fg:white bold";
        style_root = "bg:${baseColor} fg:white bold";
        format = "[$user]($style)";
      };

      git_status = {
        stashed = "󱓞";
        staged = "󰸞";
        deleted = "✘";
        style = "yellow bold";
        ignore_submodules = true;
        format = "([$all_status$ahead_behind]($style) )";
        command_timeout = 1000;
      };

      hostname = {
        disabled = false;
        ssh_only = false;
        format = "[@$ssh_symbol$hostname]($style)";
        style = "bg:${baseColor} fg:white bold";
      };

      env_var.SYSTEM_ICON = {
        variable = "SYSTEM_ICON";
        default = "";
        style = "bg:${baseColor} fg:white bold";
        format = "[$env_value ]($style)";
        disabled = true;
      };

      os = {
        style = "bg:${baseColor} fg:white bold";
        format = "[$symbol]($style)";
        disabled = false;

        symbols = {
          Ubuntu = " ";
          Arch = " ";
          Manjaro = " ";
          Macos = " ";
          Linux = " ";
          Windows = " ";
          Alpine = " ";
        };
      };
    };
  };
}
