call lib#letdefault('g:haskell_tabular', 0)

if g:haskell_tabular && exists(':Tabularize')
  call haskell#tabular()
endif
