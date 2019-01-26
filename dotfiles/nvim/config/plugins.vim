" -------------------------------------------------------------------------------
" Plugins
" -------------------------------------------------------------------------------

let s:neovim_venv_bin = $NVIM_PY3_VENV_PATH . '/bin'

call plug#begin()


" -------------------------------------------------------------------------------
" indentline - show indent guides
" -------------------------------------------------------------------------------

Plug 'Yggdroot/indentLine'


" -------------------------------------------------------------------------------
" Vim tmux navigator - consistent keys to move between splits/panes across vim/tmux
" -------------------------------------------------------------------------------

Plug 'christoomey/vim-tmux-navigator'

" Disable default mappings
let g:tmux_navigator_no_mappings = 1


" Alt-key based movement across splits. Keep this in sync with corresponding
" mappings in tmux mappings file.
nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
nnoremap <silent> <m-l> :TmuxNavigateRight<cr>
nnoremap <silent> <m-/> :TmuxNavigatePrevious<cr>


" -------------------------------------------------------------------------------
" vim-unimpaired - handy motions starting with '[' and ']' keys
" -------------------------------------------------------------------------------

Plug 'tpope/vim-unimpaired'


" -------------------------------------------------------------------------------
" vim-commentary - easier commenting
" -------------------------------------------------------------------------------

Plug 'tpope/vim-commentary'


" -------------------------------------------------------------------------------
" vim-surround - easily surround objects with brackets, quotes etc.
" -------------------------------------------------------------------------------

Plug 'tpope/vim-surround'


" -------------------------------------------------------------------------------
" EasyMotion - quickly jump to any location on the screen
" -------------------------------------------------------------------------------

Plug 'easymotion/vim-easymotion'

" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Search like vim's smartcase
let g:EasyMotion_smartcase = 1

" Don't search outside visible screen
let g:EasyMotion_off_screen_search = 0

" 2-char searches across splits
nmap s <Plug>(easymotion-overwin-f2)

nmap s <Plug>(easymotion-s)
nmap w <Plug>(easymotion-w)
nmap b <Plug>(easymotion-b)


" -------------------------------------------------------------------------------
" NERDTree - Easier file exploration
" -------------------------------------------------------------------------------

Plug 'scrooloose/nerdtree'

" Easier toggling of NERDTree window
nmap <c-h> :NERDTreeToggle<cr>


" -------------------------------------------------------------------------------
" auto-pairs - Auto-close quotes, brackets while typing
" -------------------------------------------------------------------------------

Plug 'jiangmiao/auto-pairs'


" -------------------------------------------------------------------------------
" Emmet - Shortcuts for xml-based languages, building markup from css-like selectors
" -------------------------------------------------------------------------------

Plug 'mattn/emmet-vim'

" <c-g> as emmet leader key in all modes
let g:user_emmet_leader_key='<c-g>'


" -------------------------------------------------------------------------------
" Snippets
" -------------------------------------------------------------------------------

" Snippet engine
Plug 'SirVer/ultisnips'

" Snippet collections
Plug 'honza/vim-snippets'


" Specify default snippets directory along with one for our custom snippets
let g:UltiSnipsSnippetDirectories=["UltiSnips", "custom_snippets"]

" Snippet expansion
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" -------------------------------------------------------------------------------
" FZF - Fast searching of files in directory/project/history/etc.
" -------------------------------------------------------------------------------

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

nnoremap <c-p> :Files<cr>
nnoremap <c-t>g :GFiles<cr>
nnoremap <c-o> :Buffers<cr>

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
" JavaScript syntax - Plugins that provide better syntax and indentation settings for JS
" -------------------------------------------------------------------------------

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }


" -------------------------------------------------------------------------------
" Typescript syntax
" -------------------------------------------------------------------------------

Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'ianks/vim-tsx', { 'for': ['typescript.tsx'] }


" -------------------------------------------------------------------------------
" Better indentation for Python
" -------------------------------------------------------------------------------

Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }


" -------------------------------------------------------------------------------
" Coc - for completions with the assistance of various coc plugins
" -------------------------------------------------------------------------------

" function! PlugCoc(info) abort
"   if a:info.status ==? 'installed' || a:info.force
"     !yarn install
"     call coc#util#install_extension(join(get(s:, 'coc_extensions', [])))
"   elseif a:info.status ==? 'updated'
"     !yarn install
"     call coc#util#update()
"   endif
"   call PlugRemotePlugins(a:info)
" endfunction

" let s:coc_extensions = [
" \   'coc-pyls',
" \   'coc-tsserver',
" \   'coc-rls',
" \   'coc-html',
" \   'coc-css',
" \   'coc-json',
" \   'coc-yaml',
" \   'coc-emmet',
" \   'coc-highlight',
" \   'coc-tslint',
" \   'coc-ultisnips'
" \ ]

" Plug 'neoclide/coc.nvim', {'do': function('PlugCoc')}
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Navigate diagnostics
nmap <silent> <m-c-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <m-c-j> <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>t <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Show signature help while editing
autocmd CursorHoldI * silent! call CocActionAsync('showSignatureHelp')

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')


" -------------------------------------------------------------------------------
" vim-wiki - for notes with elegant markdown settings
" -------------------------------------------------------------------------------

Plug 'vimwiki/vimwiki'

" TODO: After trial phase, fetch notes path from env var
let g:vimwiki_list = [
  \ {'path': '~/.dency/notes/wiki/life', 'ext': '.md', 'syntax': 'markdown'},
  \ {'path': '~/.dency/notes/wiki/notes', 'ext': '.md', 'syntax': 'markdown'},
  \ {'path': '~/.dency/notes/wiki/work', 'ext': '.md', 'syntax': 'markdown'}]

" Handle various file types with appropriate syntax settings
let g:vimwiki_ext2syntax = {
  \ '.md': 'markdown',
  \ '.mkd': 'markdown',
  \ '.wiki': 'media'}

" Need to use `namp` and not `nnoremap`
augroup PluginVimWikiMappings
  autocmd!
  autocmd FileType vimwiki,markdown nmap <buffer> gv <Plug>VimwikiVSplitLink
  autocmd FileType vimwiki,markdown nmap <buffer> go <Plug>VimwikiFollowLink
  autocmd FileType vimwiki,markdown nmap <buffer> gt <Plug>VimwikiTabnewLink
  autocmd FileType vimwiki,markdown nmap <buffer> gb <Plug>VimwikiGoBackLink

  " Bring back our backspace mapping that vimwiki overrides
  autocmd FileType vimwiki,markdown nmap <buffer> <bs> :b#<cr>
augroup END


" -------------------------------------------------------------------------------
" Color Scheme
" -------------------------------------------------------------------------------

Plug 'cocopon/iceberg.vim'
" Plug 'mhartington/oceanic-next'
" Plug 'frankier/neovim-colors-solarized-truecolor-only'  " true-color fork of solarized
" Plug 'trevordmiller/nova-vim'

" Plug 'morhetz/gruvbox'
" let g:gruvbox_italic = 1
" let g:gruvbox_invert_selection = 0

" ---------------------------------------------------------------------------
" End Plugins
" ---------------------------------------------------------------------------

call plug#end()


" ---------------------------------------------------------------------------
" Color scheme - Has to be called after color scheme plugin is processed and
" plug#end has been called.
" ---------------------------------------------------------------------------

set background=dark
colorscheme iceberg
