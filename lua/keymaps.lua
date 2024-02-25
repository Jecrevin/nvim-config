local map = vim.keymap.set

-----------------------------general user mapping------------------------------
map("n", "<space>", "<Nop>")

-- buffer switch
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- file save
map("n", "<C-s>", "<cmd>write<cr>", { desc = "Save file" })

-- insert mode cursor move
map("i", "<C-h>", "<Left>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-l>", "<Right>")

-- insert mode new line
map("i", "<C-CR>", "<Esc>o", { desc = "New line below" })
map("i", "<C-S-CR>", "<Esc>O", { desc = "New line above" })

---------------------------------lsp mapping-----------------------------------
-- global mapping
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- buffer local mapping
		local opts = function(opts)
			opts = opts or {}
			opts.buffer = ev.buf
			return opts
		end
		map("n", "gD", vim.lsp.buf.declaration, opts({ desc = "Goto declaration" }))
		map("n", "gd", vim.lsp.buf.definition, opts({ desc = "Goto definition" }))
		map("n", "gi", vim.lsp.buf.implementation, opts({ desc = "Goto implementation" }))
		map("n", "<leader>dr", vim.lsp.buf.references, opts({ desc = "Show references" }))
		map("n", "<leader>dc", vim.lsp.buf.code_action, opts({ desc = "Code action" }))
		map("n", "K", vim.lsp.buf.hover, opts({ desc = "Hover infomation" }))
		map("n", "<C-k>", vim.lsp.buf.signature_help, opts({ desc = "Signature help" }))
	end,
})

----------------------------plugin related mapping-----------------------------
-- neo-tree.nvim
map("n", "<leader>t", "<cmd>Neotree toggle<cr>", { desc = "Toggle neotree" })

-- telescope.nvim
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })

-- lazygit.nvim
map("n", "<leader>g", "<cmd>LazyGit<cr>", { desc = "Goto lazygit GUI" })

-- formatter.nvim
map("n", "<A-S-f>", "<cmd>Format<cr>", { desc = "Format" })

-- dapui.nvim
map("n", "<leader>b", function()
	-- if neo-tree is present and is currently open in tabpage, close it.
	if vim.api.nvim_tabpage_get_var(0, "neotree_opened") then
		vim.cmd([[Neotree close]])
	end

	local dapui_opened = vim.api.nvim_tabpage_get_var(0, "dapui_opened")
	require("dapui").toggle()
	vim.api.nvim_tabpage_set_var(0, "dapui_opened", not dapui_opened)
end, { desc = "Toggle debug" })

-- nvim-dap
map("n", "<F9>", require("dap").toggle_breakpoint, { desc = "Toggle breakpoint" })
map("n", "<F5>", require("dap").continue, { desc = "Debug start/resume" })
map("n", "<F10>", require("dap").step_over, { desc = "Debug step over" })
map("n", "<F11>", require("dap").step_into, { desc = "Debug step into" })
map("n", "<S-F11>", require("dap").step_out, { desc = "Debug step out" })
