local luasnip = require("luasnip")


local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local sn = luasnip.snippet_node
local isn = luasnip.indent_snippet_node
local f = luasnip.function_node
local c = luasnip.choice_node
local d = luasnip.dynamic_node
local r = luasnip.restore_node


snippets = {
  s({
    trig="pr",
    dscr="Print function"
  }, {
      t("print(\""), i(1),
      t("\")"), i(0)
  }),
}


return {
  python = snippets,
}
