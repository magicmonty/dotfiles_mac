return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects', -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-refactor',
    'windwp/nvim-ts-autotag',
    'David-Kunz/treesitter-unit',
    'JoosepAlviste/nvim-ts-context-commentstring',
    {
      url = 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git',
      config = function()
        local rd = require('rainbow-delimiters')

        vim.g.rainbow_delimiters = {
          strategy = {
            [''] = function()
              local lineCount = vim.fn.line('$')
              if lineCount > 3000 then
                return nil
              elseif lineCount > 1000 then
                return rd.strategy['global']
              end

              return rd.strategy['local']
            end,
            vim = rd.strategy['local'],
            html = rd.strategy['local']
          },
          query = {
            [''] = 'rainbow-delimiters',
            html = 'rainbow-blocks',
          },
          highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan'
          }
        }
      end
    }
  },
}
