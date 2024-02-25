local colors = require("onedarkpro.helpers").get_colors()

return {
	-- colorscheme
	colorscheme = "onedark",

	-- kind icons used for cmp popup menu
	kind_icons = {
		Text = "󰦨",
		Method = "󰆧",
		Function = "󰊕",
		Constructor = "",
		Field = "",
		Variable = "󰫧",
		Class = "",
		Interface = "",
		Module = "󰅩",
		Property = "",
		Unit = "",
		Value = "󰎠",
		Enum = "",
		Keyword = "",
		Snippet = "󰆐",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "󰬴",
		Constant = "󰏿",
		Struct = "",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "",
	},

	-- diagnostic signs
	diag_signs = { Error = " ", Warn = "󰀩 ", Hint = " ", Info = "󰋼 " },

	debug = {
		-- debug signs
		signs = { Breakpoint = " ", Stopped = " " },
		highlights = { Breakpoint = colors.red, Stopped = colors.green },
	},

	dashboard = {
		-- dashboard header
		header = {
			[[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
			[[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
			[[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
			[[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
			[[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
			[[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
		},
		-- dashboard entry width
		entry_width = 50,
		-- dashboard padding
		padding = 3,
		highlights = {
			Header = colors.purple,
			Desc = colors.purple,
			Icon = colors.green,
			Key = colors.yellow,
		},
	},
}
