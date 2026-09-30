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
            },
            -- {
            --    name = "no-vault",
            --    path = function()
            --    -- alternatively use the CWD:
            --    -- return assert(vim.fn.getcwd())
            --    return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
            --    end,
            --    overrides = {
            --    notes_subdir = vim.NIL,  -- have to use 'vim.NIL' instead of 'nil'
            --    new_notes_location = "current_dir",
            --    templates = {
            --       folder = vim.NIL,
            --    },
            --    },
            -- },
         },
         note = {
            template = "default.md",
         },
         templates = {
            folder = vim.fs.normalize(vim.fs.joinpath(vim.env["DOTFILES_PATH"], "nvim/lua/obsidian_templates")),
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
