return {
   enabled = true,
   'MeanderingProgrammer/render-markdown.nvim',
   dependencies = { 'nvim-treesitter/nvim-treesitter' },
   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
   ---@module 'render-markdown'
   ---@type render.md.UserConfig
   opts = {
      heading = {
         width = "block",
         min_width = { 100, 89, 80, 75, 65 },
         -- backgrounds = {
         --    -- TODO
         -- },
         -- foregrounds = {
         --    -- TODO
         -- },
      },
      code = {
         width = "block",
         min_width = 89,
      },
      bullet = {
         icons = { '●', '○', '◆', '⋄', '+', '•' },
      },
      checkbox = {
         enabled = false,
         -- TODO
      },
   },
}
