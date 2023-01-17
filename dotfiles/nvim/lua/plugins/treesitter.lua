local keymaps = require("keymaps")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "css",
          "dockerfile",
          "gitcommit",
          "help",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "nix",
          "python",
          "query",
          "regex",
          "rust",
          "sql",
          "terraform",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        sync_install = false,

        highlight = {
          enable = true,
          disable = {
            -- Handled by vimwiki for now
            "markdown",
          },
        },

        -- `indent` is experimental. Disabled for some langs.
        --  Track issue: https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
        indent = {
          enable = true,
          disable = { "python", "yaml" },
        },

        -- textobjects = {
        --   select = {
        --     enable = true,
        --     lookahead = true,
        --     keymaps = keymaps.build_textobject_keymaps(),
        --   },
        -- },
      })
    end,
  },
}
