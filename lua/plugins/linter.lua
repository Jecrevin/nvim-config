return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	opts = function ()
		local opts = require("settings.linter")
		opts.events = { "BufWritePost", "BufReadPost", "InsertLeave" }
		return opts
	end,
	config = function(_, opts)
		-- plugin setup
		for key, value in pairs(opts) do
			require("lint").linters_by_ft[key] = value
		end

		vim.api.nvim_create_autocmd(opts.events, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
