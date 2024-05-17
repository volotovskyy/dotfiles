local nnoremap = require("user.keymap_utils").nnoremap
local vnoremap = require("user.keymap_utils").vnoremap
local inoremap = require("user.keymap_utils").inoremap
local tnoremap = require("user.keymap_utils").tnoremap
local xnoremap = require("user.keymap_utils").xnoremap
-- local harpoon_ui = require("harpoon.ui")
-- local harpoon_mark = require("harpoon.mark")
-- local harpoon_ui = require("harpoon")
-- local harppon_mark = require('harpoon').get_mark_config().marks
local harpoon = require("harpoon")
local neogit = require("neogit")
-- REQUIRED
harpoon:setup()
-- REQUIRED

local utils = require("user.utils")

local M = {}

local TERM = os.getenv("TERM")

-- Normal --
-- Disable Space bar since it'll be used as the leader key
nnoremap("<space>", "<nop>")

-- Window +  better kitty navigation
-- nnoremap("<C-j>", function()
-- 	if vim.fn.exists(":KittyNavigateDown") ~= 0 and TERM == "xterm-kitty" then
-- 		vim.cmd.KittyNavigateDown()
-- 	elseif vim.fn.exists(":NvimTmuxNavigateDown") ~= 0 then
-- 		vim.cmd.NvimTmuxNavigateDown()
-- 	else
-- 		vim.cmd.wincmd("j")
-- 	end
-- end)

-- nnoremap("<C-k>", function()
-- 	if vim.fn.exists(":KittyNavigateUp") ~= 0 and TERM == "xterm-kitty" then
-- 		vim.cmd.KittyNavigateUp()
-- 	elseif vim.fn.exists(":NvimTmuxNavigateUp") ~= 0 then
-- 		vim.cmd.NvimTmuxNavigateUp()
-- 	else
-- 		vim.cmd.wincmd("k")
-- 	end
-- end)

-- nnoremap("<C-l>", function()
-- 	if vim.fn.exists(":KittyNavigateRight") ~= 0 and TERM == "xterm-kitty" then
-- 		vim.cmd.KittyNavigateRight()
-- 	elseif vim.fn.exists(":NvimTmuxNavigateRight") ~= 0 then
-- 		vim.cmd.NvimTmuxNavigateRight()
-- 	else
-- 		vim.cmd.wincmd("l")
-- 	end
-- end)

