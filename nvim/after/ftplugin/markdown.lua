vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		-- vim.wo.spell = false
		vim.wo.conceallevel = 2
	end,
})
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "markdown",
-- 	callback = function()
-- 		vim.api.nvim_win_set_option(0, "conceallevel", 2)
-- 	end,
-- })
-- vim.api.nvim_command([[
--   augroup MarkdownConcealLevel
--     autocmd!
--     autocmd FileType markdown setlocal conceallevel=2
--   augroup END
-- ]])
