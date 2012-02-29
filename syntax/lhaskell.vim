syntax clear

runtime! syntax/markdown.vim

syntax include @haskell syntax/haskell.vim

syntax region hsLiterate matchgroup=hsLiterateDelimiter
  \ start="^>" end="$"
  \ keepend contains=@haskell

highlight! link hsLiterateDelimiter Delimiter

let b:current_syntax = "lhaskell"
