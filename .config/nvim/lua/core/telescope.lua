return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- get access to telescopes built in functions
      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch Existing [B]uffers' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      -- get access to telescopes navigation functions
      local actions = require 'telescope.actions'

      require('telescope').setup {
        defaults = {
          layout_config = {
            horizontal = {
              preview_width = 0, -- Increase this value to see more of the message
            },
          },
        },
        -- use ui-select dropdown as our ui
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },
        -- set keymappings to navigate through items in the telescope io
        mappings = {
          i = {
            -- use <cltr> + n to go to the next option
            ['<C-n>'] = actions.cycle_history_next,
            -- use <cltr> + p to go to the previous option
            ['<C-p>'] = actions.cycle_history_prev,
            -- use <cltr> + j to go to the next preview
            ['<C-j>'] = actions.move_selection_next,
            -- use <cltr> + k to go to the previous preview
            ['<C-k>'] = actions.move_selection_previous,
          },
        },
        -- load the ui-select extension
        require('telescope').load_extension 'ui-select',
      }
    end,
  },
}
