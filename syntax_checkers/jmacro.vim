if exists('g:loaded_jmacro_syntax_checker')
  finish
endif
let g:loaded_jmacro_syntax_checker = 1

if !executable('jmacro')
  finish
endif

let s:errorformat = vim2hs#jmacro#errorformat

function! SyntaxCheckers_jmacro_GetLocList() " {{{
  let l:makeprg     = 'jmacro ' . shellescape(expand('%'))
  return SyntasticMake({'makeprg'    : l:makeprg,
                       \'errorformat': s:errorformat})
endfunction " }}}
