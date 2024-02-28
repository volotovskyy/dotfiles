
-- alternative configuration
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--    "*.jsx,*.jsx" for multiple file types
--    pattern = "*.jsx",
--    command = "set filetype=typescriptreact",
-- })

-- Detect and set the proper file type for ReasonML files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.jsx",
	desc = "Detect and set the fake file type for JSX files",
	callback = function()
        -- set typescriptreact instead of poorly supported javascriptreact
		vim.cmd("set filetype=typescriptreact")
	end,
})
