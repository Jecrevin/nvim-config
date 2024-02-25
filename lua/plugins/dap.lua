return {
	"rcarriga/nvim-dap-ui",
	event = { "BufWinEnter" },
	init = function()
		local debug = require("settings.ui").debug

		for type, color in pairs(debug.highlights) do
			vim.cmd.highlight("Dap" .. type, "guifg=" .. color)
		end

		for type, icon in pairs(debug.signs) do
			local hl = "Dap" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl })
		end
	end,
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		dapui.setup()

		local function open_dapui()
			local neotree_opened = vim.api.nvim_tabpage_get_var(0, "neotree_opened")
			if neotree_opened then
				vim.cmd("Neotree close")
				vim.api.nvim_tabpage_set_var(0, "neotree_opened", false)
			end
			dapui.open()
		end

		local function close_dapui()
			dapui.close()
			vim.api.nvim_tabpage_set_var(0, "dapui_opened", false)
		end

		dap.listeners.before.attach.dapui_config = open_dapui
		dap.listeners.before.launch.dapui_config = open_dapui
		dap.listeners.before.event_terminated.dapui_config = close_dapui
		dap.listeners.before.event_exited.dapui_config = close_dapui
	end,
	dependencies = {
		"mfussenegger/nvim-dap",
		config = function()
			local user_dap = require("settings.dap")
			local dap = require("dap")

			for adapter, opts in pairs(user_dap.adapters) do
				dap.adapters[adapter] = opts
			end

			for lang, config in pairs(user_dap.configs) do
				dap.configurations[lang] = config
			end
		end,
	},
}
