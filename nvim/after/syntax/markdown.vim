syntax match mkdelegate   / @\S\+/ 
syntax match mkdproject   / !\S\+/ 
syntax match mkdtags      / #\S\+/ 
syntax match mkdeldone    / \.\S\+/ 
syntax match mkdemoji     /:\S\+:/ " highlight emoji
syntax match mkdtodo      /- \[ ]/
syntax match mkdPriA      /- \[ ] :a:/ 
syntax match mkdPriB      /- \[ ] :b:/ 
syntax match mkdlink      /\S\+:\/\/\S\+/

hi def link mkdemoji    Constant
hi def link mkdPriA     DiffDelete
hi def link mkdPriB     DiffAdd
hi def link mkdtodo     DiffChange
hi def link mkdtags     Number
hi def link mkdelegate  Special
hi def link mkdproject  Identifier
hi def link mkdlink     htmlLink
"match WarningMsg  /:a:/

