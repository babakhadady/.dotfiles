local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

require("mason").setup()
mason_lspconfig.setup({
	ensure_installed = { "lua_ls", "clangd", "cmake", "cssls", "html", "jsonls", "jdtls", "quick_lint_js",
		"marksman", "jedi_language_server", "tsserver", "pyright", }
})

lspconfig.pyright.setup{}
lspconfig.cssls.setup{}
lspconfig.clangd.setup{}

vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])

local on_attach = function(_, _)
end


lspconfig.lua_ls.setup {
	on_attach = on_attach
}

lspconfig.clangd.setup {
	on_attach = on_attach
}

lspconfig.tsserver.setup {
	on_attach = on_attach
}


vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		local opts = { buffer = ev.buf }

		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
	end


})

local use = require('packer').use
require('packer').startup(function()
end)

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
		['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
		-- C-b (back) C-f (forward) for snippet placeholder navigation.
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
}
