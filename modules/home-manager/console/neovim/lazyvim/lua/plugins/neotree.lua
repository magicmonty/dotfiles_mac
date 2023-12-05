return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
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
