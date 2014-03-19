syntax clear


call vim2hs#letdefault('g:haskell_haddock'              , 0)
call vim2hs#letdefault('g:haskell_ffi'                  , 1)
call vim2hs#letdefault('g:haskell_cpp'                  , 1)
call vim2hs#letdefault('g:haskell_th'                   , 1)
call vim2hs#letdefault('g:haskell_quasi'                , 1)
call vim2hs#letdefault('g:haskell_interpolation'        , 1)
call vim2hs#letdefault('g:haskell_regex'                , 1)
call vim2hs#letdefault('g:haskell_jmacro'               , 1)
call vim2hs#letdefault('g:haskell_shqq'                 , 1)
call vim2hs#letdefault('g:haskell_rlangqq'              , 1)
call vim2hs#letdefault('g:haskell_sql'                  , 1)
call vim2hs#letdefault('g:haskell_json'                 , 1)
call vim2hs#letdefault('g:haskell_xml'                  , 1)
call vim2hs#letdefault('g:haskell_hsp'                  , 1)
call vim2hs#letdefault('g:haskell_conceal'              , 1)
call vim2hs#letdefault('g:haskell_conceal_comments'     , 0)
call vim2hs#letdefault('g:haskell_conceal_enumerations' , 1)
call vim2hs#letdefault('g:haskell_conceal_wide'         , 0)
call vim2hs#letdefault('g:haskell_conceal_bad'          , 0)
call vim2hs#letdefault('g:haskell_multiline_strings'    , 0)


call vim2hs#haskell#syntax#operators()

if g:haskell_ffi
  call vim2hs#haskell#syntax#ffi()
endif

if g:haskell_cpp
  call vim2hs#haskell#syntax#cpp()
endif

call vim2hs#haskell#syntax#delimiters()

if g:haskell_quasi
  call vim2hs#haskell#quasi#quote()
endif

if g:haskell_th
  call vim2hs#haskell#syntax#th()
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

if g:haskell_json
  call vim2hs#haskell#quasi#json()
endif

if g:haskell_xml
  call vim2hs#haskell#quasi#xml()
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

call vim2hs#haskell#syntax#numbers()

call vim2hs#haskell#syntax#bindings()

call vim2hs#haskell#syntax#keywords(
  \ g:haskell_conceal && g:haskell_conceal_wide,
  \ g:haskell_conceal && g:haskell_conceal_enumerations,
  \ g:haskell_conceal && g:haskell_conceal_bad)

call vim2hs#haskell#syntax#types()

call vim2hs#haskell#syntax#folds()

call vim2hs#haskell#syntax#strings(
  \ g:haskell_multiline_strings)

call vim2hs#haskell#syntax#comments(
  \ g:haskell_conceal && g:haskell_conceal_comments,
  \ g:haskell_conceal && g:haskell_conceal_enumerations)

if g:haskell_haddock
  call vim2hs#haskell#syntax#haddock()
endif

if g:haskell_rlangqq
  call vim2hs#haskell#quasi#rlangqq()
endif


let b:current_syntax = "haskell"
