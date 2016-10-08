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


" Get rid of trailing whitespace
function! StripTrailingWhitespace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

augroup StripTrailingWhitespace
  autocmd! *
    \ autocmd BufWritePre <buffer> :call
    \ StripTrailingWhitespace()
augroup END
