call vim2hs#letdefault('g:haskell_tabular', 1)

if g:haskell_tabular && exists(':Tabularize')
  call vim2hs#haskell#editing#tabular()
endif
