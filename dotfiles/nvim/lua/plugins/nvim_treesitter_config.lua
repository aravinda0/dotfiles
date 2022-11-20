local M = {}


M.setup = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    sync_install = false,
    highlight = {
      enable = true,
    },

    -- `indent` is experimental. Disabled for some langs.
    --  Track issue: https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
    indent = {
      enable = true,
      disable = { "python", "yaml" }
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        }
      },
    },
  })
end


return M
