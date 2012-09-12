if exists('current_compiler')
  finish
endif
let current_compiler = 'cabal'

let s:errorformat = join([
  \ '%A%f:%l:%c:',
  \ '%A%f:%l:%c: %m',
  \ '%+C    %m',
  \ '%-Z%[%^ ]',
  \ ], ',')
execute 'CompilerSet errorformat=' . escape(s:errorformat, ' ')

CompilerSet makeprg=cabal\ build\ --ghc-option=-fno-code
CompilerSet shellpipe&
