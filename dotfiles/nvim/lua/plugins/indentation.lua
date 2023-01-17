return {
  {
    "lukas-reineke/indent-blankline.nvim",
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
}
