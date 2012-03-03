if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

call haskell#includes()

command -buffer -nargs=* HLint call haskell#hlint(<q-args>)
