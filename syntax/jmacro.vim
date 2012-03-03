runtime! syntax/javascript.vim


call vim2hs#letdefault('g:jmacro_conceal', 1)


call vim2hs#jmacro#keywords()

if g:jmacro_conceal
  call vim2hs#jmacro#conceal()
endif


let b:current_syntax = "jmacro"
