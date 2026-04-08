return {
	{
		"3rd/image.nvim",
		enabled = (os.getenv("TERM") or ""):find("kitty") ~= nil
			or (os.getenv("TERM_PROGRAM") or ""):find("kitty") ~= nil,
		opts = {
			backend = "kitty",
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			editor_only_render_when_focused = true,
			tmux_show_only_in_active_window = true,
		},
	},
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		ft = { "python", "quarto", "markdown" },
		config = function()
			-- python3_host_prog is set early in config/options.lua

			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_auto_open_output = true
			vim.g.molten_output_win_floating = true
			vim.g.molten_output_win_auto_resize = true
			vim.g.molten_output_win_max_height = math.floor(vim.o.lines * 0.7)
			vim.g.molten_output_win_max_width = math.floor(vim.o.columns * 0.8)
			vim.g.molten_output_virt_lines = false

			vim.g.molten_output_win_opts = {
				relative = "editor",
				row = 1,
				col = 0,
				anchor = "NW",
			}

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
	{
		"goerz/jupytext.nvim",
		opts = {
			format = "py:percent",
			autosync = true,
			sync_patterns = { "*.py" },
		},
	},
}
