runtime! syntax/javascript.vim


if !exists('g:jmacro_conceal')
  let g:jmacro_conceal = 1
endif


call jmacro#keywords()

if g:jmacro_conceal
  call jmacro#conceal()
endif


let b:current_syntax = "jmacro"
