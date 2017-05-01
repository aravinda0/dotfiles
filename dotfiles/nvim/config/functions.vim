" ---------------------------------------------------------------------------
"  Functions & Misc
" ---------------------------------------------------------------------------

" Jump to the last edit position when opening files
augroup LastPosition
	autocmd! BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\     exe "normal! g`\"" |
		\ endif
augroup END

function! TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfunction

augroup StripTrailingWhitespace
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END
