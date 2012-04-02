function! vim2hs#haskell#tags#fasttags() " {{{
  silent !find -iname '*.hs' | xargs fast-tags
endfunction " }}}


function! vim2hs#haskell#tags#hasktags() " {{{
  silent !hasktags -c --ignore-close-implementation .
endfunction " }}}
