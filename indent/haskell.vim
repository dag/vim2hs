if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal indentexpr=vim2hs#haskell#editing#indentexpr()
setlocal indentkeys=!^F,o,O
