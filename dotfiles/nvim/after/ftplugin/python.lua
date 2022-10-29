
local key_opts = { noremap=true, silent=true }

vim.keymap.set("n", "<c-l>oi", "<cmd>%!isort -<cr>", key_opts)
