function! vim2hs#haskell#conceal#simple() " {{{
  syntax match hsConceal
    \ "\\\ze[[:alpha:][:space:]_([]"
    \ display conceal cchar=λ

  syntax match hsConceal
    \ "\s\.\_s"ms=s+1,me=e-1
    \ display conceal cchar=∘

  setlocal conceallevel=2

  highlight! link hsConceal Operator
  highlight! link Conceal Operator
endfunction " }}}


" These can mess up the layout (alignment)
function! vim2hs#haskell#conceal#wide() " {{{
  syntax match hsConceal
    \ "\s/=\_s"ms=s+1,me=e-1
    \ display conceal cchar=≠

  syntax match hsConceal
    \ "\s::\_s"ms=s+1,me=e-1
    \ display conceal cchar=⦂

  syntax match hsConceal
    \ "\s>>\_s"ms=s+1,me=e-1
    \ display conceal cchar=»

  syntax match hsConceal
    \ "\s<<\_s"ms=s+1,me=e-1
    \ display conceal cchar=«

  syntax match hsConceal
    \ "\<sum\>"
    \ display conceal cchar=∑

  syntax match hsConceal
    \ "\<product\>"
    \ display conceal cchar=∏

  syntax match hsConceal
    \ "\<sqrt\>"
    \ display conceal cchar=√
endfunction " }}}


" These work badly in the fonts I've tested.
function! vim2hs#haskell#conceal#bad() " {{{
  syntax match hsConceal
    \ "\<elem\>"
    \ display conceal cchar=∈

  syntax match hsConceal
    \ "\<notElem\>"
    \ display conceal cchar=∉

  syntax match hsConceal
    \ "()"
    \ display conceal cchar=∅

  syntax match hsConceal
    \ "\s->\_s"ms=s+1,me=e-1
    \ display conceal cchar=→

  syntax match hsConceal
    \ "\s<-\_s"ms=s+1,me=e-1
    \ display conceal cchar=←
endfunction " }}}
