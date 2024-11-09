local keymaps = require("keymaps")

return {
   enabled = true,
   "bullets-vim/bullets.vim",
   ft = { "markdown", "text" },
   init = function()
      keymaps.set_bullets_keymaps()
   end,
}
