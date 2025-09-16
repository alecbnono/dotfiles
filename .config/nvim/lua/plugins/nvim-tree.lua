return {
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			vim.keymap.set("n", "\\", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle [E]xplorer" })
			require("nvim-tree").setup({
				hijack_netrw = true,
				auto_reload_on_write = true,
			})
		end,
	},
}
