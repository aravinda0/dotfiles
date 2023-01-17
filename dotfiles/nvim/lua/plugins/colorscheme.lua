return {
  {
    "sainnhe/gruvbox-material",
    enabled = false,

    lazy = false,
    priority = 1000,

    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1

      vim.cmd([[colorscheme melange]])
    end,
  },
  {
    "savq/melange-nvim",

    lazy = false,
    priority = 1000,

    config = function()
      vim.cmd([[colorscheme melange]])
    end,
  },
}