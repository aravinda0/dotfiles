local M = {}


M.setup = function()
  require("indent_blankline").setup({
    filetype_exclude = { "markdown", "vimwiki" }
  })
end


return M
