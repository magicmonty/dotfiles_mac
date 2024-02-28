return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          untracked = "★",
          unstaged = "✗",
          staged = "✓",
          ignored = "◌",
          deleted = "",
          renamed = "➜",
          conflict = "",
        },
      },
    },
  },
}
