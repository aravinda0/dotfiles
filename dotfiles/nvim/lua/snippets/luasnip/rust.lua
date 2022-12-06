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

local snippets = {
  s({
    trig = "pr",
    dscr = "Print line",
  }, {
    t('println!("'),
    i(1),
    t('");'),
    i(0),
  }),

  s({
    trig = "pri",
    dscr = "Print value",
  }, {
    t('println!("'),
    c(1, {
      t("{}"),
      t("{:#?}"),
      t("{:?}"),
    }),
    t('", '),
    i(2),
    t(");"),
    i(0),
  }),
}

return {
  rust = snippets,
}
