if vim.g.vscode then
	return
end

local settings = require("settings.miscellaneous")
local options = require("options")

local github = settings.github.clone or "https://github.com/"

-- set leader key
vim.g.mapleader = settings.leader

-- load Neovim options
for key, value in pairs(options) do
	vim.opt[key] = value
end

-- load lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		github .. "folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup("plugins", {
	default = { lazy = true },
	git = { url_format = github .. "%s.git" },
})

-- load colorscheme
local colorscheme = require("settings.ui").colorscheme
if not pcall(vim.cmd.colorscheme, colorscheme) then
	vim.notify("Colorscheme " .. colorscheme .. " not found!", vim.log.levels.WARN)
end

-- load autocmd
require("autocmd")

-- load keymaps
require("keymaps")
