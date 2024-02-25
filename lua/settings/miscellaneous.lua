return {
	-- leader key to use for <leader>
	leader = " ",

	-- whether to use powershell for terminal or not
	powershell = vim.fn.has("Win32") == 1 and true or false,

	-- github mirror
	github = {
		download = "https://github.moeyy.xyz/https://github.com/",
		clone = "https://kkgithub.com/",
	},
}
