---OPTIONS
vim.g.mapleader = ' '
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.undofile = true
vim.opt.incsearch = true

vim.keymap.set({'n','v'}, '<leader>Y', '"+yy')
vim.keymap.set({'n','v'}, '<leader>y', '"+y')

vim.keymap.set({'n','v'}, '<leader>d', '"_d')
vim.keymap.set({'n','v'}, '<leader>D', '"_dd')

vim.keymap.set({'n','v'}, '<leader>p', '"_dp')
vim.keymap.set({'n','v'}, '<leader>P', '"_dP')

vim.keymap.set({'n','v'}, '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

vim.pack.add {
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range('v2.*') },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/nvim-mini/mini.ai' },
	{ src = 'https://github.com/nvim-mini/mini.surround' },
	{ src = 'https://github.com/nvim-mini/mini.pairs' },
	{ src = 'https://github.com/nvim-mini/mini.icons' },
	{ src = 'https://github.com/nvim-mini/mini.extra' },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	{ src = 'https://github.com/nvim-lualine/lualine.nvim' },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
}

require('nvim-treesitter.configs').setup({
	ensure_installed = { 'python', 'lua', 'vim', 'vimdoc', 'markdown' },
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
	ignore_install = { 'org' },
})
require('lualine').setup({})
-- LSP
vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move to window using teh <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Telescope
local actions = require('telescope.actions')
require('telescope').setup({
	defaults = {
		mappings = {
			i = {
				['<esc>'] = actions.close
			},
		},
		layout_strategy = "bottom_pane",
		file_ignore_patterns = {
			"venv"
		}
	}
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtin.git_files, { desc = "Telescope [S]earch [F]iles" })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = "Telescope [S]earch [F]iles" })
vim.keymap.set('n', '<leader>\\', builtin.buffers, { desc = "Telescope [S]earch [B]uffers" })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = "Telescope [S]earch [Q]uickfix" })
vim.keymap.set('n', '<leader>ss', builtin.lsp_dynamic_workspace_symbols, {})

-- vim.keymap.set('n', '<leader>sl', builtin.live_grep, { desc = "Telescope [S]earch [L]ive grep" })
-- vim.keymap.set('n', '<leader>s/', builtin.current_buffer_fuzzy_find,
--   { desc = "Telescope [S]earch [/] Current Buffer" })
-- vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = "Telescope [S]earch [B]uffers" })
-- vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = "Telescope [S]earch [H]elp" })
-- vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = "Telescope [S]earch [K]eymaps" })
-- vim.keymap.set('n', 'grr', function() builtin.lsp_references({layout_strategy="flex"}) end, { noremap = true, silent = true })
--
-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
vim.keymap.set(
	"n",
	"<leader><esc>",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / Clear hlsearch / Diff Update" }
)
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- commenting
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })


vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
-- vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })


---Packages

-- LSP & MASON
require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
	ensure_installed = {
		"lua_ls",
		"basedpyright",
		"vue_ls",
	}
})
vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
			}
		}
	}
})
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "require" }
			}
		}
	}
})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		-- if client:supports_method("textDocument/implementation") then
		--
		-- end
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { atuotrigger = true })
		end
	end,
})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
-- vim.keymap.set('n','<leader>cl',vim.lsp.buf.info,{})

vim.cmd("set completeopt+=noselect")


vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

--
vim.keymap.set({ 'i' }, '<C-K>', function() require('luasnip').expand() end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-L>', function() require('luasnip').jump(1) end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-J>', function() require('luasnip').jump(-1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if require('luasnip').choice_active() then
		require('luasnip').change_choice(1)
	end
end, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load()

-- MINI setup
require('mini.icons').setup()
require('mini.ai').setup()
require('mini.surround').setup()
require('mini.pairs').setup()
-- require('mini.pick').setup()
require('mini.extra').setup()

-- vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
-- vim.keymap.set('n', '<leader>h', ":Pick help<CR>")


-- Oil
require('oil').setup({
	view_options = {
		show_hidden = true,
	},
	use_default_keymaps = false,
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	keymaps = {
		["g?"] = { "actions.show_help", mode = "n" },
		["<CR>"] = "actions.select",
		-- ["<C-s>"] = { "actions.select", opts = { vertical = true } },
		-- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
		-- ["<C-t>"] = { "actions.select", opts = { tab = true } },
		["<C-p>"] = "actions.preview",
		["<C-c>"] = { "actions.close", mode = "n" },
		-- ["<C-l>"] = "actions.refresh",
		["-"] = { "actions.parent", mode = "n" },
		["_"] = { "actions.open_cwd", mode = "n" },
		["`"] = { "actions.cd", mode = "n" },
		["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
		["gs"] = { "actions.change_sort", mode = "n" },
		["gx"] = "actions.open_external",
		["g."] = { "actions.toggle_hidden", mode = "n" },
		["g\\"] = { "actions.toggle_trash", mode = "n" },
	},
})
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
vim.keymap.set('n', '-', "<cmd>Oil<CR>")

---Undo
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

---GIT
---
require('gitsigns').setup({
})

---Themes
vim.cmd [[colorscheme tokyonight-night]]
