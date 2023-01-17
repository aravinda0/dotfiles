local keymaps = require("keymaps")

return {
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      keymaps.set_leap_keymaps()
    end,
  },
}
