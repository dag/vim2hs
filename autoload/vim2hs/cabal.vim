function! vim2hs#cabal#comments() " {{{
  set commentstring=--%s

  syntax match cabalComment
    \ /--.*/

  highlight! link cabalComment Comment
endfunction " }}}


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
    \ start="\c^\%(flag\|source-repository\|test-suite\|benchmark\|executable\|library\)"
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


function! vim2hs#cabal#vcs() " {{{
  if isdirectory('.git')
    return 'git'
  elseif isdirectory('_darcs')
    return 'darcs'
  elseif isdirectory('.hg')
    return 'mercurial'
  elseif isdirectory('.svn')
    return 'svn'
  elseif isdirectory('.bzr')
    return 'bazaar'
  else
    return '(unknown)'
  endif
endfunction " }}}
