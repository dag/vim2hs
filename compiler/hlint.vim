if exists('current_compiler')
  finish
endif
let current_compiler = 'hlint'

CompilerSet errorformat=%f:%l:%c:\ %t%*[a-zA-Z]:\ %m
CompilerSet makeprg=hlint\ %
CompilerSet shellpipe&
