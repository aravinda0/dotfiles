local aerial = require("aerial")

local keymaps = require("keymaps")

local M = {}

M.setup = function()
  aerial.setup({
    layout = {
      min_width = { 80, 0.4 },
      max_width = { 160, 0.8 },
      placement = "edge",
      default_direction = "prefer_right",
    },
    show_guides = false,
    float = {
      relative = "editor",
      max_height = 0.7,
    },
    keymaps = keymaps.build_aerial_config_keymaps(),
  })
end

return M
