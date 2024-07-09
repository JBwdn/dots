--[[
Jake's nvim config - 02/24
--]]


-- Maps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>;", ":")
vim.keymap.set("n", "<leader>nd", ":!mkdir ")
vim.keymap.set("n", "<leader>nf", ":!touch ")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("t", "<esc>", "<C-\\><C-n>")


-- Meta functions for formatting, linting and testing
function _G.run_file()
	local commands = {
		python = "python %",
		rust = "cargo run",
		julia = "julia %",
		sh = "bash %",
	}
	if not commands[vim.bo.filetype] then
		print("No run command for " .. vim.bo.filetype)
		return
	end
	vim.cmd("write")
	vim.cmd("Dispatch " .. commands[vim.bo.filetype])
end

function _G.format_file()
	local commands = {
		python = "isort %; black %",
		rust = "rustfmt %",
	}
	if not commands[vim.bo.filetype] then
		print("No format command for " .. vim.bo.filetype)
		return
	end
	vim.cmd("write")
	vim.cmd("!" .. commands[vim.bo.filetype])
end

function _G.lint_file()
	local commands = {
		python = "pylint %",
		rust = "cargo clippy",
	}
	if not commands[vim.bo.filetype] then
		print("No lint command for " .. vim.bo.filetype)
		return
	end
	vim.cmd("write")
	vim.cmd("Dispatch " .. commands[vim.bo.filetype])
end

function _G.test_file()
	local commands = {
		python = "pytest",
		rust = "cargo test",
	}
	if not commands[vim.bo.filetype] then
		print("No test command for " .. vim.bo.filetype)
		return
	end
	vim.cmd("write")
	vim.cmd("Dispatch " .. commands[vim.bo.filetype])
end

function _G.analyse_file()
	local commands = {
		python = "pyright %",
		rust = "cargo check",
	}
	if not commands[vim.bo.filetype] then
		print("No analyse command for " .. vim.bo.filetype)
		return
	end
	vim.cmd("Dispatch " .. commands[vim.bo.filetype])
end

function _G.launch_repl()
	local commands = {
		python = "ipython",
		julia = "julia",
	}
	if not commands[vim.bo.filetype] then
		print("No repl command for " .. vim.bo.filetype)
		return
	end
	vim.cmd("vsplit")
	vim.cmd("wincmd l")
	vim.cmd("term " .. commands[vim.bo.filetype])
	vim.cmd("wincmd h")
end


-- Notes integration
function _G.open_note()
	-- From: github.com/nvim-telescope/telescope.nvim/issues/775
	vim.cmd("tabnew")
	require('telescope.builtin').find_files {
		winblend = 5,
		border = true,
		cwd = "~/notes"
	}
end

function _G.new_note()
	-- TODO: make me useful!
	local notes_dir = "~/notes/"
	vim.cmd("tabnew")
	vim.cmd(":e ~/notes/")
end

-- File manager
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20


-- Bootstrap lazyvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


-- Plugins
require("lazy").setup({
	{"xiyaowong/transparent.nvim"},
	{
		"airblade/vim-gitgutter",
		event = "VeryLazy",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "hrsh7th/cmp-cmdline", "rcarriga/nvim-notify" },
	},
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	config = function()
	-- 		require("copilot").setup({})
	-- 	end,
	-- 	event = "VeryLazy",
	-- },
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- 	event = "VeryLazy",
	-- },
	{
		"hrsh7th/cmp-nvim-lsp",
		event = "VeryLazy"
	},
	{ "hrsh7th/nvim-cmp" },
	{
		"hrsh7th/cmp-path",
		event = "VeryLazy"
	},
	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy"
	},
	{
		"saadparwaiz1/cmp_luasnip",
		event = "VeryLazy"
	},
	{
		'junegunn/goyo.vim',
		event = "VeryLazy"
	},
	{
		"LudoPinelli/comment-box.nvim",
		event = "VeryLazy"
	},
	{ "neovim/nvim-lspconfig" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate"
	},
	{ "rebelot/kanagawa.nvim" },
	{
		"tpope/vim-commentary",
		event = "VeryLazy"
	},
	{
		"tpope/vim-dispatch",
		event = "VeryLazy"
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		event = "VeryLazy",
		branch = 'v3.x'
	},
	{
		"williamboman/mason.nvim",
		event = "VeryLazy"
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy"
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
	{
		"sourcegraph/sg.nvim",
	},
	-- {  --  CAN ONLY MOVE OUT NOT IN YET!
	-- 	"https://git.sr.ht/~swaits/zellij-nav.nvim",
	-- 	lazy = true,
	-- 	event = "VeryLazy",
	-- 	keys = {
	-- 		{ "<c-h>", "<cmd>ZellijNavigateLeft<cr>",  { silent = true, desc = "navigate left"  } },
	-- 		{ "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down"  } },
	-- 		{ "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up"    } },
	-- 		{ "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
	-- 			},
	-- 		opts = {},
	-- }
})

