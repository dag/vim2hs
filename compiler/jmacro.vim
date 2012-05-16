if exists('current_compiler')
  finish
endif
let current_compiler = 'jmacro'

execute 'CompilerSet errorformat=' . escape(vim2hs#jmacro#errorformat, ' ,')

CompilerSet makeprg=jmacro\ %
CompilerSet shellpipe&
