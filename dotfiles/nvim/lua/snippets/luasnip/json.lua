local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local pkm_anki = require("pkm.anki")

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
   s({ trig = "adeck", dscr = "anki deck metadata" },
      fmt([[
      {{
         "id": {card_id},
         "name": "{i1}"
      }}
      ]], {
         card_id = f(function() return tostring(pkm_anki.generate_anki_id()) end),
         i1 = i(1, "deck")
      })),
}

return {
   json = snippets,
}
