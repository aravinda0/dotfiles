" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------

call plug#begin()

" Color scheme
Plug 'mhartington/oceanic-next'
" Plug 'frankier/neovim-colors-solarized-truecolor-only'  " true-color fork of solarized
" Plug 'trevordmiller/nova-vim'

" Handy motions starting with '[' and ']' keys
Plug 'tpope/vim-unimpaired'

" Easy commenting
Plug 'tpope/vim-commentary'

" Easily surround objects with brackets, quotes etc.
Plug 'tpope/vim-surround'

" Auto-close quotes, brackets while typing
Plug 'jiangmiao/auto-pairs'

" Show indent guides
" Plug 'Yggdroot/indentLine'

" Fast searching of files in directory/project/history/etc.
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Async code runner. Primarily for running linters, compilers etc.
Plug 'neomake/neomake'

" Async completion system for neovim
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Jedi wrapper, Python autocompletion and static analysis lib, used with deoplete
Plug 'zchee/deoplete-jedi', { 'for': 'python' }

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


" -------------------------------------------------------------------------------
" neomake
" -------------------------------------------------------------------------------

" Run linter on saving/opening file
autocmd! BufWritePost,BufRead * Neomake


" -------------------------------------------------------------------------------
" deoplete
" -------------------------------------------------------------------------------
"  Ref: https://github.com/Shougo/deoplete.nvim/blob/master/doc%2Fdeoplete.txt

let g:deoplete#enable_at_startup = 1

" Close popup menu when completion is done
autocmd CompleteDone * pclose!


" -------------------------------------------------------------------------------
" deoplete
" -------------------------------------------------------------------------------

" let g:deoplete#sources#jedi#show_docstring = 1
