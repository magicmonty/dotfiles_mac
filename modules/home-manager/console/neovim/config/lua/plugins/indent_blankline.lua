local isTTY = require('magicmonty.utils').isTTY
local indentChar = isTTY() and '|' or '┊'

-- Add indentation guides even on blank lines
return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      enabled = true,
      indent = {
        char = indentChar,
      },
      whitespace = {
        remove_blankline_trail = true,
      },
      scope = {
        enabled = false,
      },
      exclude = {
        filetypes = {
          'dashboard',
          'help',
          'alpha',
          'neo-tree',
          'NvimTree',
          'Trouble',
          'lazy',
          'mason',
          'null-ls-info',
        },
      },
    },
  },
  {
    'echasnovski/mini.indentscope',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      symbol = indentChar,
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'help', 'alpha', 'dashboard', 'neo-tree', 'NvimTree', 'Trouble', 'lazy', 'mason', 'null-ls-info' },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function(_, opts)
      require('mini.indentscope').setup(opts)
    end,
  },
}