-- nnoremap("<C-h>", function()
-- 	if vim.fn.exists(":KittyNavigateLeft") ~= 0 and TERM == "xterm-kitty" then
-- 		vim.cmd.KittyNavigateLeft()
-- 	elseif vim.fn.exists(":NvimTmuxNavigateLeft") ~= 0 then
-- 		vim.cmd.NvimTmuxNavigateLeft()
-- 	else
-- 		vim.cmd.wincmd("h")
-- 	end
-- end)
--
-- vim.api.nvim_set_keymap('n', '<D-s>', ':w<CR>', { noremap = true })
nnoremap("<leader>QQ", "<cmd>qa!<cr>")
-- vnoremap("<C-s>", "<Esc><cmd>w<cr>" -- bind conflict
-- inoremap("<C-s>", "<cmd>w<cr><Esc>")
-- mac command + Windows to save in all modes
-- nnoremap("<D-s>", "<cmd>w<cr>")
-- vnoremap("<D-s>", "<Esc><cmd>w<cr>") -- bind conflict
-- inoremap("<D-s>", "<cmd>w<cr><Esc>")
--nnoremap("<Char-0xAA>, '<cmd>write<cr>", {
--	desc = "Save current file with <command-s>",
--})
-- macos commas-s for save!
nnoremap("<Cmd-s>", "<cmd>w<cr>", { desc = "Save current file with <command-s>" })
-- Swap between last two buffers
nnoremap("<leader>'", "<C-^>", { desc = "Switch to last buffer" })

-- Save with leader key
nnoremap("<leader>w", "<cmd>w<cr>", { silent = false })

-- Quit with leader key
-- nnoremap("<leader>Q", "<cmd>q<cr>", { silent = false })

-- Save and Quit with leader key
nnoremap("<leader>qq", "<cmd>wq<cr>", { silent = false })

-- Map Oil to <leader>e
nnoremap("<leader>e", function()
	require("oil").toggle_float()
end)

-- Center buffer while navigating
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("{", "{zz")
nnoremap("}", "}zz")
nnoremap("N", "Nzz")
nnoremap("n", "nzz")
nnoremap("G", "Gzz")
nnoremap("gg", "ggzz")
nnoremap("<C-i>", "<C-i>zz")
nnoremap("<C-o>", "<C-o>zz")
nnoremap("%", "%zz")
nnoremap("*", "*zz")
nnoremap("#", "#zz")

-- Press 'S' for quick find/replace for the word under the cursor
nnoremap("S", function()
	local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end)

-- Open Spectre for global find/replace
nnoremap("<leader>S", function()
	require("spectre").toggle()
end)

-- Open Spectre for global find/replace for the word under the cursor in normal mode
-- TODO Fix, currently being overriden by Telescope
nnoremap("<leader>sw", function()
	require("spectre").open_visual({ select_word = true })
end, { desc = "Search current word" })

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
nnoremap("L", "$")
nnoremap("H", "^")

-- Press 'U' for redo
nnoremap("U", "<C-r>")

-- Turn off highlighted results
nnoremap("<leader>no", "<cmd>noh<cr>")

-- Diagnostics

-- Goto next diagnostic of any severity
nnoremap("]d", function()
	vim.diagnostic.goto_next({})
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous diagnostic of any severity
nnoremap("[d", function()
	vim.diagnostic.goto_pev({})
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto next error diagnostic
nnoremap("]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous error diagnostic
nnoremap("[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto next warning diagnostic
nnoremap("]w", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous warning diagnostic
nnoremap("[w", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Open the diagnostic under the cursor in a float window
nnoremap("<leader>di", function()
	vim.diagnostic.open_float({
		border = "rounded",
	})
end)

nnoremap("<leader>tdi", ":ToggleDiagnostics<cr>", { desc = "ToggleDiagnostics" })
nnoremap("<leader>tel", ":ToggleESLint<cr>", { desc = "ToggleESLint" })
-- Place all dignostics into a qflist
nnoremap("<leader>ld", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })

-- Navigate to next qflist item
nnoremap("<leader>cn", ":cnext<cr>zz")

-- Navigate to previos qflist item
nnoremap("<leader>cp", ":cprevious<cr>zz")

-- Open the qflist
nnoremap("<leader>co", ":copen<cr>zz")

-- Close the qflist
nnoremap("<leader>cc", ":cclose<cr>zz")

-- Map MaximizerToggle (szw/vim-maximizer) to leader-m
nnoremap("<leader>m", ":MaximizerToggle<cr>")
nnoremap("<leader>z", ":ZenMode<CR>", { desc = "ZenMode Toggle" })
-- Resize split windows to be equal size
nnoremap("<leader>=", "<C-w>=")

-- Press leader f to format
nnoremap("<leader>f", ":Format<cr>")

-- Press leader rw to rotate open windows
nnoremap("<leader>rw", ":RotateWindows<cr>", { desc = "[R]otate [W]indows" })

-- Press gx to open the link under the cursor
nnoremap("gx", ":sil !open <cWORD><cr>", { silent = true })

-- TSC autocommand keybind to run TypeScripts tsc
nnoremap("<leader>tc", ":TSC<cr>", { desc = "[T]ypeScript [C]ompile" })

-- -- Harpoon keybinds --
-- -- Open harpoon ui
-- nnoremap("<leader>ho", function()
-- 	harpoon_ui.toggle_quick_menu()
-- end)

-- -- Add current file to harpoon
-- nnoremap("<leader>ha", function()
-- 	harpoon_mark.add_file()
-- end)

-- -- Remove current file from harpoon
-- nnoremap("<leader>hr", function()
-- 	harpoon_mark.rm_file()
-- end)

-- -- Remove all files from harpoon
-- nnoremap("<leader>hc", function()
-- 	harpoon_mark.clear_all()
-- end)

-- -- Quickly jump to harpooned files
-- nnoremap("<leader>1", function()
-- 	harpoon_ui.nav_file(1)
-- end)

-- nnoremap("<leader>2", function()
-- 	harpoon_ui.nav_file(2)
-- end)

-- nnoremap("<leader>3", function()
-- 	harpoon_ui.nav_file(3)
-- end)

-- nnoremap("<leader>4", function()
-- 	harpoon_ui.nav_file(4)
-- end)

-- nnoremap("<leader>5", function()
-- 	harpoon_ui.nav_file(5)
-- end)

-- Harpoon keybinds --
-- Open harpoon ui
nnoremap("<leader>hl", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

-- Add current file to harpoon
nnoremap("<leader>ha", function()
	harpoon:list():append()
end)

-- Remove current file from harpoon
nnoremap("<leader>hr", function()
	harpoon:list():remove()
end)

-- Remove all files from harpoon
nnoremap("<leader>hc", function()
	harpoon:list():clear()
end)

-- Quickly jump to harpooned files
nnoremap("<leader>1", function()
	harpoon:list():select(1)
end)

nnoremap("<leader>2", function()
	harpoon:list():select(2)
end)

nnoremap("<leader>3", function()
	harpoon:list():select(3)
end)

nnoremap("<leader>4", function()
	harpoon:list():select(4)
end)

nnoremap("<leader>5", function()
	harpoon:list():select(5)
end)

-- Git keymaps --
nnoremap("<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
nnoremap("<leader>gbl", ":Gitsigns toggle_current_line_blame<cr>")
nnoremap("<leader>gb", ":Telescope git_branches<CR>", { silent = true })

-- nnoremap("<leader>gs", ":G<CR>")
nnoremap("<leader>gs", neogit.open, { silent = true })
-- nnoremap("<leader>gd", ":Gdiff<CR>")
nnoremap("<leader>gB", ":G blame<CR>", { silent = true })
-- nnoremap("<leader>gp", ":Git pull")
-- nnoremap("<leader>gP", ":Git push")
-- nnoremap("<leader>gcm", ":Git commit -m<CR>")
nnoremap("<leader>gaa", ":Git add .<CR>")
nnoremap("<leader>gf", function()
	local cmd = {
		"sort",
		"-u",
		"<(git diff --name-only --cached)",
		"<(git diff --name-only)",
		"<(git diff --name-only --diff-filter=U)",
	}

	if not utils.is_git_directory() then
		vim.notify(
			"Current project is not a git directory",
			vim.log.levels.WARN,
			{ title = "Telescope Git Files", git_command = cmd }
		)
	else
		require("telescope.builtin").git_files()
	end
end, { desc = "Search [G]it [F]iles" })

nnoremap("<leader>gg", ":Neogit<cr>")
nnoremap("<leader>gl", ":Neogit log<cr>")
nnoremap("<leader>gc", ":Neogit commit<CR>", { silent = true })
nnoremap("<leader>gp", ":Neogit pull<CR>")
nnoremap("<leader>gP", ":Neogit push<CR>")
-- nnoremap("<leader>gb", ":Neogit branch<cr>")
-- nnoremap("<leader>ngb", neogit.open({ "branch" }))
nnoremap("<leader>gd", ":DiffviewOpen<cr>")
nnoremap("<leader>gdm", ":DiffviewOpen master<cr>")
-- Telescope keybinds --
nnoremap("<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
nnoremap("<leader>sb", require("telescope.builtin").buffers, { desc = "[S]earch Open [B]uffers" })
nnoremap("<leader>sf", function()
	require("telescope.builtin").find_files({ hidden = true })
end, { desc = "[S]earch [F]iles" })
nnoremap("<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
nnoremap("<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })

nnoremap("<leader>sc", function()
	require("telescope.builtin").commands(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[S]earch [C]ommands" })

nnoremap("<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

nnoremap("<leader>ss", function()
	require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[S]earch [S]pelling suggestions" })

nnoremap("<leader>u", "<cmd>Telescope undo<cr>")

-- LSP Keybinds (exports a function to be used in ../../after/plugin/lsp.lua b/c we need a reference to the current buffer) --
M.map_lsp_keybinds = function(buffer_number)
	nnoremap("gd", ":Lspsaga goto_definition<cr>", { desc = "LSPsaga: go to definition", buffer = buffer_number })
	nnoremap(
		"gtd",
		":Lspsaga goto_type_definition",
		{ desc = "LSPsaga: go to type definition<cr>", buffer = buffer_number }
	)

	nnoremap("pd", ":Lspsaga peek_definition<cr>", { desc = "LSPsaga: peek definition" })
	nnoremap("ptd", ":Lspsaga peek_type_definition<cr>", { desc = "LSPsaga: peek type definition" })

	nnoremap("<leader>T", ":Lspsaga term_toggle<cr>")

	nnoremap("<leader>lo", ":Lspsaga outline<cr>", { desc = "LSPsaga: outline", buffer = buffer_number })
	nnoremap("<leader>lf", ":Lspsaga finder<cr>", { desc = "LSPsaga: finder", buffer = buffer_number })

	nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
	nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = buffer_number })

	-- vanila LSP --
	-- nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })

	-- Telescope LSP keybinds --
	nnoremap(
		"gr",
		require("telescope.builtin").lsp_references,
		{ desc = "LSP: [G]oto [R]eferences", buffer = buffer_number }
	)

	nnoremap(
		"gi",
		require("telescope.builtin").lsp_implementations,
		{ desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number }
	)

	nnoremap(
		"<leader>bs",
		require("telescope.builtin").lsp_document_symbols,
		{ desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number }
	)

	nnoremap(
		"<leader>ps",
		require("telescope.builtin").lsp_workspace_symbols,
		{ desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number }
	)

	-- See `:help K` for why this keymap
	nnoremap("K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
	nnoremap("<leader>k", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
	inoremap("<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })

	-- Lesser used LSP functionality
	nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
	nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number })
end

-- Symbol Outline keybind
nnoremap("<leader>so", ":SymbolsOutline<cr>")

-- Open Copilot panel
nnoremap("<leader>oc", function()
	require("copilot.panel").open({})
end, { desc = "[O]pen [C]opilot panel" })

-- nvim-ufo keybinds
nnoremap("zR", require("ufo").openAllFolds)
nnoremap("zM", require("ufo").closeAllFolds)

-- Obsidian --
nnoremap("<leader>oy", ":ObsidianToday -1<CR>", { desc = "date accurate ObsdidianYesterday" })
nnoremap("<leader>od", ":ObsidianToday<CR>", { desc = "daily ObsdidianToday" })
nnoremap("<leader>ot", ":ObsidianToday +1<CR>", { desc = "date accurate ObsdidianTomorrow" })
nnoremap("<leader>obl", ":ObsidianBacklinks<CR>")
nnoremap("<leader>odl", ":ObsidianDailies<CR>")
-- oc Toggle check-boxes "obsidian done"
-- of follow

-- Insert --
-- Map jj to <esc>
inoremap("jj", "<esc>")

-- Visual --
-- Disable Space bar since it'll be used as the leader key
vnoremap("<space>", "<nop>")

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vnoremap("L", "$<left>")
vnoremap("H", "^")

-- Paste without losing the contents of the register
xnoremap("<leader>p", '"_dP')
-- nnoremap("<leader>p", '"+p', { silenet = true })
-- Move selected text up/down in visual mode
vnoremap("<A-j>", ":m '>+1<CR>gv=gv")
vnoremap("<A-k>", ":m '<-2<CR>gv=gv")
vnoremap("<M-j>", ":m '>+1<CR>gv=gv")
vnoremap("<M-k>", ":m '<-2<CR>gv=gv")
-- Reselect the last visual selection
xnoremap("<<", function()
	vim.cmd("normal! <<")
	vim.cmd("normal! gv")
end)

xnoremap(">>", function()
	vim.cmd("normal! >>")
	vim.cmd("normal! gv")
end)
-- yank to the system clipboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')
nnoremap("<leader>Y", '"+Y')
-- sending register to the void (delete text without copying it)
nnoremap("<leader>d", '"_d')
vnoremap("<leader>d", '"_d')

-- Terminal --
-- Enter normal mode while in a terminal
tnoremap("<esc>", [[<C-\><C-n>]])
tnoremap("jj", [[<C-\><C-n>]])

-- Window navigation from terminal
tnoremap("<C-h>", [[<Cmd>wincmd h<CR>]])
tnoremap("<C-j>", [[<Cmd>wincmd j<CR>]])
tnoremap("<C-k>", [[<Cmd>wincmd k<CR>]])
tnoremap("<C-l>", [[<Cmd>wincmd l<CR>]])

-- Reenable default <space> functionality to prevent input delay
tnoremap("<space>", "<space>")

return M
