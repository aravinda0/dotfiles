local keymaps = require("keymaps")


return {
  {
    "LeonHeidelbach/trailblazer.nvim",
    event = "VeryLazy",
    config = function()
      require("trailblazer").setup({
        trail_options = {
          mark_symbol = "•",
          newest_mark_symbol = "",
          cursor_mark_symbol = "",
          next_mark_symbol = "",
          previous_mark_symbol = "",
        },
        force_mappings = keymaps.build_trailblazer_keymaps(),
      })
    end,
  },
}
