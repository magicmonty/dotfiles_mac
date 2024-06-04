{
  config,
  lib,
  pkgs,
  ...
}:
with builtins;
with lib;
with lib.mgnix; {
  options.mgnix.apps.console.git.better-commits = {
    enable = mkBoolOption config.mgnix.apps.console.git.enable "Whether to enable better-commits";

    settings = mkOption {
      description = "Settings for .better-commits.json";
      type = types.attrs;
      default = {
        check_status = true;
        commit_type = {
          enable = true;
          initial_value = "feat";
          max_items = 20;
          infer_type_from_branch = true;
          append_emoji_to_label = false;
          append_emoji_to_commit = false;
          options = [
            {
              value = "feat";
              label = "feat";
              hint = "A new feature";
              emoji = "✨";
              trailer = "Changelog: feature";
            }
            {
              value = "fix";
              label = "fix";
              hint = "A bug fix";
              emoji = "🐛";
              trailer = "Changelog: fix";
            }
            {
              value = "docs";
              label = "docs";
              hint = "Documentation only changes";
              emoji = "📚";
              trailer = "Changelog: documentation";
            }
            {
              value = "refactor";
              label = "refactor";
              hint = "A code change that neither fixes a bug nor adds a feature";
              emoji = "🔨";
              trailer = "Changelog: refactor";
            }
            {
              value = "perf";
              label = "perf";
              hint = "A code change that improves performance";
              emoji = "🚀";
              trailer = "Changelog: performance";
            }
            {
              value = "test";
              label = "test";
              hint = "Adding missing tests or correcting existing tests";
              emoji = "🚨";
              trailer = "Changelog: test";
            }
            {
              value = "build";
              label = "build";
              hint = "Changes that affect the build system or external dependencies";
              emoji = "🚧";
              trailer = "Changelog: build";
            }
            {
              value = "ci";
              label = "ci";
              hint = "Changes to our CI configuration files and scripts";
              emoji = "🤖";
              trailer = "Changelog: ci";
            }
            {
              value = "chore";
              label = "chore";
              hint = "Other changes that do not modify src or test files";
              emoji = "🧹";
              trailer = "Changelog: chore";
            }
            {
              value = "";
              label = "none";
            }
          ];
        };
        commit_scope = {
          enable = true;
          custom_scope = true;
          max_items = 20;
          initial_value = "";
          options = [
            {
              value = "frontent";
              label = "frontent";
            }
            {
              value = "shared";
              label = "shared";
            }
            {
              value = "backend";
              label = "backend";
            }
            {
              value = "iOS";
              label = "iOS";
            }
            {
              value = "android";
              label = "android";
            }
            {
              value = "";
              label = "none";
            }
          ];
        };
        check_ticket = {
          infer_ticket = true;
          confirm_ticket = true;
          add_to_title = true;
          append_hashtag = false;
          prepend_hashtag = "Always";
          surround = "";
          title_position = "start";
        };
        commit_title = {
          max_size = 70;
        };
        commit_body = {
          enable = true;
          required = false;
        };
        commit_footer = {
          enable = true;
          initial_value = [];
          options = [
            "closes"
            "breaking-change"
            "custom"
          ];
        };
        breaking_change = {
          add_exclamation_to_title = true;
        };
        confirm_with_editor = true;
        confirm_commit = true;
        print_commit_output = true;
        branch_pre_commands = [];
        branch_post_commands = [];
        worktree_pre_commands = [];
        worktree_post_commands = [];
        branch_user = {
          enable = false;
          required = false;
          separator = "/";
        };
        branch_type = {
          enable = true;
          separator = "/";
        };
        branch_version = {
          enable = false;
          required = false;
          separator = "/";
        };
        branch_ticket = {
          enable = true;
          required = false;
          separator = "_";
        };
        branch_description = {
          max_length = 70;
          separator = "";
        };
        branch_action_default = "branch";
        branch_order = [
          "user"
          "version"
          "type"
          "ticket"
          "description"
        ];
        enable_worktrees = true;
        overrides = {};
      };
    };
  };

  config = let
    inherit (config.mgnix.apps.console.git.better-commits) enable settings;
    inherit (config.mgnix.apps.console) git;
    aliases = {
      gbc = "git bc";
      gbb = "better-branch";
    };
  in
    mkIf (git.enable && enable) {
      home.packages = with pkgs; [
        mgnix.better-commits
      ];

      home.file.".better-commits.json".text = toJSON settings;

      programs.zsh.shellAliases = aliases;
      programs.bash.shellAliases = aliases;
    };
}
