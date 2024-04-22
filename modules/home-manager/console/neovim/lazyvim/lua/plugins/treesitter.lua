return {
  "nvim-treesitter/playground",
  dependencies = "nvim-treesitter/nvim-treesitter",
  main = "nvim-treesitter.configs",
  opts = {
    playground = {
      enable = true,
      disable = {},
      persist_queries = false,
    },
  },
}
