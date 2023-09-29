require("core.options")
require("core.keymaps")
require("core.plugins")
require("core.plugin_config")

vim.cmd([[
inoremap {<CR> {<CR>}<Esc>O
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha
]])

