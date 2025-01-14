local keymaps = require("keymaps")

return {
   {
      "mattn/emmet-vim",
      ft = { "html", "css", "sass", "typescriptreact", "javascriptreact", "svelte", "astro" },
      config = function()
         keymaps.set_emmet_keymaps()
      end,
   },
}
