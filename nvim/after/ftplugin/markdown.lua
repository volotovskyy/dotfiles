vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		local current_file_path = vim.fn.expand("%:p:h")
		local desired_path_pattern = "/Users/yu/Library/Mobile Documents/iCloud~md~obsidian/Documents/Sanctaphrax/"

		if current_file_path:find(desired_path_pattern, 1, true) then
			vim.wo.conceallevel = 2
		else
			vim.wo.conceallevel = 0
		end
	end,
})
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "markdown" },
-- 	callback = function()
-- 		if
-- 			vim.fn
-- 				.expand("%:p:h")
-- 				:match("Users/yu/Library/Mobile Documents/iCloud~md~obsidian/Documents/Sanctaphrax/**.md")
-- 		then
-- 			vim.wo.conceallevel = 2
-- 		end
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "markdown" },
-- 	callback = function()
-- 		local file_path = vim.fn.expand("%:p:h")
-- 		local desired_path = "/Users/yu/Library/Mobile Documents/iCloud~md~obsidian/Documents/Sanctaphrax/"
-- 		if file_path:find(desired_path, 1, true) then
-- 			vim.wo.conceallevel = 2
-- 		end
-- 	end,
-- })
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "markdown",
-- 	callback = function()
-- 		vim.api.nvim_win_set_option(0, "conceallevel", 2)
-- 	end,
-- })
-- Errorr
-- vim.api.nvim_command([[
--   augroup MarkdownConcealLevel
--     autocmd!
--     autocmd FileType markdown setlocal conceallevel=2
--   augroup END
-- ]])
