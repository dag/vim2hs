call vim2hs#haskell#editing#includes()
call vim2hs#haskell#editing#keywords()
call vim2hs#haskell#editing#formatting()

if get(g:, 'haskell_fold', 1) == 1
    call vim2hs#haskell#editing#folding()
endif

if executable('hlint')
  command! -buffer -nargs=* HLint call vim2hs#with_compiler('hlint', <q-args>)
endif

if executable('pointfree')
  command! -buffer -range -bang PointFree call vim2hs#pointfree(<q-bang>)
endif
