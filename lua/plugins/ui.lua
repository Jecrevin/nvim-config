return {
	{
		-- ginit.vim need :Gui.. command which will be provided by this plugin
		"equalsraf/neovim-gui-shim",
		lazy = false,
	},
	{
		-- colorscheme
		"olimorris/onedarkpro.nvim",
		lazy = false,
		priority = 1000, -- Ensure it loads first
		opts = {
			styles = {
				types = "bold",
				keywords = "bold",
				comments = "italic",
				conditionals = "bold",
				virtual_text = "italic",
			},
			options = {
				cursorline = true,
			},
		},
	},
	{
		-- file explorer
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		opts = {
			close_if_last_window = false,
			source_selector = {
				statusline = true,
			},
			window = {
				mappings = {
					["<space>"] = "none",
					["[b"] = "prev_source",
					["]b"] = "next_source",
				},
			},
			event_handlers = {
				{
					event = "neo_tree_window_before_open",
					handler = function()
						local neotree_opened = vim.api.nvim_tabpage_get_var(0, "neotree_opened")
						vim.api.nvim_tabpage_set_var(0, "neotree_opened", not neotree_opened)
					end,
				},
				{
					event = "neo_tree_window_after_close",
					handler = function()
						local neotree_opened = vim.api.nvim_tabpage_get_var(0, "neotree_opened")
						vim.api.nvim_tabpage_set_var(0, "neotree_opened", not neotree_opened)
					end,
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
	{
		-- show open buffers on the top of window
		"akinsho/bufferline.nvim",
		version = "*",
		event = "BufWinEnter",
		opts = {
			options = {
				close_command = function(bufnum)
					local is_neotree_show = vim.api.nvim_tabpage_get_var(0, "neotree_opened")
					if is_neotree_show and vim.fn.bufnr() == bufnum then
						vim.cmd("bprevious")
					end
					vim.cmd(string.format("bdelete! %d", bufnum))
				end,
				right_mouse_command = "vsplit",
				middle_mouse_command = "BufferLineCloseOthers",
				offsets = {
					{
						filetype = "neo-tree",
						text = "NeoTree",
						highlight = "MoreMsg",
						separator = true,
					},
				},
			},
		},
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		-- statusline butify
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		opts = {
			options = {
				component_separators = { left = "\\", right = "/" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "neo-tree" },
				},
			},
			extensions = { "nvim-dap-ui", "toggleterm", "mason", "lazy" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		-- git signs
		"lewis6991/gitsigns.nvim",
		event = "BufWinEnter",
		config = true,
	},
	{
		-- startup screen
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("settings.ui").dashboard

			local function dashboard_entry(icon, desc, key, action)
				local width = dashboard.entry_width
				local n = width - 6 - #desc - #key
				return {
					icon = icon .. string.rep(" ", 2),
					desc = desc .. string.rep(" ", n),
					key = key,
					action = action,
				}
			end

			local header = dashboard.header
			for _ = 1, dashboard.padding do
				table.insert(header, 1, "")
				table.insert(header, "")
			end

			return {
				theme = "doom",
				config = {
					header = header,
					center = {
						dashboard_entry("󰈞 ", "Find Files", "f", "Telescope find_files"),
						dashboard_entry("󰙰 ", "Recent Files", "r", "Telescope oldfiles"),
						dashboard_entry(" ", "Lazygit GUI", "g", "LazyGit"),
						dashboard_entry("󰒲 ", "Open Lazy GUI", "l", "Lazy"),
						dashboard_entry("󰏖 ", "Open Mason GUI", "m", "Mason"),
						dashboard_entry(" ", "Quit Neovim", "q", "qa!"),
					},
				},
			}
		end,
		init = function()
			-- setting highlights for dashboard
			local highlight = require("settings.ui").dashboard.highlights
			for hl, color in pairs(highlight) do
				vim.cmd.highlight("Dashboard" .. hl, "guifg=" .. color)
			end
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
