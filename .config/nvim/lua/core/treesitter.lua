-- Treesitter (Parser Management for Neovim 0.12+)
-- Highlighting is handled natively by vim.treesitter.start() in Neovim 0.12+.
-- This plugin is used only for parser installation and query management.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup()

    -- Ensure parsers are installed
    local ensure_installed = {
      'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown',
      'markdown_inline', 'query', 'vim', 'vimdoc', 'python', 'go',
      'rust', 'javascript', 'typescript', 'json', 'css',
    }

    -- Install missing parsers on startup
    local installed = require('nvim-treesitter').get_installed()
    local to_install = vim.tbl_filter(function(lang)
      return not vim.tbl_contains(installed, lang)
    end, ensure_installed)

    if #to_install > 0 then
      require('nvim-treesitter').install(to_install)
    end
  end,
}
