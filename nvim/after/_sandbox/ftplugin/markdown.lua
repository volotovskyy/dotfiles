-- set * for all OR *.json,*.md to list
-- autocmd InsertEnter *.md set conceallevel=2

-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
-- 	pattern = "*.md",
-- 	desc = "Detect and set custom concellevel for markdown files",
-- 	callback = function()
-- 		vim.cmd("set conceallevel=2")
-- 	end,
-- })

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
-- 	pattern = { "*.md", "*.json" },
-- 	callback = function()
-- 		vim.cmd("set conceallevel=2")
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
-- 	pattern = { "*.md", "*.json" },
-- 	callback = function()
-- 		vim.cmd("set conceallevel=0")
-- 	end,
-- })
--
-- Set conceallevel to 2 for markdown and JSON files initially
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "*.md", "*.json" },
-- 	callback = function()
-- 		vim.opt_local.conceallevel = 2
-- 	end,
-- })
--
-- -- Reset conceallevel to 0 for other filetypes initially
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.bo.filetype ~= "markdown" and vim.bo.filetype ~= "json" then
-- 			vim.opt_local.conceallevel = 0
-- 		end
-- 	end,
-- })
--
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		-- vim.wo.spell = false
		vim.wo.concellevel = 2
	end,
})
