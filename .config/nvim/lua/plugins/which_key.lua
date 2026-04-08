return {
  { 'echasnovski/mini.icons', version = '*' },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      local wk = require 'which-key'

      wk.setup()

      wk.add {
        { '<leader>/', group = 'Comments' },
        { '<leader>J', group = '[J]ava' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>e', group = '[E]xplorer' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>g', group = '[G]it' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]indow' },
      }
    end,
  },
}
