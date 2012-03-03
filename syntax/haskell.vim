syntax clear


call vim2hs#letdefault('g:haskell_haddock'       , 1)
call vim2hs#letdefault('g:haskell_cpp'           , 1)
call vim2hs#letdefault('g:haskell_th'            , 1)
call vim2hs#letdefault('g:haskell_quasi'         , 1)
call vim2hs#letdefault('g:haskell_interpolation' , 1)
call vim2hs#letdefault('g:haskell_regex'         , 1)
call vim2hs#letdefault('g:haskell_jmacro'        , 1)
call vim2hs#letdefault('g:haskell_shqq'          , 1)
call vim2hs#letdefault('g:haskell_sql'           , 1)
call vim2hs#letdefault('g:haskell_hsp'           , 1)
call vim2hs#letdefault('g:haskell_conceal'       , 1)
call vim2hs#letdefault('g:haskell_conceal_wide'  , 0)
call vim2hs#letdefault('g:haskell_conceal_bad'   , 0)


call vim2hs#haskell#syntax#operators()

if g:haskell_cpp
  call vim2hs#haskell#syntax#cpp()
endif

if g:haskell_th
  call vim2hs#haskell#syntax#th()
endif

if g:haskell_quasi
  call vim2hs#haskell#quasi#quote()
endif

if g:haskell_interpolation
  call vim2hs#haskell#quasi#interpolation()
endif

if g:haskell_regex
  call vim2hs#haskell#quasi#regex()
endif

if g:haskell_jmacro
  call vim2hs#haskell#quasi#jmacro()
endif

if g:haskell_shqq
  call vim2hs#haskell#quasi#shqq()
endif

if g:haskell_sql
  call vim2hs#haskell#quasi#sql()
endif

if g:haskell_hsp
  call vim2hs#haskell#syntax#hsp()
endif

if g:haskell_conceal
  call vim2hs#haskell#conceal#simple()

  if g:haskell_conceal_wide
    call vim2hs#haskell#conceal#wide()
  endif

  if g:haskell_conceal_bad
    call vim2hs#haskell#conceal#bad()
  endif
endif

call vim2hs#haskell#syntax#keywords(1)
call vim2hs#haskell#syntax#numbers()
call vim2hs#haskell#syntax#bindings()
call vim2hs#haskell#syntax#strings()
call vim2hs#haskell#syntax#comments()

if g:haskell_haddock
  call vim2hs#haskell#syntax#haddock()
endif


let b:current_syntax = "haskell"
