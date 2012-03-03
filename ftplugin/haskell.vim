if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

call vim2hs#haskell#editing#includes()
call vim2hs#haskell#editing#keywords()
call vim2hs#haskell#editing#comments()

command -buffer -nargs=* HLint call vim2hs#haskell#editing#hlint(<q-args>)
