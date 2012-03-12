runtime! syntax/html.vim

call vim2hs#heist#tags()
call vim2hs#heist#substitution()

let b:current_syntax = 'heist'
