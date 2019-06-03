iab sh :shipit:
iab `p ```puppet<esc>o```<esc>O
iab `r ```ruby<esc>o```<esc>O

syn match todoContext     / @\S\+/ contained
syn match todoProject     / +\S\+/ contained
syn match todotodo        /^- \[ ] .*/ contains=todoContext,todoProject
syn match todoPriorityA   /^- \[ ] :a: .*/ contains=todoContext,todoProject
syn match todoPriorityB   /^- \[ ] :b: .*/ contains=todoContext,todoProject
syn match todoDue         /^- \[ ] \d\{4}-\d\{2}-\d\{2} .*/ contains=todoContext,todoProject
syn match todoWaiting     /^- \[ ] ww @\S.*/ contains=todoContext,todoProject
syn match todoDone        /^- \[x] .*/ contains=todoContext,todoProject
syn match todoDoneDate    /^- \[\d\{4}-\d\{2}-\d\{2}] .*/ contains=todoContext,todoProject
syn match mkdemoji        /:\S\+:[ $]/ 
syn region mkdcode        start="`" end="`"
syn region mkdcode        start="^    " end="$"
syn region mkdcodeblock   start="^```" end="```$"

hi link todoContext   Conditional        
hi link todoProject   Underlined
hi link todoDone      NonText   
hi link todoDoneDate  NonText   
hi link todotodo      Identifier
hi link todoDue       Error         
hi link todoPriorityA todo
hi link todoPriorityB Type
hi link todoWaiting   Constant
hi link mkdemoji      Statement
hi link mkdcode       Type
hi link mkdcodeblock  Type
hi link markdownBold  Statement
hi link markdownItalic  Constant

abbr <leader>t - [ ]
abbr <leader>a - [ ] :a:
abbr <leader>b - [ ] :b:
abbr <leader>c - [ ] :c:
map <leader>tt / ]/<cr>
map <leader>td / ] \d\+/<cr>
map <leader>ta / ] :a:/<cr>
map <leader>tb / ] :b:/<cr>
map <leader>tc / ] :c:/<cr>
map <leader>x mx0/ ]<cr>xi<c-r>=strftime("%Y-%m-%d")<cr><esc>''
map <leader>xa mx0/ ]<cr>xi<c-r>=strftime("%Y-%m-%d")<cr><esc>ddGp''


"" ****************************
"" Conditional syntax highlighting
"function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
"  let ft=toupper(a:filetype)
"  let group='textGroup'.ft
"  if exists('b:current_syntax')
"    let s:current_syntax=b:current_syntax
"    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
"    " do nothing if b:current_syntax is defined.
"    unlet b:current_syntax
"  endif
"  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
"  try
"    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
"  catch
"  endtry
"  if exists('s:current_syntax')
"    let b:current_syntax=s:current_syntax
"  else
"    unlet b:current_syntax
"  endif
"  execute 'syntax region textSnip'.ft.'
"  \ matchgroup='.a:textSnipHl.'
"  \ start="'.a:start.'" end="'.a:end.'"
"  \ contains=@'.group
"endfunction
"call TextEnableCodeSnip('puppet'   ,'^```puppet$'   ,'^```$', 'SpecialComment'  ) 
"call TextEnableCodeSnip('ruby'   ,'```ruby$'   ,'```', 'SpecialComment'  ) 
