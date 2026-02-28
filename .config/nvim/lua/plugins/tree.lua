return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
			vim.keymap.set("n", "\\", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle [E]xplorer" })
			require("nvim-tree").setup({
				hijack_netrw = true,
				auto_reload_on_write = true,
			})
		end,
}