require("sg").setup()

-- Treesitter
require("nvim-treesitter.configs").setup {
	ensure_installed = { 
		"lua",
		"python",
		"rust",
		"bash",
		"json",
		"yaml",
		"toml",
		"markdown",
		"vimdoc",
		"terraform",
		"kdl"
	},
	highlight = {
		enable = true,
	},
}


-- Completion
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-j>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "luasnip" },
		-- { name = "copilot" },
		{ name = "cody"},
	},
})

-- Copilot
-- local copilot = require("copilot")
-- copilot.setup({
-- 	suggestion = { enabled = false },
-- 	panel = { enabled = false },
-- 	filetypes = { ["*"] = true },
-- })
-- vim.cmd("Copilot disable")


-- LSP
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
end)
lsp_zero.setup()
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		"rust_analyzer",
		"pyright",
		"lua_ls",
	},
	handlers = {
		lsp_zero.default_setup,
	},
})


-- Noice
require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = false,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = true,
	},
})


-- Lua Line
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto'
	}
}


-- Which key
local wk = require("which-key")
wk.register({
	["e"] = { "<cmd>:e .<CR>", "Explorer" },
	["b"] = { "<C-o>", "Back" },
	["N"] = { "<cmd>lua open_note()<CR>", "Notes" },
	["p"] = { "\"+p", "System paste" },
	["s"] = { "<cmd>w<CR>", "Save" },
	["T"] = { "<cmd>term<CR>", "Terminal"},
	["v"] = { "<S-v>", "V-line mode" },
	["z"] = { "<cmd>Goyo<CR>", "Zen mode" },
	[";"] = { "Command palette" }, -- Defined elsewhere...
	[","] = { "<cmd>tabnew|edit $MYVIMRC<CR>", "Edit config" },
	["<leader>"] = { "<Esc>", "Esc" },
	["c"] = { "<cmd>CodyChat<CR>", "Cody" },
	f = {
		name = "find",
		f = { "<cmd>Telescope find_files<CR>", "Files" },
		h = { "<cmd>Telescope help_tags<CR>", "Help" },
		g = { "<cmd>Telescope live_grep<CR>", "Grep" },
		d = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
		w = { "<cmd>Telescope lsp_workspace_symbols<CR>", "Workspace Symbols" },
		l = { "<cmd>Telescope lsp_references<CR>", "References" },
		o = { "<cmd>Telescope oldfiles<CR>", "History" },
	},
	g = {
		name = "go",
		t = { "gg", "Top" },
		g = { "G", "Bottom" },
		e = { "$", "EOL" },
		s = { "^", "SOL" },
		u = { "{", "Prev break" },
		d = { "}", "Next break" },
	},
	l = {
		name = "lsp",
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
		r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature" },
		h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
		i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
		f = { "<cmd>LspZeroFormat<CR>", "Format" },
	},
	n = {
		name = "new",
		d = { "Directory" },
		f = { "File" },
		n = { "<cmd>lua new_note()<CR>", "Note" },
	},
	q = {
		name = "quit",
		a = { "<cmd>qa<CR>", "Quit all" },
		f = { "<cmd>qa!<CR>", "Force quit" },
		q = { "<cmd>q<CR>", "Quit" },
		s = { "<cmd>wq<CR>", "Save & quit" },
		x = { "<cmd>tabonly|only|e .<CR>", "Close all" },
	},
	r = {
		name = "run",
		a = { "<cmd>lua analyse_file()<CR>", "Analyse" },
		b = { "{<S-v>}y<C-w>lpa<enter><C-\\><C-n><C-w>h", "Block" },
		f = { "<cmd>lua format_file()<CR>", "Format" },
		i = { "<cmd>lua launch_repl()<enter>", "Repl" },
		l = { "<cmd>lua lint_file()<CR>", "Lint" },
		p = { "<cmd>Dispatch pre-commit run --all-files<CR>", "Pre-commit" },
		r = { "<cmd>lua run_file()<CR>", "Run" },
		t = { "<cmd>lua test_file()<CR>", "Test" },
	},
	t = {
		name = "tabs",
		t = { "<cmd>tabnew|term<CR>", "Terminal" },
		n = { "<cmd>tabnew<CR>", "New tab" },
		h = { "<cmd>tabprevious<CR>", "Left" },
		l = { "<cmd>tabnext<CR>", "Right" },
		q = { "<cmd>tabclose<CR>", "Close" },
		j = { "<cmd>tabnext<CR>", "Cycle" },
		g = { "<cmd>tabnew|term lazygit<CR>", "Lazygit" },
		["1"] = { "<cmd>1tabnext<CR>", "Tab 1" },
		["2"] = { "<cmd>2tabnext<CR>", "Tab 2" },
		["3"] = { "<cmd>3tabnext<CR>", "Tab 3" },
		["4"] = { "<cmd>4tabnext<CR>", "Tab 4" },
		["5"] = { "<cmd>5tabnext<CR>", "Tab 5" },
		["6"] = { "<cmd>6tabnext<CR>", "Tab 6" },
		["7"] = { "<cmd>7tabnext<CR>", "Tab 7" },
		["8"] = { "<cmd>8tabnext<CR>", "Tab 8" },
		["9"] = { "<cmd>9tabnext<CR>", "Tab 9" },
	},
	w = {
		name = "windows",
		h = { "<C-w>h", "Left" },
		H = { "<C-w>H", "Move Left" },
		j = { "<C-w>j", "Down" },
		J = { "<C-w>J", "Move Down" },
		k = { "<C-w>k", "Up" },
		K = { "<C-w>K", "Move Up" },
		l = { "<C-w>l", "Right" },
		L = { "<C-w>L", "Move Right" },
		o = { "<C-w>o", "Close others" },
		w = { "<C-w>w", "Swich" },
		q = { "<cmd>wq<CR>", "Save & Quit"},
		r = { "<C-w>r", "Rotate" },
		s = { "<C-w>s<C-w>j", "Split" },
		t = { "<C-w>T", "Move to tab" },
		v = { "<C-w>v<C-w>l", "V-split" },
		m = {
			name = "Max",
			w = { "<C-w>|", "Width" },
			h = { "<C-w>_", "Height" },
			m = { "<C-w>|<C-w>_", "Max" },
		},
		["="] = { "<C-w>=", "Equal" },
		["<"] = { "<C-w><", "Left" },
		[">"] = { "<C-w>>", "Right" },
	},
	y = {
		name = "yank",
		["0"] = { "y0", "SOL"},
		b = { "{<S-v>}y", "Block" },
		e = { "y$", "EOL" },
		f = { "ggyG", "File" },
		l = { "yy", "Line" },
		w = { "yiw", "Word" },
		s = {
			name = "system",
			["0"] = { "\"+y0", "SOL" },
			b = { "{<S-v>}\"+y", "Block" },
			e = { "\"+y$", "EOL" },
			f = { "gg\"+yG", "File" },
			l = { "\"+yy", "Line" },
			w = { "\"+yiw", "Word" },
		},
	},
	m = {
		name = "comment",
		l = { "<cmd>CBllline<CR>", "Line"},
		m = { "<cmd>Commentary<CR>", "Toggle" },
		s = { "<cmd>CBline<CR>", "Simple Line" },
		t = { "<cmd>CBccbox<CR>", "Title" },
	}
}, { prefix = "<leader>" })


-- File types:
vim.api.nvim_create_autocmd("FileType", {
	pattern = "terraform,lua",
	command = "setlocal shiftwidth=2 tabstop=2"
})


-- Visuals
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = {
	["eol"] = "⏎",
	["tab"] = "│·",
	["trail"] = "~",
	["space"] = "·",
}
vim.opt.termguicolors = true
vim.cmd("colorscheme kanagawa-lotus")


-- Gui:
if vim.g.neovide then
	vim.g.neovide_scroll_animation_length = 0.02
	vim.g.neovide_cursor_animation_length = 0.02
	vim.keymap.set("n", "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
	vim.keymap.set("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
	vim.keymap.set("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end
