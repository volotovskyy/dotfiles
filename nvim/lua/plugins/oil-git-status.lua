return {
  {

    "refractalize/oil-git-status.nvim",

    dependencies = {
      "stevearc/oil.nvim",
    },

    config = function()
      require('oil-git-status').setup({
        show_ignored = false -- show files that match gitignore with !!
      })
    end
  }
}
