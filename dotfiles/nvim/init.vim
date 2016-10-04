
" ---------------------------------------------------------------------------
" Options
" ---------------------------------------------------------------------------

" Line numbers
set number
set numberwidth=4

" Indentation settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set breakindent

" More indentation for python
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" ---------------------------------------------------------------------------
" Mappings
" ---------------------------------------------------------------------------

let mapleader = ' '

inoremap jk <esc>

" Save easily
" Might require disabling terminal suspend by adding 'stty -ixon' to shell
" startup script
nnoremap <c-s> :update<cr>
inoremap <c-s> <c-o>:update<cr>
vnoremap <c-s> <c-c>:update<cr>

" Quit easily
noremap <leader>q :quit<cr>
noremap <leader>Q :qa!<cr>

" Easy editing of vimrc
nnoremap <leader>V :vsplit $MYVIMRC<cr>
nnoremap <leader>S :source $MYVIMRC<cr>

" Shortcuts to open files in the same directory as current file
noremap <leader>oe :e <c-r>=expand("%:p:h") . "/" <cr>
noremap <leader>ot :tabe <c-r>=expand("%:p:h") . "/" <cr>
noremap <leader>os :split <c-r>=expand("%:p:h") . "/" <cr>
noremap <leader>ov :vsplit <c-r>=expand("%:p:h") . "/" <cr>

" emacsy bindings for BOL/EOL
inoremap <c-e> <end>
inoremap <c-a> <esc>I
nnoremap <c-a> ^

" Clear highlighting
noremap <c-n> :nohl<cr>
vnoremap <c-n> :nohl<cr>
inoremap <c-n> :nohl<cr>

" Easier moving of code blocks in visual mode
vnoremap < <gv
vnoremap > >gv

" Ctrl-up/down to search command history based on characters typed so far
cnoremap <c-k> <up>
cnoremap <c-j> <down>


" ---------------------------------------------------------------------------
" Abbreviations
" ---------------------------------------------------------------------------

" Convenient separator
iabbrev --- -------------------------------------------------------------------------------

" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------

call plug#begin()

" Plug 'frankier/neovim-colors-solarized-truecolor-only'  " true-color fork of solarized
" Plug 'trevordmiller/nova-vim'
Plug 'mhartington/oceanic-next'

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'

call plug#end()


" -------------------------------------
" Color scheme
" -------------------------------------

" Enable true colors
set termguicolors

syntax enable
set background=dark
colorscheme OceanicNext
