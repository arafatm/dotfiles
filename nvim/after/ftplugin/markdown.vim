set nonumber
GitGutterDisable
set shiftwidth=2
set expandtab

function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "=" 
endfunction
setlocal foldexpr=MarkdownLevel()  
setlocal foldmethod=expr   
setlocal foldlevel=1

" Tables shit
map ;x xxxi:x:<ESC>:Tab/\|<RETURN>
map ;o xxxi:o:<ESC>:Tab/\|<RETURN>
map <LEADER>T :Tab/\|<RETURN>
map <LEADER><LEADER>c vip:s/\: /\: \| /<RETURN>{wwwi\|  X  <ESC>:Tab/\|<RETURN>{/X<RETURN>

" emojis
iab .a :a: 
iab .b :b:
iab .o :o:
iab .v :v:
iab .x :x:
iab :m :boom:
iab :e :exclamation:
iab :f :fire:
iab :l :flashlight:
iab :p :poop:
iab :s :shipit:
iab :t :star:
iab :u :point_up:
iab :w :warning:

" code blocks
iab `b ```bash<return>```<ESC>O
iab `e ```elixir<return>```<ESC>O
iab `r ```ruby<return>```<ESC>O
iab `p ```python<return>```<ESC>O
iab `t ```terraform<return>```<ESC>O
iab `x ```jsx<return>```<ESC>O


map ``b o:shipit:<return>```bash<return>```<esc>k0ba<space>
map ``e o:shipit:<return>```elixir<return>```<esc>k0ba<space>
map ``r o:shipit:<return>```ruby<return>```<esc>k0ba<space>
map ``p o:shipit:<return>```python<return>```<esc>k0ba<space>
map ``t o:shipit:<return>```terraform<return>```<esc>k0ba<space>

imap ,t - [ ]
imap ,a - [ ] :a:
imap ,b - [ ] :b:

map <LEADER>tn <ESC>/- \[ ]<CR>
map <LEADER>tna <ESC>/- \[ ] :a:<CR>
map <LEADER>tnb <ESC>/- \[ ] :b:<CR>
map <LEADER>tc <ESC>:call TodoDoneCal()<CR>
map <LEADER>td <ESC>:call TodoDone()<CR>
"map <LEADER>td :.s/^- \[ ]/\="- [x] ~~" . strftime("%Y-%m-%d") . "~~"<CR>

map <LEADER>te <ESC>:call TodoDoneEml()<CR>
map <LEADER>ts <ESC>vip:!sort<CR>

command! Gheadcommitall   :call GH_commit_all_with_this_header_as_message()
command! Gheadcommit      :call GH_commit_this_file_as_message()
command! Glinklastcommit  :call GH_link_last_commit()

" ****************************
function! TodoSort()
  <ESC>vip:!sort<CR>
endfunction

" ****************************
function! TodoDoneSlack()
  let line = getline('.')
  let text = split(line, "]")[1] 
  let done = "- [x] " . strftime("%Y-%m-%d") . " slack;" . text
  call setline(line('.'), done) 
endfunction

" ****************************
function! TodoDoneEml()
  let line = getline('.')
  let text = split(line, "]")[1] 
  let done = "- [x] " . strftime("%Y-%m-%d") . " eml; " . text
  call setline(line('.'), done) 
endfunction

" ****************************
function! TodoDoneCal()
  let line = getline('.')
  let text = split(line, "]")[1] 
  let done = "- [x] " . strftime("%Y-%m-%d") . " cal; " . text
  call setline(line('.'), done) 
endfunction

" ****************************
function! TodoDone()
  "let line = getline('.')
  "let text = split(line, "]")[1] 
  "let done = "- [x] ~~" . strftime("%Y-%m-%d") . "~~" . text
  "call setline(line('.'), done) 
  s/@/./g 
  s/:a:/A/g 
  s/:b:/B/g 
  s/^- \[ ]/\="- [x] ~~" . strftime("%Y-%m-%d") . "~~" 
endfunction

" ****************************
" Commit . with last message of last header "^##"
function! GH_commit_all_with_this_header_as_message()
  let l:winview = winsaveview()
  let msg = getline(search("^\#", "b"))
  call winrestview(l:winview)

  call Git_commit_all(msg)
endfunction

" ****************************
" Commit Readme with last message of last header "^##"
function! GH_commit_this_file_as_message()
  let l:winview = winsaveview()
  "let msg = getline(search("^\#", "b"))
  let msg = expand('%:t')
  call winrestview(l:winview)

  call Git_commit(msg) " defined in init.vim
endfunction

" ****************************
" I want to link to the last git commit on github.
" Result is "[commit text](https://github.com/arafatm/repo/commit/gitsha)"
" and gets appended to the next line
function! GH_link_last_commit()
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

echomsg "SUCCESS!"
