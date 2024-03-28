return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				"debugloop/telescope-undo.nvim",
				"ThePrimeagen/git-worktree.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
				cond = vim.fn.executable("cmake") == 1,
			},
		},
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					layout_config = {
						-- height = 0.5, -- Adjust result height (90% of window height)
						-- preview_height = 0.5, -- Adjust preview height (60% of result height)
						-- width = 0.9, -- Adjust window width (90% of window width)
						prompt_position = "top", -- Place prompt at the top
						mirror = true, -- Mirror the layout
					},
					mappings = {
						-- https://github.com/nvim-telescope/telescope.nvim/issues/2882
						-- n = {
						-- 	["p"] = function(prompt_bufnr)
						-- 		local current_picker =
						-- 			require("telescope.actions.state").get_current_picker(prompt_bufnr)
						-- 		local text = vim.fn.getreg("+"):gsub("\n", "\\n") -- which register depends on clipboard option
						-- 		current_picker:set_prompt(text, false)
						-- 	end,
						-- },
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-x>"] = actions.delete_buffer,
						},
					},
					file_ignore_patterns = {
						"node_modules",
						"yarn.lock",
						".git",
						".sl",
						"_build",
						".next",
						".DS_Store",
					},
					hidden = true,
				},
			})

			-- Enable telescope fzf native if installed
			pcall(require("telescope").load_extension, "fzf")
			-- Enable undo if installed
			pcall(require("telescope").load_extension, "undo")
			-- Enable git worktree if installed
			pcall(require("telescope").load_extension, "git_worktree")
		end,
	},
}
