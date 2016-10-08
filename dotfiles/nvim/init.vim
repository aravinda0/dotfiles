
" We don't want vi-compatible behaviour. Should be set at the very top.
set nocompatible

" Path to the folder containing this file
let s:vim_config_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')


" Source options file
execute 'source ' . s:vim_config_path . '/config/options.vim'

" Source mappings file
execute 'source ' . s:vim_config_path . '/config/mappings.vim'

" Source functions file
execute 'source ' . s:vim_config_path . '/config/functions.vim'

" Source plugins and their config
execute 'source ' . s:vim_config_path . '/config/plugins.vim'


" -------------------------------------
" Color scheme
" -------------------------------------

set background=dark
colorscheme OceanicNext
