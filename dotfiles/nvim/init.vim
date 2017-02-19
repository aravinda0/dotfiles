
" We don't want vi-compatible behaviour. Should be set at the very top.
set nocompatible

" Path to the folder containing this file
let s:vim_config_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')


" Source various config from helper files
execute 'source ' . s:vim_config_path . '/config/options.vim'
execute 'source ' . s:vim_config_path . '/config/mappings.vim'
execute 'source ' . s:vim_config_path . '/config/functions.vim'
execute 'source ' . s:vim_config_path . '/config/plugins.vim'
