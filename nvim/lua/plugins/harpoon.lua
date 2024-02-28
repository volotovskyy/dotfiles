return {
    {
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
		require("harpoon"):setup()
		end,
		-- keys = {
		-- 	{ "<leader>ho",
		-- 		function()
		-- 			local harpoon = require("harpoon")
		-- 			harpoon.ui:toggle_quick_menu(harpoon:list())
		-- 		end,
		-- 		desc = "harpoon toggle menu",
		-- 	},
		-- 	{ "<leader>ha", function() require("harpoon"):list():append() end, desc = "harpoon add file", },
		-- 	{ "<leader>hr", function() require("harpoon"):list():remove() end, desc = "harpoon remove file" },
		-- 	--   { "<leader>a", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
		-- 	{ "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
		-- 	{ "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
		-- 	{ "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
		-- 	{ "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
		-- 	{ "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
		-- 	-- Toggle previous & next buffers stored within Harpoon list
		-- 	{ "n", "<C-S-P>", function() harpoon:list():prev() end), }
		-- 	{ "n", "<C-S-N>", function() harpoon:list():next() end }
		-- }
	}
}

-- Harpoon keybinds --
-- Open harpoon ui


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
--     },
--   },