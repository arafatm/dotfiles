syntax match mkdCode      / \$.*\$/ 
syntax match mkdDate      /\d\d\d\d\.\d\d\.\d\d/
syntax match mkdDelegate  / @\S\+/ 
syntax match mkdDelegated / \.\S\+/ 
syntax match mkdEmoji     /:\S\{-}:/ " highlight emoji
syntax match mkdLink      /[a-z]\+:\/\/\S\+/
syntax match mkdProject   / \!\S\+/ 
syntax match mkdQuote     /^> .*/ 
syntax match mkdTags      / >\S\+/ 
syntax match mkdTags      / \#\S\+/ 
syntax match mkdTodo      /- \[ ]/
syntax match mkdTodoA     /- \[ ] :a:/ 
syntax match mkdTodoB     /- \[ ] :b:/ 
syntax match mkdTodoDone  /- \[x] .*/ 

hi! link markdownItalic Underlined
hi! link markdownBold Special

hi def link mkdCode       PreProc
hi def link mkdDelegate   Statement
hi def link mkdDelegated  Statement
hi def link mkdEmoji      Constant
hi def link mkdLink       MarkdownLinkText
hi def link mkdProject    Constant
hi def link mkdQuote      Statement
hi def link mkdTags       PreProc 
hi def link mkdTodo     DiffChange
hi def link mkdTodoA    DiffDelete
hi def link mkdTodoB    DiffAdd
hi def link mkdTodoDone PreProc
hi def link mkdDate DiffChange


set conceallevel=2

syntax sync fromstart
