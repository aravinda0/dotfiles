return {
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
