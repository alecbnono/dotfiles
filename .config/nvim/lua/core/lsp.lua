-- LSP Configurations (Kickstart + Optimized Logic)
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp', -- Speedy completion engine
    { 'j-hui/fidget.nvim', opts = {} }, -- Status updates for LSP
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
      },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
  },
  config = function()
    -- Keymaps for LSP (Standardized <leader>c prefix)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach-group', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc }) end

        -- Blink.cmp will handle references/definitions with its own picker where configured
        map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
        map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Centered Centering Page Movements (Integrated with LSP workflow)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method 'textDocument/documentHighlight' then
          local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- Server Configuration
    local servers = {
      clangd = {},
      pyright = {},
      gopls = {},
      rust_analyzer = {},
      vtsls = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
      jdtls = {
        settings = {
          java = { autobuild = { enabled = false } },
        },
      },
    }

    -- Get capabilities from blink.cmp
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Mason Tool Installer
    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, { 'stylua', 'prettier', 'black', 'clang-format', 'jupytext' })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    -- Mason LSP Config Setup
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
