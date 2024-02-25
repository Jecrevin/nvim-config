vim.api.nvim_create_autocmd({ "TabEnter", "VimEnter" }, {
	callback = function()
		vim.api.nvim_tabpage_set_var(0, "neotree_opened", false)
		vim.api.nvim_tabpage_set_var(0, "dapui_opened", false)
	end,
})
