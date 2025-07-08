return {
   enabled = true,
   'MeanderingProgrammer/render-markdown.nvim',
   dependencies = { 'nvim-treesitter/nvim-treesitter' },
   ft = { "markdown", "codecompanion", },
   opts = {
      heading = {
         width = "block",
         min_width = { 100, 89, 80, 75, 65 },
         backgrounds = {
            "", -- disable default weird dark bg for h1
         },
         -- foregrounds = {
         --    -- TODO
         -- },
      },
      code = {
         width = "block",
         border = "thick",
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
