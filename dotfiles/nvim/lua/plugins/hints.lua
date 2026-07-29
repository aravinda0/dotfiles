local keymaps = require("keymaps")

return {
   {
      "https://codeberg.org/andyg/leap.nvim",
      event = "VeryLazy",
      config = function()
         keymaps.set_leap_keymaps()
      end,
   },
}
