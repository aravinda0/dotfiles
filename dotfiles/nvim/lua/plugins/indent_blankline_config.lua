local M = {}

M.setup = function()
  require("indent_blankline").setup({
    use_treesitter = true,
    filetype_exclude = { "markdown", "vimwiki" },
  })
end

return M
