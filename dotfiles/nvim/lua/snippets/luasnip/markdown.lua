local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local sn = luasnip.snippet_node
local isn = luasnip.indent_snippet_node
local f = luasnip.function_node
local c = luasnip.choice_node
local d = luasnip.dynamic_node
local r = luasnip.restore_node

local snippets = {
   s({
      trig = "note",
      dscr = "Template for a new note",
   }, {
      t("# "),
      i(1, "New note"),
      t({ "", "", "" }),
      i(0),
      t({ "", "", "" }),
      t({
         "-------------------------------------------------------------------------------- ",
         "",
         "",
      }),
      t("## Links"),
      t({ "", "", "", "" }),
      t("## References"),
   }),

   s({
      trig = "jj",
      dscr = "Journal format",
   }, {
      t("# "),
      f(function()
         return os.date("%d %b %Y - %a")
      end),
      t({ "", "", "" }),
      i(0),
   }),

   s({
      trig = "vh",
      dscr = "vomit heading",
   }, {
      t({
         "## 🤮🤮🤮",
         "",
         "",
      }),
      i(0),
   }),

   s({ trig = "acard", dscr = "anki card", },
      fmt([[
      # Card

      ## Question

      {i1}


      ## Answer
      ]], {
         i1 = i(0),
      })
   ),
}

return {
   markdown = snippets,
}
