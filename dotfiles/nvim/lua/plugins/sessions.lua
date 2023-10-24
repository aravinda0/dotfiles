return {
  {
    "olimorris/persisted.nvim",
    config = function()
      require("persisted").setup({
        autoload = true,
        ignored_dirs = {
          -- NOTE: The paths specified here also affect subdirectories. So specifying
          -- vim.env["HOME"] will effectively disable everyting under home dir

          vim.env["_H"],
          vim.env["HOME"] .. "/Downloads",

          -- NOTE: This seems to mess things up when path has '/tmp' somewhere? eg.
          -- '/x/y/z/tmp':mental health
          -- "/tmp",
        },
      })
      require("telescope").load_extension("persisted")
    end,
  },
}
