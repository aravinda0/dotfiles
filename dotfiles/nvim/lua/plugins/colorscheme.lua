return {
  {
    "savq/melange-nvim",

    lazy = false,
    priority = 1000,

    config = function()
      vim.cmd([[colorscheme melange]])
    end,
  },
  {
    "sainnhe/gruvbox-material",
    ft = { "markdown" },

    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
}
