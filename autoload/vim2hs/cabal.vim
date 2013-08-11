function! vim2hs#cabal#comments() " {{{
  set commentstring=--%s

  syntax match cabalComment
    \ /--.*/
    \ display

  highlight default link cabalComment Comment
endfunction " }}}


function! vim2hs#cabal#defines() " {{{
  setlocal iskeyword=a-z,A-Z,-

  syntax match cabalDefine
    \ "^\s*\k\+\s*:\@="
    \ display nextgroup=cabalDelimiter

  syntax match cabalDelimiter
    \ ":"
    \ display contained

  highlight default link cabalDefine Define
  highlight default link cabalDelimiter Delimiter
endfunction " }}}


function! vim2hs#cabal#statements() " {{{
  syntax region cabalIdentifier matchgroup=cabalStatement
    \ start="\c^\%(flag\|source-repository\|test-suite\|benchmark\|executable\|library\)"
    \ end="$"
    \ display oneline

  highlight default link cabalIdentifier Identifier
  highlight default link cabalStatement Statement
endfunction " }}}


function! vim2hs#cabal#conditionals() " {{{
  syntax keyword cabalKeyword contained true false

  syntax region cabalIdentifier matchgroup=cabalKeyword
    \ start="\%(os\|arch\|impl\|flag\)("
    \ end=")"
    \ display oneline contained contains=cabalIdentifier

  syntax region cabalIdentifier matchgroup=cabalConditional
    \ start="\c^\s*\%(if\|else\|endif\)"
    \ end="$"
    \ display oneline contains=cabalIdentifier,cabalKeyword

  highlight default link cabalKeyword Keyword
  highlight default link cabalIdentifier Identifier
  highlight default link cabalConditional Conditional
endfunction " }}}


function! vim2hs#cabal#folds() " {{{
  syntax region cabalFold
    \ start='\c^\%(flag\|source-repository\|test-suite\|benchmark\|executable\|library\)\>'
    \ skip='\n#\|\n--'
    \ end='\ze\%(\s*\n\)\+\S'
    \ transparent fold

  setlocal foldmethod=syntax
  setlocal foldtext=getline(v:foldstart)
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


function! vim2hs#cabal#name() " {{{
  return substitute(expand('%:t'), '\..*', '', '')
endfunction " }}}
