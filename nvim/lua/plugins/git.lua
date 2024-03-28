return {
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"ThePrimeagen/git-worktree.nvim",
		-- Creates a worktree.  Requires the path, branch name, and the upstream
		-- Example:
		-- :lua require("git-worktree").create_worktree("feat-69", "master", "origin")

		-- switches to an existing worktree.  Requires the path name
		-- Example:
		-- :lua require("git-worktree").switch_worktree("feat-69")

		-- deletes to an existing worktree.  Requires the path name
		-- Example:
		-- :lua require("git-worktree").delete_worktree("feat-69")
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			-- "ibhagwan/fzf-lua",              -- optional
		},
		-- config = true,
		config = function()
			require("neogit").setup({
				kind = "floating",
				popup = { kind = "floating" }, -- split
				commit_editor = { kind = "floating" }, -- auto
				commit_select_view = {
					kind = "floating", -- tab
				},
				commit_view = {
					kind = "floating", -- vsplit
					verify_commit = os.execute("which gpg") == 0, -- Can be set to true or false, otherwise we try to find the binary
				},
				preview_buffer = {
					kind = "floating", -- split
				},
				log_view = {
					kind = "floating", -- split
				},
				reflog_view = {
					kind = "floating", -- split
				},
			})
		end,
	},
}
