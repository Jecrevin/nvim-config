return {
	{
		-- lsp for developing neovim
		"folke/neodev.nvim",
		lazy = false,
		cond = function()
			local path = vim.fn.getcwd()
			local is_nvim = path == vim.fn.stdpath("config") or path == vim.fn.stdpath("data")
			return is_nvim and true or false
		end,
		opts = {},
	},
	{
		-- auto pair brace {}, quote "" & '' and square bracket []
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		-- powerful search tool
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		-- keybinding popup menu
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		-- terminal integration
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = "ToggleTerm",
		keys = function(self, _)
			return self.opts.open_mapping
		end,
		opts = {
			direction = "float",
			open_mapping = [[<C-\>]],
		},
	},
	{
		-- provide a easier way to comment codes
		"numToStr/Comment.nvim",
		event = { "BufWinEnter" },
	},
	{
		-- lazygit gui integration
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
