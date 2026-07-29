local keymaps = require("keymaps");

return {
   enabled = true,
   "obsidian-nvim/obsidian.nvim",
   version = "*", -- recommended, use latest release instead of latest commit
   lazy = true,
   ft = "markdown",
   dependencies = {
      "nvim-lua/plenary.nvim",
   },
   config = function()
      require("obsidian").setup({
         legacy_commands = false,
         workspaces = {
            {
               name = "default",
               path = vim.env["_F"],
            }
         },
         daily_notes = {
            folder = "j/diary",
            alias_format = "%d %b %Y - %a",
         },
         frontmatter = {
            enabled = false,
         },
         ui = {
            enable = false,
         },
      })

      keymaps.set_obsidian_keymaps();
   end
}
