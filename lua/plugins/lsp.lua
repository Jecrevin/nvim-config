return {
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = { "lua_ls", "vimls" },
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			for server, configs in pairs(require("settings.lsp")) do
				require("lspconfig")[server].setup(configs)
			end
		end,
		dependencies = {
			{
				"williamboman/mason.nvim",
				cmd = "Mason",
				opts = {
					github = {
						download_url_template = (
							require("settings.miscellaneous").github.download or "https://github.com/"
						) .. "%s/releases/download/%s/%s",
					},
					ui = {
						icons = {
							package_installed = "󰗠 ",
							package_pending = "󱥸 ",
							package_uninstalled = "󱑤 ",
						},
					},
				},
			},
			{
				"neovim/nvim-lspconfig",
				init = function()
					-- diagnostic signs define
					local signs = require("settings.ui").diag_signs
					for type, icon in pairs(signs) do
						local hl = "DiagnosticSign" .. type
						vim.fn.sign_define(hl, { text = icon, texthl = hl })
					end
				end,
			},
		},
	},
	{
		-- signature information showing
		"ray-x/lsp_signature.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			bind = true,
			hint_enable = false,
			handler_opts = {
				border = "none",
			},
		},
	},
}
