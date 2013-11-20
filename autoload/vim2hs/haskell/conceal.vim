scriptencoding utf-8

function! vim2hs#haskell#conceal#simple() " {{{
  syntax match hsStructure
    \ "\\\ze[[:alpha:][:space:]_([]"
    \ display conceal cchar=λ

  syntax match hsOperator
    \ "\s\.\_s"ms=s+1,me=e-1
    \ display conceal cchar=∘

  setlocal conceallevel=2

  highlight default link Conceal Operator
endfunction " }}}


" These can mess up the layout (alignment)
function! vim2hs#haskell#conceal#wide() " {{{
  syntax match hsOperator
    \ "\s/=\_s"ms=s+1,me=e-1
    \ display conceal cchar=≠

  syntax match hsStructure
    \ "\s::\_s"ms=s+1,me=e-1
    \ display conceal cchar=⦂

  syntax match hsOperator
    \ "\s>>\_s"ms=s+1,me=e-1
    \ display conceal cchar=»

  syntax match hsOperator
    \ "\s<<\_s"ms=s+1,me=e-1
    \ display conceal cchar=«

  syntax match hsKeyword
    \ "\<sum\>"
    \ display conceal cchar=∑

  syntax match hsKeyword
    \ "\<product\>"
    \ display conceal cchar=∏

  syntax match hsKeyword
    \ "\<sqrt\>"
    \ display conceal cchar=√

  syntax match hsStructure
    \ "\s->\_s"ms=s+1,me=e-1
    \ display conceal cchar=→

  syntax match hsStructure
    \ "\s<-\_s"ms=s+1,me=e-1
    \ display conceal cchar=←

  syntax match hsOperator
    \ "\s<>\_s"ms=s+1,me=e-1
    \ display conceal cchar=•

  syntax match hsOperator
    \ "\s!!\_s"ms=s+1,me=e-1
    \ display conceal cchar=‼

  syntax match hsOperator
    \ "\s&&\_s"ms=s+1,me=e-1
    \ display conceal cchar=∧

  syntax match hsOperator
    \ "\s||\_s"ms=s+1,me=e-1
    \ display conceal cchar=∨

  syntax match hsOperator
    \ "`intersect\%(ion\)\?`"
    \ display conceal cchar=∩

  syntax match hsOperator
    \ "`union`"
    \ display conceal cchar=∪
endfunction " }}}


" These work badly in GVIM with the fonts I've tested.
function! vim2hs#haskell#conceal#bad() " {{{
  syntax match hsKeyword
    \ "\<elem\>"
    \ display conceal cchar=∈

  syntax match hsKeyword
    \ "\<notElem\>"
    \ display conceal cchar=∉

  syntax match hsStructure
    \ "()"
    \ display conceal cchar=∅

  syntax match hsStructure
    \ '\s=>\s'ms=s+1,me=e-1
    \ display conceal cchar=⇒

  syntax match hsOperator
    \ '\s\~>\s'ms=s+1,me=e-1
    \ display conceal cchar=⇝

  syntax match hsOperator
    \ '\s>>>\s'ms=s+1,me=e-1
    \ display conceal cchar=↠

  syntax match hsOperator
    \ '\s<<<\s'ms=s+1,me=e-1
    \ display conceal cchar=↞

  syntax match hsStructure
    \ '\s-<\s'ms=s+1,me=e-1
    \ display conceal cchar=↢

  syntax match hsStructure
    \ '\s>-\s'ms=s+1,me=e-1
    \ display conceal cchar=↣

  syntax match hsStructure
    \ '\s-<<\s'ms=s+1,me=e-1
    \ display conceal cchar=⇺
endfunction " }}}
