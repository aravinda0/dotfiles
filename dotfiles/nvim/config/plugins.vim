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


" Plugins that provide better syntax and indentation settings for JS
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }


" NOTE: vim startup time seems to be a fraction slower with some of the following plugins.
" Particularly - jedi-vim and tern_for_vim. Probably due to lack of async in these
" heavy plugins.

" Jedi wrapper, Python autocompletion and static analysis lib, used with deoplete
Plug 'zchee/deoplete-jedi', { 'for': 'python' }


" jedi-vim, to be used for python features aside from completion (which is provided by
" deoplete-jedi). Primarily for go-to-definition.
Plug 'davidhalter/jedi-vim', { 'for': 'python' }


" ternjs wrapper, deoplete-ternjs will handle completions, this will provide other tern
" feaures from within vim.
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': ['javascript', 'javascript.jsx'] }


" ternjs wrapper, JavaScript autocompletion and static analysis lib, used with deocomplete
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }


call plug#end()


" -------------------------------------------------------------------------------
" General
" -------------------------------------------------------------------------------

let s:neovim_venv_bin = $NVIM_PY3_VENV_PATH . '/bin'


" -------------------------------------------------------------------------------
" fzf
" -------------------------------------------------------------------------------

nnoremap <c-p> :Files<cr>
nnoremap <c-o> :GFiles<cr>
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

" Override default python makers to use only flake8.
" Further, we tell neomake to use the flake8 installed in our dedicated nvim venv. The
" remaining flake8 options are taken as-is from what is specified in the neomake repo.
" (See `plugged/neomake/autoload/neomake/makers/ft/python.vim`)
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_maker = {
  \ 'exe': s:neovim_venv_bin . '/flake8',
  \ 'errorformat':
    \ '%E%f:%l: could not compile,%-Z%p^,' .
    \ '%A%f:%l:%c: %t%n %m,' .
    \ '%A%f:%l: %t%n %m,' .
    \ '%-G%.%#',
  \ 'postprocess': function('neomake#makers#ft#python#Flake8EntryProcess')
\ }

" Run linter on saving/opening file
augroup NeomakeCommands
  autocmd!
  autocmd! BufWritePost,BufRead * Neomake
augroup END


" -------------------------------------------------------------------------------
" deoplete
" -------------------------------------------------------------------------------
" Ref: https://github.com/Shougo/deoplete.nvim/blob/master/doc%2Fdeoplete.txt

let g:deoplete#enable_at_startup = 1

" Close popup menu when completion is done
augroup DeopleteCommands
  autocmd!
  autocmd CompleteDone * pclose!
augroup END


" -------------------------------------------------------------------------------
" deoplete-jedi
" -------------------------------------------------------------------------------


" -------------------------------------------------------------------------------
" vim-jedi
" -------------------------------------------------------------------------------

" Completions handled by deoplete-jedi
let g:jedi#completions_enabled = 0


" -------------------------------------------------------------------------------
" deoplete-ternjs, tern_for_vim
" -------------------------------------------------------------------------------

" TODO: Can this be a command from some neovim-specific non-global install of tern?
" See deoplete-ternjs source - kind of looks to be configurable.
let g:tern#command = ['tern']

" Disable auto-shutdown of tern server that happens after 5 mins of inactivity
let g:tern#arguments = ['--persistent']

" Shortcuts for tern_for_vim commands
augroup TernCommands
  autocmd!
  autocmd FileType javascript,javascript.jsx nnoremap <leader>d :TernDef<cr>
  autocmd FileType javascript,javascript.jsx nnoremap <leader>D :TernDefTab<cr>
augroup END
