if exists('current_compiler')
  finish
endif
let current_compiler = 'hlint'

call vim2hs#letdefault('g:hlint_args', '--language=XmlSyntax')

execute 'CompilerSet makeprg=hlint\ ' . g:hlint_args . '\ %'

let s:errorformat = join([
  \ '%W%f:%l:%c: Warning: %m',
  \ '%E%f:%l:%c: Error: %m',
  \ '%E%f:%l:%c: Parse error',
  \ '%+C%m',
  \ '%-Z',
  \ ], ',')
execute 'CompilerSet errorformat=' . escape(s:errorformat, ' ')

CompilerSet shellpipe&
