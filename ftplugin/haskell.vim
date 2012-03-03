if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

call vim2hs#haskell#editing#includes()

command -buffer -nargs=* HLint call vim2hs#haskell#editing#hlint(<q-args>)
