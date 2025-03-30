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
         local lua_snippets = require("snippets.luasnip.lua")
         local markdown_snippets = require("snippets.luasnip.markdown")
         local javascript_snippets = require("snippets.luasnip.javascript")
         local json_snippets = require("snippets.luasnip.json")

         luasnip.add_snippets("python", python_snippets.python)
         luasnip.add_snippets("rust", rust_snippets.rust)
         luasnip.add_snippets("javascript", javascript_snippets.javascript)
         luasnip.add_snippets("typescript", javascript_snippets.javascript)
         luasnip.add_snippets("svelte", javascript_snippets.javascript)
         luasnip.add_snippets("lua", lua_snippets.lua)
         luasnip.add_snippets("markdown", markdown_snippets.markdown)
         luasnip.add_snippets("vimwiki", markdown_snippets.markdown)
         luasnip.add_snippets("json", json_snippets.json)

         -- Lazy load general snippets and custom ones
         require("luasnip.loaders.from_vscode").lazy_load()
      end,
   },
}
