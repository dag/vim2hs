function! vim2hs#haskell#tags#fasttags(...) " {{{
  if a:0
    let l:files = map(copy(a:000), 'shellescape(v:val)')
    execute 'silent !fast-tags ' . join(l:files)
  else
    silent !find * -iname '*.hs' -exec fast-tags {} +
  endif
endfunction " }}}


function! vim2hs#haskell#tags#hasktags() " {{{
  silent !find * -type d -exec
    \ hasktags -c --ignore-close-implementation {} +
endfunction " }}}
