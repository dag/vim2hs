function jmacro#keywords() " {{{
  syntax keyword javaScriptFunction fun
endfunction " }}}


function! jmacro#conceal() " {{{
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
