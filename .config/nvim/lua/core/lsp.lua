-- 1. DEFINE YOUR STACK (Add any new DLSU or SWE languages here)
local servers = {
  vtsls = {}, -- Faster React/TS support
  pyright = {}, -- Python/Data Science
  gopls = {}, -- Go
  rust_analyzer = {},
  clangd = {}, -- C/C++
  asm_lsp = {}, -- Assembly (Computer Arch)
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
        diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
}

-- 2. LSP KEYMAPS (Minimalist & Aggressive)
local on_attach = function(event)
  local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc }) end

  map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  map('K', vim.lsp.buf.hover, 'Hover Documentation')
end

-- 3. THE SPEC
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp', -- Speedy completion engine
  },
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ft = args.match
        local indent = {
          html = 2,
          css = 2,
          c = 8,
          h = 8,
        }

        local size = indent[ft] or 4 -- Default to 4 spaces if language not listed
        vim.bo.tabstop = size
        vim.bo.shiftwidth = size
        vim.bo.expandtab = true -- Use spaces instead of tabs
      end,
    })

    -- Hook up the keymaps
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach-group', { clear = true }),
      callback = on_attach,
    })

    -- Tell Mason to install LSPs + essential formatters
    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, { 'stylua', 'prettier', 'black' })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    -- Setup blink.cmp capabilities
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Safely setup servers via mason-lspconfig (prevents race-condition crashes)
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
  -- Special Lua Config, as recommended by neovim help docs
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
          --  See https://github.com/neovim/nvim-lspconfig/issues/3189
          library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          }),
        },
      })
    end,
    settings = {
      Lua = {},
    },
  },
}
