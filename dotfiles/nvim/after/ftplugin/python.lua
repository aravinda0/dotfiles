local keymaps = require("keymaps")


keymaps.after_python()


-- Format with Black on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.py" },
  command = "silent! Black",
})
