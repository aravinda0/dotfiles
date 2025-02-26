local keymaps = require("keymaps");

return {
   enabled = true,
   "epwalsh/obsidian.nvim",
   version = "*", -- recommended, use latest release instead of latest commit
   lazy = true,
   ft = "markdown",
   dependencies = {
      "nvim-lua/plenary.nvim",
   },
   config = function()
      require("obsidian").setup({
         workspaces = {
            {
               -- Use obsidian.nvim for any markdown files, not restricted to
               -- workspace dirs. This is done by dynamically marking the current
               -- parent dir as a workspace.
               name = "no-vault",
               path = function()
                  return assert(vim.fn.getcwd())

                  -- Alternatively use the current buffer's parent
                  -- return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
               end,
               overrides = {
                  notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
                  new_notes_location = "current_dir",
                  templates = {
                     subdir = vim.NIL,
                  },
                  disable_frontmatter = true,
               },
            },
         },
         daily_notes = {
            folder = "diary",
            alias_format = "%d %b %Y - %a",
         },
         follow_url_func = function(url)
            vim.ui.open(url)
         end,
         ui = {
            enable = false,
         }
      })

      keymaps.set_obsidian_keymaps();
   end
}
