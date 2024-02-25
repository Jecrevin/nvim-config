return {
	"mhartington/formatter.nvim",
	cmd = "Format",
	opts = function()
		local opts = require("settings.formatter")
		return opts
	end,
}
