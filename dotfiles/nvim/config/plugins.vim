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

" Search lines in current buffer
nnoremap <c-t>l :BLines<cr>

" Search all lines in all files
nnoremap <c-t>, :Lines<cr>

" Search repo commits
nnoremap <c-t>h :Commits<cr>

" Search commits for current buffer
nnoremap <c-t>b :BCommits<cr>

" Search normal mode mappings
nnoremap <c-t>m :Maps<cr>

" Search from current dir using `ag` and show results to search in
nnoremap <c-t>/ :execute 'Ag ' . input('Ag/')<cr>
