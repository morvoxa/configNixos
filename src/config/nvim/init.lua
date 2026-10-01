if vim.g.vscode then
	local vscode = require("vscode")
	local o = vim.o
	o.clipboard = "unnamedplus"
	o.ignorecase = true
	local map = vim.api.nvim_set_keymap
	vim.notify = vscode.notify
	vim.g.mapleader = " "
	map(
		"n",
		"<leader>w",
		":lua require('vscode').action('workbench.action.files.save')<cr>:lua require('vscode').notify('Saved Succesfully')<cr>",
		{ silent = true }
	)
	map("n", "<leader>t", ":lua require('vscode').action('workbench.action.terminal.focus')<cr>", { silent = true })
	map("n", "<leader>hh", ":lua require('vscode').action('notifications.clearAll')<cr>:nohl<cr>", { silent = true })
	map("n", "L", ":lua require('vscode').action('workbench.action.nextEditor')<cr>", { silent = true })
	map("n", "H", ":lua require('vscode').action('workbench.action.previousEditor')<cr>", { silent = true })
	map("n", "<leader>bd", ":lua require('vscode').action('workbench.action.closeActiveEditor')<cr>", { silent = true })
	map("n", "<leader>r", ":lua require('vscode').action('workbench.action.openRecent')<cr>", { silent = true })
	map("n", "<leader>e", ":lua require('vscode').action('workbench.view.explorer')<cr>", { silent = true })
	vim.pack.add({
		{ src = "https://github.com/folke/flash.nvim" },
	})
	vim.api.nvim_set_keymap("n", "s", '<cmd>lua require("flash").jump()<CR>', { noremap = true, silent = true })
else
	local o = vim.o
	local map = vim.api.nvim_set_keymap

	vim.g.mapleader = " "

	map("i", "jk", "<esc>", { silent = true })
	map("n", "<leader>w", ":w<cr>", { silent = true })
	map("n", "<leader>e", ":Oil<cr>", { silent = true })
	map("n", "<leader>bd", ":bd<cr>", { silent = true })
	map("n", "<C-h>", "<C-w>w", { silent = true })
	map("n", "<C-l>", "<C-w>p", { silent = true })
	map("n", "H", ":bp<cr>", { silent = true })
	map("n", "L", ":bn<cr>", { silent = true })
	map("n", "<leader>hh", ":nohl<cr>", { silent = true })

	o.number = true
	o.relativenumber = true
	o.clipboard = "unnamedplus"
	o.tabstop = 2
	o.shiftwidth = 4
	o.ignorecase = true
	vim.pack.add({
		{ src = "https://github.com/folke/flash.nvim" },
		{ src = "https://github.com/windwp/nvim-autopairs" },
		{ src = "https://github.com/stevearc/conform.nvim" },
		{ src = "https://github.com/nvim-telescope/telescope.nvim" },
		{ src = "https://github.com/nvim-lua/plenary.nvim" },
		{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
		{ src = "https://github.com/stevearc/oil.nvim" },
	})
	require("oil").setup({
		columns = {
			"icon",
			"permissions",
			"size",
			"mtime",
		},
	})

	map("n", "s", '<cmd>lua require("flash").jump()<CR>', { noremap = true, silent = true })
	require("nvim-autopairs").setup({})
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
	vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

	vim.pack.add({
		{ src = "https://github.com/folke/tokyonight.nvim" },
	})
	vim.cmd("colorscheme tokyonight")
	require("tree-sitter-manager").setup({
		auto_install = true,
	})

	require("conform").setup({
		formatters = {
			oxfmt = {
				command = function()
					local cwd = vim.fn.getcwd()
					local local_bin = cwd .. "/node_modules/.bin/oxfmt"
					return local_bin
				end,
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			toml = { "taplo" },
			bash = { "shfmt" },
			sh = { "shfmt" },
			python = { "isort", "black" },
			rust = { "rustfmt", lsp_format = "fallback" },

			javascript = { "oxfmt" },
			javascriptreact = { "oxfmt" },
			typescript = { "oxfmt" },
			typescriptreact = { "oxfmt" },
			json = { "oxfmt" },
			jsonc = { "oxfmt" },
			html = { "oxfmt" },
			css = { "oxfmt" },
			scss = { "oxfmt" },
			markdown = { "oxfmt" },
			yaml = { "oxfmt" },
			svelte = { "oxfmt" },

			c = { "clang-format" },
			cpp = { "clang-format" },
			h = { "clang-format" },

			kdl = { "kdlfmt" },
			nix= { "nixfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "never",
		},
	})
end
