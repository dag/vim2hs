syntax clear


if !exists('g:haskell_cpp')
  let g:haskell_cpp = 1
endif

if !exists('g:haskell_th')
  let g:haskell_th = 1
endif

if !exists('g:haskell_quasi')
  let g:haskell_quasi = 1
endif

if !exists('g:haskell_jmacro')
  let g:haskell_jmacro = 1
endif

if !exists('g:haskell_hsp')
  let g:haskell_hsp = 1
endif

if !exists('g:haskell_conceal')
  let g:haskell_conceal = 1
endif

if !exists('g:haskell_conceal_wide')
  let g:haskell_conceal_wide = 0
endif

if !exists('g:haskell_conceal_bad')
  let g:haskell_conceal_bad = 0
endif


call haskell#keywords(1)

call haskell#bindings()

call haskell#strings()

if g:haskell_cpp
  call haskell#cpp()
endif

if g:haskell_th
  call haskell#th()
endif

if g:haskell_quasi
  call haskell#quasi()
endif

if g:haskell_jmacro
  call haskell#jmacro()
endif

if g:haskell_hsp
  call haskell#hsp()
endif

if g:haskell_conceal
  call haskell#conceal(g:haskell_conceal_wide, g:haskell_conceal_bad)
endif


let b:current_syntax = "haskell"
