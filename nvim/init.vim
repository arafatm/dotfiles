call plug#begin()

" Basics
Plug 'tpope/vim-sensible'
Plug 'roman/golden-ratio'

" Nice utilities
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'jlanzarotta/bufexplorer'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
nmap <C-n> :NERDTreeToggle<CR>
Plug 'scrooloose/nerdtree' " git status plugin for nerdtree

Plug 'majutsushi/tagbar'
nmap <C-m> :TagbarToggle<CR>

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
nnoremap <leader>. :CtrlPTag<cr>

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" hashivim.github.io
Plug 'hashivim/vim-terraform'
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" Color schemes
Plug 'morhetz/gruvbox'

" languages
"Plug 'ajh17/VimCompletesMe'
"Plug 'elixir-lang/vim-elixir'
"Plug 'slashmili/alchemist.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

Plug 'fatih/vim-go'
"let g:go_fmt_command = "gofmt"
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>b  <Plug>(go-build)
"map <C-n> :cnext<CR>
"map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
"au filetype go inoremap <buffer> . .<C-x><C-o> " Use . for autocomplete
let g:go_test_show_name = 0
let g:go_fmt_command = "goimports" " Run goimports along gofmt on each save     
let g:go_auto_type_info = 1        " Automatically get signature/type info for object under cursor
autocmd BufWritePost *.go normal! zv " https://github.com/fatih/vim-go/issues/502

" Plug 'chmp/mdnav'   " Vim plugin for markdown link navigation
Plug 'ajorgensen/vim-markdown-toc'
Plug 'mmai/vim-markdown-wiki' " links manipulation and navigation in markdown 

Plug 'godlygeek/tabular' " needed for vim-markdown
"Plug 'plasticboy/vim-markdown' " https://github.com/plasticboy/vim-markdown
"let g:vim_markdown_auto_insert_bullets = 0
"let g:vim_markdown_autowrite = 1
"let g:vim_markdown_conceal = 0
"let g:vim_markdown_fenced_languages = ['terraform=hcl', 'python=python']
"let g:vim_markdown_folding_style_pythonic = 1
"let g:vim_markdown_frontmatter = 1
"let g:vim_markdown_math = 1
"let g:vim_markdown_new_list_item_indent = 0
"let g:vim_markdown_strikethrough = 1

" Intellisense
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"let g:deoplete#enable_at_startup = 1

" Omnicomplete Better Nav
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")
" Neocomplete Plugin mappins
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

call plug#end()

filetype plugin indent on

"*****************************************************************************
" Autoreload vimrc
"*****************************************************************************
augroup reload_vimrc " {
	autocmd!
	autocmd BufWritePost init.vim source $MYVIMRC
augroup END " }

"*****************************************************************************
" Basic Setup
"*****************************************************************************"

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

" highlight cursor position
set cursorline
"set cursorcolumn

" Set the title of the term?
set title

set fileformats=unix,dos,mac
set showcmd

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

let no_buffers_menu=1
if !exists('g:not_finish_vimplug')
  syntax enable
  set background=dark
  set termguicolors

  "let g:gruvbox_termcolors=16
  "colorscheme NeoSolarized
  "colorscheme molokai
  colorscheme gruvbox
endif

"set mousemodel=popup
set mouse=a
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1
endif

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

noremap <Leader>f :filetype detect

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" vimshell.vim
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '

"*****************************************************************************
"" Mappings
"*****************************************************************************

" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

"noremap YY "+y<CR>
"noremap <leader>p "+gP<CR>
"noremap XX "+x<CR>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

" Insert current date in YYYY-MM-DD
imap  <Leader>d  <c-r>=strftime("%Y-%m-%d")<cr>

" when copying from firefox epub reader, replace <200b> and '
map <LEADER>exc <ESC>:%s/\%u200b//g<CR>:%s/'/"/g<CR>:%s/\t/  /g<CR>ggVG=<CR>

" ****************************
" FOLDING

set foldmethod=indent
autocmd BufNewFile,BufRead * set foldlevel=5

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

map <Leader><Leader>s vip:!sort<cr>

" ****************************
" python
"au BufNewFile,BufRead *.py
"    \ set foldmethod=indent

" weird cursor char on lxterminal
set guicursor=

" git push
command! Gpush !git push 

" git commit with message
command! Gstatus !git status 
command! -nargs=+ Gcommitall :call Git_commit_all(<q-args>)

function! Git_commit_all(message)
  echo system('git pull')
  echo system('git commit -a -m "' . a:message . '"')
  echo system('git push')
  "call jobstart('git pull; git push')
endfunction

function! Git_commit(message)
  echomsg a:message
  echo system('git commit ' . expand("%t") . ' -m "' . a:message . '"')
  echo system('git push')
  "call jobstart('git pull; git push')
endfunction

command! Gheadcommit      :call GH_commit_this_file_as_message()
" ****************************
" Commit Readme with last message of last header "^##"
function! GH_commit_this_file_as_message()
  let l:winview = winsaveview()
  "let msg = getline(search("^\#", "b"))
  let msg = expand('%:t')
  call winrestview(l:winview)

  call Git_commit(msg) " defined in init.vim
endfunction

" open file at last location
au BufWinLeave * mkview
"au BufWinEnter * silent loadview

set expandtab
