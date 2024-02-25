local options = {
	-- line number display
	number = true,

	-- cursor line highlight
	cursorline = true,

	-- TUI colors (support for some nvim themes)
	termguicolors = true,

	-- indent behaviour
	shiftwidth = 4,
	tabstop = 4,
	autoindent = true,
	smartindent = true,
	smarttab = true,

	-- split behaviour
	splitbelow = true,
	splitright = true,

	-- use system clipboard
	clipboard = "unnamedplus",

	-- command timeout
	timeoutlen = 300,
}

-- use powershell if specified in settings
local use_pwsh = require("settings.miscellaneous").powershell
if type(use_pwsh) == "function" then
	use_pwsh = use_pwsh()
end
if use_pwsh then
	options.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
	options.shellcmdflag =
		"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	options.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
	options.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	options.shellquote = ""
	options.shellxquote = ""
end

return options
