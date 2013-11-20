scriptencoding utf-8

let vim2hs#jmacro#errorformat = join([
  \ '(line %l\, column %c):%m',
  \ '%E(line %l\, column %c):',
  \ '%+Cunexpected %m',
  \ '%+Zexpecting %m'
  \ ], ',')


function vim2hs#jmacro#keywords() " {{{
  syntax keyword javaScriptFunction fun
endfunction " }}}


function! vim2hs#jmacro#conceal() " {{{
  syntax match jmacroConceal
    \ "\\\ze[[:alpha:][:space:]_([]"
    \ display conceal cchar=λ

  syntax match jmacroConceal "<|"
    \ display conceal cchar=«

  syntax match jmacroConceal "|>"
    \ display conceal cchar=»

  setlocal conceallevel=2

  highlight default link jmacroConceal Operator
  highlight default link Conceal Operator
endfunction " }}}
