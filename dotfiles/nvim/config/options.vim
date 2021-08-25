" ---------------------------------------------------------------------------
" Options
" ---------------------------------------------------------------------------

" Enable true colors
set termguicolors


" Line settings
set textwidth=88
set nowrap
set colorcolumn=+1    " textwidth + 1


" Some left-margin while using nonumber. (signcolumn is too wide)
set nonumber


" Indentation settings
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set breakindent
set linebreak


" Always show status line
set laststatus=2


" Press F2 for 'paste mode', for properly pasting external stuff into vim
set pastetoggle=<F2>


" Alias the unnamed register to the '+' register to use system clipboard during d, y, etc.
" actions. `unnamed` -> windows, `unnamedplus` -> X11
set clipboard=unnamed,unnamedplus


" Smarter backspace key
set backspace=indent,eol,start

" Disable mouse
set mouse=


" Search options
set hlsearch
set incsearch
set ignorecase
set smartcase


" Folding
set foldmethod=indent
set foldlevelstart=99   " folds open by default


" Completion menu settings that work alongside completion plugins
set completeopt=menu,menuone,noselect


" Remove <esc> delay
set timeoutlen=1000
set ttimeoutlen=0
set history=1000


" Persistent undo
set undodir=$HOME/.config/nvim/.undo
set undofile
set undolevels=700
set undoreload=5000


" Disable backups and swap files - they trigger too many events for file system watchers
set nobackup
set nowritebackup
set noswapfile


" Interface options
set more  " Show more prompt when a listing's display fills screen
set splitbelow
set splitright
set ttyfast   " (Removed and default on in neovim)


" Point nvim to the Python in the dedicated nvim venv we created, which holds the nvim
" Python client and other packages for plugins.
let g:python3_host_prog = $NVIM_PY3_VENV_PATH . '/bin/python'


" Lets us have syntax highlighting in code blocks in markdown files
let g:markdown_fenced_languages = ['bash', 'python', 'rust', 'javascript', 'typescript']


" Enable loading plugins for specific file-types
filetype plugin indent on


" Enable syntax highlighting based on file-type
syntax on

" -----------------------------------------------------------------------------

" File-type specific options
augroup FileTypeSettings
  autocmd!
  autocmd FileType markdown,text setlocal textwidth=80
  autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup END
