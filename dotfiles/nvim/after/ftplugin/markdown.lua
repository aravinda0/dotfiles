local keymaps = require("keymaps")

keymaps.after_markdown()

vim.o.textwidth = 80
vim.g.gruvbox_material_background = "hard"
vim.cmd([[colorscheme gruvbox-material]])
