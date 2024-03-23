vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		-- vim.wo.spell = false
		vim.wo.conceallevel = 2
	end,
})
