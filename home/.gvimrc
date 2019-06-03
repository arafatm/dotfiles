" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" You can also specify a different font, overriding the default font
if has("gui_gtk2")
  set guifont=DejaVu\ Sans\ Mono\ 10
elseif has("x11")
  set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
else
  set guifont=Consolas:h12:cANSI
endif

" If you want to run gvim with a dark background, try using a different
" colorscheme or running 'gvim -reverse'.
" http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/ has examples and
" downloads for the colorschemes on vim.org

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/gvimrc
if filereadable("/etc/vim/gvimrc.local")
  source /etc/vim/gvimrc.local
endif

set guioptions-=T

:map <A-x> :simalt ~x<CR>

set ff=unix " fuck a windows
