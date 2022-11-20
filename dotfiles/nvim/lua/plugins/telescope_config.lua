local telescope = require("telescope")

local keymaps = require("keymaps")


local M = {}


M.setup = function()
  telescope.setup({
    defaults = {
      file_ignore_patterns = {
      },
      mappings = keymaps.build_telescope_config_keymaps(),
    },
  })

  telescope.load_extension("fzf")
end


return M
