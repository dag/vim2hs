function! vim2hs#haskell#snippets#module_name() " {{{
  let l:path = substitute(expand('%:r'), '\%(\U[^/]*/\)*', '', '')
  return substitute(l:path, '/', '.', 'g')
endfunction " }}}
