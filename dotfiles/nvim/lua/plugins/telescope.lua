local keymaps = require("keymaps")

return {
   {
      "nvim-telescope/telescope.nvim",
      event = "VeryLazy",
      dependencies = {
         "nvim-lua/plenary.nvim",
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
         },
      },
      config = function()
         local telescope = require("telescope")

         telescope.setup({
            defaults = {
               file_ignore_patterns = {},
               mappings = keymaps.build_telescope_config_keymaps(),
            },
         })
         keymaps.set_telescope_keymaps()

         telescope.load_extension("fzf")
      end,
   },
}
