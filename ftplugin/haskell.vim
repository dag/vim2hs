if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal includeexpr=haskell#includeexpr(v:fname)

command -buffer -nargs=* HLint call haskell#hlint(<q-args>)
