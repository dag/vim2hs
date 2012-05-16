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
    \ conceal cchar=λ

  syntax match jmacroConceal "<|"
    \ conceal cchar=«

  syntax match jmacroConceal "|>"
    \ conceal cchar=»

  setlocal conceallevel=2

  highlight! link jmacroConceal Operator
  highlight! link Conceal Operator
endfunction " }}}
