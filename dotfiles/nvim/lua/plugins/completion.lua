local keymaps = require("keymaps")

return {
   {
      "saghen/blink.cmp",
      dependencies = { "L3MON4D3/LuaSnip" },
      opts = {
         keymap = keymaps.build_blink_cmp_config_keymaps(),

         appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono"
         },
         completion = {
            documentation = { auto_show = true },
            ghost_text = { enabled = false },
         },
         snippets = { preset = 'luasnip' },
         sources = {
            default = { "lsp", "path", "snippets", "buffer" },
         },

         -- (Default) Rust fuzzy matcher for typo resistance and significantly better
         -- performance.
         -- You may use a lua implementation instead by using `implementation = "lua"`
         -- or fallback to the lua implementation, when the Rust fuzzy matcher is not
         -- available, by using `implementation = "prefer_rust"`
         fuzzy = { implementation = "prefer_rust_with_warning" }
      },
      opts_extend = { "sources.default" }
   }
}
