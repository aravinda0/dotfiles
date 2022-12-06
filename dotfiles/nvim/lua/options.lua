-- Enable true colors
vim.o.termguicolors = true

-- Getting rid of number column gives us a bit more space for comfortable triple-splits
vim.o.number = false

-- Line settings
vim.o.textwidth = 88
vim.o.wrap = false
vim.o.colorcolumn = "+1"

-- Indentation settings
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.breakindent = true
vim.o.linebreak = true

-- Alias the unnamed register to the '+' register to use system clipboard during d, y,
-- etc. actions. `unnamed` -> windows, `unnamedplus` -> X11
vim.o.clipboard = "unnamed,unnamedplus"

-- Search options
vim.o.ignorecase = true
vim.o.smartcase = true

-- Completion menu settings that work alongside completion plugins
vim.o.completeopt = "menu,menuone,noselect"

-- Remove <esc> delay
vim.o.ttimeoutlen = 0

-- Persistent undo
vim.o.undofile = true

-- Disable backups, swap files - they trigger too many events for file system watchers
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Control which sides new splits open
vim.o.splitright = true
vim.o.splitbelow = true

-- Point nvim to the Python in the dedicated nvim venv we created, which holds the nvim
-- Python client and other packages for plugins.
vim.g.python3_host_prog = vim.env["NVIM_PY3_VENV_PATH"] .. "/bin/python"

-- Disable mouse
vim.o.mouse = nil

-- Do we still need these?
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
