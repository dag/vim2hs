function! vim2hs#cabalconfig#comments() " {{{
  set commentstring=--%s

  syntax match ccComment
    \ /--.*/
    \ display

  highlight! link ccComment Comment
endfunction " }}}


function! vim2hs#cabalconfig#constants() " {{{
  setlocal iskeyword=a-z,A-Z,-

  syntax case match

  syntax match ccKeyword
    \ "^\s*\k\+\s*:\@="
    \ display nextgroup=ccDelimiter

  syntax match ccDelimiter
    \ ":"
    \ display contained

  syntax keyword ccBoolean
    \ True False

  syntax match ccNumber
    \ '\<[0-9]\+\>'
    \ display

  syntax match ccFloat
    \ '\<[0-9]\+\.[0-9]\+'
    \ display

  highlight! link ccKeyword Keyword
  highlight! link ccDelimiter Delimiter
  highlight! link ccBoolean Boolean
  highlight! link ccNumber Number
  highlight! link ccFloat Float
endfunction " }}}


function! vim2hs#cabalconfig#statements() " {{{
  syntax region ccIdentifier matchgroup=ccStatement
    \ start='\c^\%(install-dirs\)\>'
    \ end='$'
    \ display oneline

  highlight! link ccIdentifier Identifier
  highlight! link ccStatement Statement
endfunction " }}}


function! vim2hs#cabalconfig#folds() " {{{
  syntax region ccFold
    \ start='\c^\%(install-dirs\)\>'
    \ skip='\n#\|\n--'
    \ end='\ze\%(\s*\n\)\+\S'
    \ transparent fold

  setlocal foldmethod=syntax
  setlocal foldtext=getline(v:foldstart)
endfunction " }}}
