function! vim2hs#haskell#conceal#simple() " {{{
  syntax match hsConceal
    \ "\\\ze[[:alpha:][:space:]_([]"
    \ conceal cchar=λ

  syntax match hsConceal
    \ "\s\.\_s"ms=s+1,me=e-1
    \ conceal cchar=∘

  setlocal conceallevel=2

  highlight! link hsConceal Operator
  highlight! link Conceal Operator
endfunction " }}}


" These can mess up the layout (alignment)
function! vim2hs#haskell#conceal#wide() " {{{
  syntax match hsConceal
    \ "\s/=\_s"ms=s+1,me=e-1
    \ conceal cchar=≠

  syntax match hsConceal
    \ "\s::\_s"ms=s+1,me=e-1
    \ conceal cchar=⦂

  syntax match hsConceal
    \ "\s>>\_s"ms=s+1,me=e-1
    \ conceal cchar=»

  syntax match hsConceal
    \ "\s<<\_s"ms=s+1,me=e-1
    \ conceal cchar=«

  syntax match hsConceal
    \ "\<sum\>"
    \ conceal cchar=∑

  syntax match hsConceal
    \ "\<product\>"
    \ conceal cchar=∏

  syntax match hsConceal
    \ "\<sqrt\>"
    \ conceal cchar=√
endfunction " }}}


" These work badly in the fonts I've tested.
function! vim2hs#haskell#conceal#bad() " {{{
  syntax match hsConceal
    \ "\<elem\>"
    \ conceal cchar=∈

  syntax match hsConceal
    \ "\<notElem\>"
    \ conceal cchar=∉

  syntax match hsConceal
    \ "()"
    \ conceal cchar=∅

  syntax match hsConceal
    \ "\s->\_s"ms=s+1,me=e-1
    \ conceal cchar=→

  syntax match hsConceal
    \ "\s<-\_s"ms=s+1,me=e-1
    \ conceal cchar=←
endfunction " }}}
