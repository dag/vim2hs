function! vim2hs#cabalconfig#comments() " {{{
  set commentstring=--%s

  syntax match ccComment
    \ /--.*/
    \ display

  highlight default link ccComment Comment
endfunction " }}}


function! vim2hs#cabalconfig#constants() " {{{
  setlocal iskeyword=a-z,A-Z,-

  syntax case match

  syntax match ccDefine
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

  highlight default link ccDefine Define
  highlight default link ccDelimiter Delimiter
  highlight default link ccBoolean Boolean
  highlight default link ccNumber Number
  highlight default link ccFloat Float
endfunction " }}}


function! vim2hs#cabalconfig#statements() " {{{
  syntax region ccIdentifier matchgroup=ccStatement
    \ start='\c^\%(install-dirs\)\>'
    \ end='$'
    \ display oneline

  highlight default link ccIdentifier Identifier
  highlight default link ccStatement Statement
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
