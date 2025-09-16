return {
	{
		"lewis6991/gitsigns.nvim",

		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			config = function()
				-- setup gitsigns with default properties
				require("gitsigns").setup({})

				-- Set a vim motion to <Space> + g + h to preview changes to the file under the cursor in normal mode
				vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "[G]it Preview [H]unk" })
			end,
		},
		{
			"tpope/vim-fugitive",
			config = function()
				-- Set a vim motion to <Space> + g + b to view the most recent contributers to the file
				vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { desc = "[G]it [B]lame" })
				-- Set a vim motion to <Space> + g + <Shift>A to all files changed to the staging area
				vim.keymap.set("n", "<leader>gA", ":Git add .<cr>", { desc = "[G]it Add [A]ll" })
				-- Set a vim motion to <Space> + g + a to add the current file and changes to the staging area
				vim.keymap.set("n", "<leader>ga", "Git add", { desc = "[G]it [A]dd" })
				-- Set a vim motion to <Space> + g + c to commit the current chages
				vim.keymap.set("n", "<leader>gc", ":Git commit", { desc = "[G]it [C]ommit" })
				-- Set a vim motion to <Space> + g + p to push the commited changes to the remote repository
				vim.keymap.set("n", "<leader>gp", "Git push", { desc = "[G]it [P]ush" })
			end,
		},
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
}
