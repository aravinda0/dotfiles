local keymaps = require("keymaps")

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    config = function()
      require("neo-tree").setup({
        window = {
          mappings = keymaps.build_neo_tree_config_keymaps(),
        },
        filesystem = {
          filtered_items = {
            always_show = {
              "debug",
            }
          }
        }
      })
    end,
  },
}
