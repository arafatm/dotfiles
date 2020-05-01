syntax match mkdTodo      /- \[ ]/
syntax match mkdTodoA     /- \[ ] :a:/ 
syntax match mkdTodoB     /- \[ ] :b:/ 
syntax match mkdTodoDone  /- \[x] .*/ 

syntax match mkdDelegate   / @\S\+/ 
syntax match mkdDelegated  / \.\S\+/ 
syntax match mkdEmoji     / :\S\+:/ " highlight emoji
syntax match mkdLink      /\S\+:\/\/\S\+/
syntax match mkdProject   / \!\S\+/ 
syntax match mkdTags      / \#\S\+/ 

hi def link mkdTodo     DiffAdd
hi def link mkdTodoA    DiffDelete
hi def link mkdTodoB    DiffText
hi def link mkdTodoDone Comment

hi def link mkdDelegate Statement
hi def link mkdDelegated Statement
hi def link mkdEmoji    Special
hi def link mkdLink     Underlined
hi def link mkdProject  Constant
hi def link mkdTags     PreProc 
