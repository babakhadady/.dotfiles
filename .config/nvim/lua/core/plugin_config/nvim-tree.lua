vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	auto_reload_on_write = true,
	view = {
		side = "left",
		width = 30,
	}
})

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
