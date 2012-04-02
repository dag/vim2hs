if exists('current_compiler')
  finish
endif
let current_compiler = 'cabal'

let s:errorformat = join([
  \ '%E%f:%l:%c:',
  \ '%+C    %m',
  \ '%-Z%[%^ ]',
  \ ], ',')
execute 'CompilerSet errorformat=' . escape(s:errorformat, ' ')

CompilerSet makeprg=cabal\ build
CompilerSet shellpipe&
