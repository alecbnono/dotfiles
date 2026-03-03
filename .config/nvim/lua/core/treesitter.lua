-- Treesitter (High-Performance Syntax Highlighting)
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    ensure_installed = {
      'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 
      'markdown_inline', 'query', 'vim', 'vimdoc', 'python', 'go', 
      'rust', 'javascript', 'typescript', 'json', 'css', 'jupyter'
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    require('nvim-treesitter.config').setup(opts)
  end,
}
