" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------

call plug#begin()

" Color scheme
Plug 'mhartington/oceanic-next'
" Plug 'frankier/neovim-colors-solarized-truecolor-only'  " true-color fork of solarized
" Plug 'trevordmiller/nova-vim'

Plug 'tpope/vim-unimpaired'

Plug 'tpope/vim-surround'

Plug 'jiangmiao/auto-pairs'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()


" -------------------------------------------------------------------------------
" fzf
" -------------------------------------------------------------------------------

nnoremap <c-p> :GFiles<cr>
nnoremap <c-o> :Files<cr>
nnoremap <c-i> :Buffers<cr>
nnoremap <c-l><c-l> :BLines<cr>
nnoremap <c-l>, :Lines<cr>
nnoremap <c-l><c-h> :Commits<cr>
nnoremap <c-l><c-b> :BCommits<cr>
nnoremap <c-l><c-m> :Maps<cr>

" Search from current dir using `ag` and show results to search in
nnoremap <c-l>/ :execute 'Ag ' . input('Ag/')<cr>
