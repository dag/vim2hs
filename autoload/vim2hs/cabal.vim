function! vim2hs#cabal#constants() " {{{
  setlocal iskeyword=a-z,A-Z,-

  syntax match cabalConstant
    \ "^\s*\k\+\s*:\@="
    \ nextgroup=cabalDelimiter

  syntax match cabalDelimiter
    \ ":"
    \ contained

  highlight! link cabalConstant Constant
  highlight! link cabalDelimiter Delimiter
endfunction " }}}


function! vim2hs#cabal#statements() " {{{
  syntax region cabalIdentifier matchgroup=cabalStatement
    \ start="\c^\%(flag\|source-repository\|test-suite\|executable\|library\)"
    \ end="$"

  highlight! link cabalIdentifier Identifier
  highlight! link cabalStatement Statement
endfunction " }}}


function! vim2hs#cabal#conditionals() " {{{
  syntax keyword cabalKeyword contained true false

  syntax region cabalIdentifier matchgroup=cabalKeyword
    \ start="\%(os\|arch\|impl\|flag\)("
    \ end=")"
    \ contained contains=cabalIdentifier

  syntax region cabalIdentifier matchgroup=cabalConditional
    \ start="\c^\s*\%(if\|else\|endif\)"
    \ end="$"
    \ contains=cabalIdentifier,cabalKeyword

  highlight! link cabalKeyword Keyword
  highlight! link cabalIdentifier Identifier
  highlight! link cabalConditional Conditional
endfunction " }}}
