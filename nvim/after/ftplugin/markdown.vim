set expandtab
set nonumber
set nowrap
set shiftwidth=2
set textwidth=0
set wrapmargin=0

setlocal foldexpr=MarkdownLevel() 
setlocal foldmethod=expr  
setlocal foldlevel=9

GitGutterDisable

"""""""""""""""""""" Code Blocks
" Copied from :he iabbr to remove extra space when completing iab
func Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc
"iab ` ``<left><C-R>=Eatchar('\s')<CR>
iab $ $``$<left><left><C-R>=Eatchar('\s')<CR>
iab ``` <CR>```<RETURN><RETURN>```<UP><C-R>=Eatchar('\s')<CR>
iab `b ```bash<return>```<ESC>O<C-R>=Eatchar('\s')<CR>
iab `e ```elixir<return>```<ESC>O<C-R>=Eatchar('\s')<CR>
iab `r ```ruby<return>```<ESC>O<C-R>=Eatchar('\s')<CR>
iab `p ```python<return>```<ESC>O<C-R>=Eatchar('\s')<CR>
iab `t ```terraform<return>```<ESC>O<C-R>=Eatchar('\s')<CR>
iab `x ```jsx<return>```<ESC>O<C-R>=Eatchar('\s')<CR>
iab det <details><summary></summary><CR></details><ESC>k0/><<CR>n<left>

iab h1 #
iab h2 ##
iab h3 ###
iab h4 ####
iab h5 #####
iab h6 ######

"""""""""""""""""""" Misc
iab img ![](/img/)

"""""""""""""""""""" Todo
iab tt - [ ]
iab tta - [ ] :a:
iab ttb - [ ] :b:

"""""""""""""""""""" Markdown 
iab mimg ![]()<left><C-R>=Eatchar('\s')<CR>

"""""""""""""""""""" Emoji
iab ear :art:
iab eax :axe:
iab ebe :bee:
iab ebg :bug:
iab ebl :bulb:
iab edn :dna:
iab ees :es: 
iab ege :gem:
iab ehu :hut:
iab ejo :joy:
iab ele :leo:
iab eli :link:
iab eme :mega:
iab eom :om: 
iab eow :owl:
iab era :rat:
iab esa :sa: 
iab esh :ship:
iab ev  :v:  

"""""""""""""""""""" Tables
map ;x xxxi:x:<ESC>:Tab/\|<RETURN>
map ;o xxxi:o:<ESC>:Tab/\|<RETURN>
map <LEADER>T :Tab/\|<RETURN>
map <LEADER><LEADER>c vip:s/\: /\: \| /<RETURN>{wwwi\|  X  <ESC>:Tab/\|<RETURN>{/X<RETURN>

"""""""""""""""""""" Todo
map <LEADER>tn <ESC>/- \[ ]<CR>
map <LEADER>tna <ESC>/- \[ ] :a:<CR>
map <LEADER>tnb <ESC>/- \[ ] :b:<CR>
map <LEADER>tc <ESC>:call TodoDoneCal()<CR>
map <LEADER>td <ESC>:call TodoDone()<CR>
"map <LEADER>td :.s/^- \[ ]/\="- [x] ~~" . strftime("%Y-%m-%d") . "~~"<CR>

map <LEADER>te <ESC>:call TodoDoneEml()<CR>
map <LEADER>ts <ESC>vip:!sort<CR>

""""""""""""""""""""
function! TodoSort()
  <ESC>vip:!sort<CR>
endfunction

""""""""""""""""""""
function! TodoDoneSlack()
  let line = getline('.')
  let text = split(line, "]")[1]
  let done = "- [x] " . strftime("%Y-%m-%d") . " slack;" . text
  call setline(line('.'), done)
endfunction

""""""""""""""""""""
function! TodoDoneEml()
  let line = getline('.')
  let text = split(line, "]")[1]
  let done = "- [x] " . strftime("%Y-%m-%d") . " eml; " . text
  call setline(line('.'), done)
endfunction

""""""""""""""""""""
function! TodoDoneCal()
  let line = getline('.')
  let text = split(line, "]")[1]
  let done = "- [x] " . strftime("%Y-%m-%d") . " cal; " . text
  call setline(line('.'), done)
endfunction

""""""""""""""""""""
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

"""""""""""""""""""""
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

