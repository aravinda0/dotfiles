local M = {}

M.setup = function()
  require("nvim-autopairs").setup({
    check_ts = true,
  })
end

return M
