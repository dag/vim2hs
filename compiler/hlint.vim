if exists('current_compiler')
  finish
endif
let current_compiler = 'hlint'

call vim2hs#letdefault('g:hlint_args', '"--language=XmlSyntax"')

execute 'CompilerSet makeprg=hlint\ ' . g:hlint_args . '\ %'

CompilerSet errorformat=%f:%l:%c:\ %t%*[a-zA-Z]:\ %m
CompilerSet shellpipe&
