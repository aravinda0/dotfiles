" ---------------------------------------------------------------------------
" Mappings
" ---------------------------------------------------------------------------

" NOTE: Also look at `config/plugins.vim` for plugin specific mappings


" The space bar is our leader key
let mapleader = ' '


inoremap jk <esc>


" Save easily
" Might require disabling terminal suspend by adding 'stty -ixon' to shell startup
" script
nnoremap <c-s> :update<cr>
inoremap <c-s> <c-o>:update<cr>
vnoremap <c-s> <c-c>:update<cr>


" Quit easily
noremap <leader>q :quit<cr>
noremap <leader>Q :qa!<cr>


" Prevent disasters
nnoremap ZZ <nop>


" Easy editing and loading of vimrc
nnoremap <leader>cv :vsplit $MYVIMRC<cr>
nnoremap <leader>ce :edit $MYVIMRC<cr>
nnoremap <leader>cr :source $MYVIMRC<cr>


" Shortcuts to open files in the same directory as current file
noremap <leader>oe :e <c-r>=expand("%:p:h") . "/" <cr>
noremap <leader>ot :tabe <c-r>=expand("%:p:h") . "/" <cr>
noremap <leader>os :split <c-r>=expand("%:p:h") . "/" <cr>
noremap <leader>ov :vsplit <c-r>=expand("%:p:h") . "/" <cr>


" Emacsy bindings for BOL/EOL
inoremap <c-e> <end>
inoremap <c-a> <esc>I
nnoremap <c-a> ^


" Clear highlighting
noremap <c-n> :nohl<cr>
vnoremap <c-n> :nohl<cr>
inoremap <c-n> :nohl<cr>


" Easier reindenting in visual mode
vnoremap < <gv
vnoremap > >gv


" Ctrl-up/down to search command history based on characters typed so far
cnoremap <c-k> <up>
cnoremap <c-j> <down>


" Easier navigation inside popup menus
inoremap <expr> <c-k> pumvisible() ? '<c-p>' : '<c-k>'
inoremap <expr> <c-j> pumvisible() ? '<c-n>' : '<c-j>'


" Move lines up or down
nnoremap <c-j> :move +1<cr>
nnoremap <c-k> :move -2<cr>
vnoremap <c-j> :move '>+1<cr>gv-gv
vnoremap <c-k> :move '<-2<cr>gv-gv


" Copy to end of line
nnoremap Y y$


" Select previously pasted text
noremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'


" Window motions
nnoremap <m-h> <c-w>h
nnoremap <m-j> <c-w>j
nnoremap <m-k> <c-w>k
nnoremap <m-l> <c-w>l


" Easier moving between tabs.
noremap <m-e> <esc>:tabprevious<cr>
noremap <m-r> <esc>:tabnext<cr>
noremap <m-E> <esc>:tabfirst<cr>
noremap <m-R> <esc>:tablast<cr>


" Switch to previous buffer
nnoremap <bs> :b#<cr>


" ---------------------------------------------------------------------------
" Abbreviations
" ---------------------------------------------------------------------------

" Convenient separator
iabbrev --$ --------------------------------------------------------------------------------


" Insert date
iabbrev <expr> date$ strftime('%d %b %Y - %a')
