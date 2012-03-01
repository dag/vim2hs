runtime! syntax/javascript.vim


call lib#letdefault('g:jmacro_conceal', 1)


call jmacro#keywords()

if g:jmacro_conceal
  call jmacro#conceal()
endif


let b:current_syntax = "jmacro"
