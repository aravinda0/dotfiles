return {
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    event = "BufReadPre",
    opts = {
      filetype_exclude = {
        "help",
        "alpha",
        "neo-tree",
        "Trouble",
        "lazy",
        "markdown",
        "vimwiki",
      },
    },
  },
  {
    "Vimjas/vim-python-pep8-indent",
    ft = { "python" },
  },
  {
    "echasnovski/mini.indentscope",
    event = "VeryLazy",
    config = function()
      local indentscope = require("mini.indentscope")
      indentscope.setup({
        draw = {
          delay = 0,
          animation = indentscope.gen_animation.none(),
        },
      })
    end,
  },
}
