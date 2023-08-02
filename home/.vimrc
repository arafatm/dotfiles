" no idea why this fixes gvim in windows/cygwin

set nocp            " be iMproved
filetype off        " required!
set rtp+=$HOME/.vim " stupid windows
set fileformat=unix " fucka windows

if has("win32")
  set shell=cmd
  set shellcmdflag=/c
endif

"source $HOME/.vim/autoload/pathogen.vim     " I don't even
execute pathogen#infect()
syntax enable
filetype plugin indent on

" ****************************
" Common settings
set laststatus=2
set statusline=%f         " Path to the file
set statusline+=%=        " Switch to the right side
set statusline+=%y        " Filetype of the file"
set statusline+=\ -\      " Separator
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines"
set statusline+=\ \       " Padding

" misc
set showcmd			" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase	" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden      " Hide buffers when they are abandoned
"set paste      " Messes with :iab functions below :(

set smartindent
set autoindent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

set visualbell
set hls
set dir=~/tmp
set backupcopy=yes
set nobackup writebackup
map <BS> bdw
set foldmethod=indent
set foldlevel=99

set cot=menuone
set cot+=preview

set nomodeline
let g:secure_modelines_verbose = 0
let g:secure_modelines_modelines = 15

let mapleader=","

" ****************************
" Hopefully speedup vim
let g:ruby_path="$HOME/.rbenv/shims/ruby"
" ****************************
" Colors
"set t_Co=256
"let g:solarized_termcolors=256
set background=dark
colorscheme koehler
"colorscheme solarized

" ****************************
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" ****************************
" Elixir QoL
iab ,. \|>
map <LEADER>exc <ESC>:%s/\%u200b//g<CR>:%s/'/"/g<CR>:%s/\t/  /g<CR>ggVG=<CR>

" ****************************
" Commit Readme with last message of last header "^#"
map <LEADER>gc <ESC>mz:call GCR()
function! GCR()
  let msg = getline(search("^\#", "b"))
  let git = "git commit ./README.md -m '" . msg . "'"

  echo system(git)
endfunction

" ****************************
" I want to link to the last git commit on github.
" Result is "[commit text](https://github.com/arafatm/repo/commit/gitsha)"
" and gets appended to the next line
map <Leader>gh <ESC>:call GH()
function! GH()
  let line = getline('.')
  let dir = split(fnamemodify('.',':p'), "/")[-1]

  let glg = system('git log --oneline | head -n 1')

  let glg = split(glg, " ")
  let gh = glg[0]
  let gt = substitute(join(glg[1:-1], " "), "\n", "", "")


  let line = ":shipit: [".gt."]("
  let line = line . "https://github.com/arafatm/" . dir . "/commit/"
  let line = line . gh . ")"

  call append(line('.'), line)

endfunction

" ****************************
" Search doc for highlighted text
vnoremap // y/<C-R>"<CR>"

" ****************************
" FOLDING
" Map space to toggle fold
nnoremap  <silent>  <space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>

map <Leader><Leader>0 :set foldlevel=0<cr>
map <Leader><Leader>1 :set foldlevel=1<cr>
map <Leader><Leader>2 :set foldlevel=2<cr>
map <Leader><Leader>3 :set foldlevel=3<cr>
map <Leader><Leader>4 :set foldlevel=4<cr>
map <Leader><Leader>5 :set foldlevel=5<cr>
map <Leader><Leader>6 :set foldlevel=6<cr>
map <Leader><Leader>7 :set foldlevel=7<cr>
map <Leader><Leader>8 :set foldlevel=8<cr>
map <Leader><Leader>9 :set foldlevel=9<cr>


" ****************************
" Abbreviations
iab  <Leader>d  <c-r>=strftime("%Y-%m-%d")<cr>

augroup filetypedetect

  " markdown
  au BufNewFile,BufRead *.md,*.mkd,*.markdown setlocal filetype=markdown
  au BufNewFile,BufRead *.txt setfiletype markdown
  au BufNewFile,BufRead .bashrc,.bash/* call SetFileTypeSH("bash")
  au BufNewFile,BufRead * set expandtab
augroup END

au BufNewFile,BufRead *.md,*.mkd,*.markdown,*.txt
      \ setlocal filetype=markdown |
      \ set formatoptions=tqwan |
      \ set smartindent |
      \ set tabstop=2 |
      \ set shiftwidth=2 |
      \ set expandtab |
      \ map <leader>- vip:s/^/- /<CR>{jgq}:let @/ = ""<CR>{j |
      \ map <leader>1 <ESC>:.s/^/# /<CR>:let @/ = ""<CR>zOo<ESC>j |
      \ map <leader>2 <ESC>:.s/^/## /<CR>:let @/ = ""<CR>zOo<ESC>j |
      \ map <leader>3 <ESC>:.s/^/### /<CR>:let @/ = ""<CR>zOo<ESC>j
let g:markdown_folding = 1

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" ColorColumn
set colorcolumn=81
au BufEnter * set colorcolumn=81


" --------------------
" Display highlight for current word
map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#") . " BG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"bg#")<CR>

" --------------------
" Execute current file
nnoremap <Leader>r :!%:p

" *********************************************************
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" *********************************************************
" Plugin settings
" *********************************************************

" ##### NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" ##### Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ##### Vim Table Mode
let g:table_mode_corner='|'

" ##### Easy-Align

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
imap <tab> <c-x><c-o>
