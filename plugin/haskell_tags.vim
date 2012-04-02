if glob('*.cabal') ==# ''
  finish
endif

call vim2hs#letdefault('g:haskell_autotags'       , 0)
call vim2hs#letdefault('g:haskell_tags_generator' , 'fast-tags')

if !g:haskell_autotags
  finish
endif

if g:haskell_tags_generator ==# 'fast-tags'
  if !executable('fast-tags') | finish | endif
  autocmd BufWritePost *.hs call vim2hs#haskell#tags#fasttags(expand('%'))
  call vim2hs#haskell#tags#fasttags()
elseif g:haskell_tags_generator == 'hasktags'
  if !executable('hasktags') | finish | endif
  autocmd BufWritePost *.hs call vim2hs#haskell#tags#hasktags()
  call vim2hs#haskell#tags#hasktags()
endif
