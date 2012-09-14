syntax clear

call vim2hs#cabalconfig#comments()
call vim2hs#cabalconfig#constants()
call vim2hs#cabalconfig#statements()
call vim2hs#cabalconfig#folds()

let b:current_syntax = "cabalconfig"
