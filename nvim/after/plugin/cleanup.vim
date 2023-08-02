" Plugin to clean up text copied from epubs

" clean up Zero Width Space (U+200B) and AutoIndent
function! CleanZeroWidthAndIndent()

  " Save cursor position
  let l:save = winsaveview()

  " replace 
  %s/\%u200b//g

  " align?
  normal! {v}=

  " Move cursor to original position
  call winrestview(l:save)
  echo "Cleaned U+200b"
endfunction

nnoremap ,u :call CleanZeroWidthAndIndent()<CR>
