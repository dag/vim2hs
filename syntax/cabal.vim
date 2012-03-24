syntax clear

call vim2hs#cabal#comments()
call vim2hs#cabal#constants()
call vim2hs#cabal#statements()
call vim2hs#cabal#conditionals()

let b:current_syntax = "cabal"
