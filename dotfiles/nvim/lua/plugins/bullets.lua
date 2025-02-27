local keymaps = require("keymaps")

return {
   enabled = true,
   "bullets-vim/bullets.vim",
   ft = { "markdown", "text" },
   init = function()
      -- Disable raw symbol tweaking. Let render-markdown handle it virtually.
      vim.g.bullets_outline_levels = {}

      keymaps.set_bullets_keymaps()
   end,
}
