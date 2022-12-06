local M = {}

M.setup = function()
  require("lualine").setup({
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        "diff",
        { "diagnostics", sources = { "nvim_diagnostic" } },
      },
      lualine_c = { { "filename", file_status = true, path = 1, shorting_target = 30 } },
      lualine_x = { "encoding", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = { { "diagnostics", sources = { "nvim_diagnostic" } } },
      lualine_c = { { "filename", file_status = true, path = 1, shorting_target = 30 } },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  })
end

return M
