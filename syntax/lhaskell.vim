syntax clear
runtime! syntax/markdown.vim
unlet b:current_syntax

call haskell#literate()

let b:current_syntax = "lhaskell"
