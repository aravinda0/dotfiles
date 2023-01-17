return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")

      -- TODO: Generalize this code to look in snippets dir and auto-load
      local python_snippets = require("snippets.luasnip.python")
      local rust_snippets = require("snippets.luasnip.rust")

      luasnip.add_snippets("python", python_snippets.python)
      luasnip.add_snippets("rust", rust_snippets.rust)

      -- Lazy load general snippets and custom ones
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
