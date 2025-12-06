return {

	---------------------------------------------------------------------------
	-- Image rendering (optimized for performance)
	---------------------------------------------------------------------------
	{
		"3rd/image.nvim",
		opts = {
			backend = "kitty", -- must match your terminal
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
			tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
		},
	},

	---------------------------------------------------------------------------
	-- Molten: Jupyter kernel inside Neovim
	---------------------------------------------------------------------------
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		ft = { "python", "quarto", "markdown" }, -- lazy load
		config = function()
			-------------------------------------------------------------------
			-- Dynamic Python detection
			-------------------------------------------------------------------
			local function detect_python()
				local venv = os.getenv("VIRTUAL_ENV")
				if venv and venv ~= "" then
					return venv .. "/bin/python"
				end

				local cwd = vim.fn.getcwd()
				local local_venv = cwd .. "/.venv/bin/python"
				if vim.fn.filereadable(local_venv) == 1 then
					return local_venv
				end

				return "/usr/bin/python"
			end

			vim.g.python3_host_prog = detect_python()

			-------------------------------------------------------------------
			-- Molten settings
			-------------------------------------------------------------------
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_auto_open_output = true
			vim.g.molten_output_win_floating = true
			vim.g.molten_output_win_auto_resize = true
			vim.g.molten_output_win_max_height = math.floor(vim.o.lines * 0.7)
			vim.g.molten_output_win_max_width = math.floor(vim.o.columns * 0.8)
			vim.g.molten_output_virt_lines = false

			vim.g.molten_output_win_opts = {
				relative = "editor",
				row = 1, -- top row of editor
				col = 0, -- left-most column
				anchor = "NW", -- place window top-left
			}

			-------------------------------------------------------------------
			-- Keymaps (Hydrogen/Jupyter style)
			-------------------------------------------------------------------
			vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Init kernel" })
			vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", { desc = "Run line" })
			vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "Run cell" })
			vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Run selection" })

			vim.api.nvim_create_autocmd("BufReadPost", {
				pattern = "*.py",
				callback = function()
					if vim.b.molten_initialized then
						return
					end
					if vim.fn.search([[# %%]], "nw") ~= 0 and vim.fn.exists(":MoltenInit") == 2 then
						vim.cmd("MoltenInit")
						vim.b.molten_initialized = true
					end
				end,
			})
			vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "VimLeavePre" }, {
				pattern = "*.py",
				callback = function()
					if vim.fn.exists(":MoltenClearOutput") == 2 then
						vim.cmd("MoltenClearOutput")
					end
				end,
			})
		end,
	},

	---------------------------------------------------------------------------
	-- Jupytext — sync Python scripts with notebook format (# %%)
	---------------------------------------------------------------------------
	{
		"GCBallesteros/jupytext.nvim",
		ft = "python",
		opts = {
			style = "hydrogen",
			auto_save = false, -- avoid lag
			check_filetype = true,
		},
	},
}
