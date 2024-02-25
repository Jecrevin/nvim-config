return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"bash",
			"cpp",
			"python",
			"markdown",
		},
		sync_install = false,
		auto_install = false,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	},
	config = function(plugin, opts)
		local clone_mirror = require("settings.miscellaneous").github.clone
		if clone_mirror then
			for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
				config.install_info.url = config.install_info.url:gsub("https://github.com/", clone_mirror)
			end
		end

		require(plugin.main).setup(opts)
	end,
}
