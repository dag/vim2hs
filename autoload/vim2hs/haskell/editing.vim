function! vim2hs#haskell#editing#includes() " {{{
  setlocal include=^import\\s*\\(qualified\\)\\?\\s*
  setlocal includeexpr=substitute(v:fname,'\\.','/','g')
  setlocal suffixesadd=.hs,.lhs,.hsc
endfunction " }}}


function! vim2hs#haskell#editing#indentexpr(lnum) " {{{
  let l:line = getline(a:lnum - 1)

  if l:line =~# '^\k\+.*=\s*\%(do\)\?$'
    return &shiftwidth * 2
  endif

  if l:line =~# '\[[^\]]*$'
    return match(l:line, '\[')
  endif

  if l:line =~# '{[^}]*$'
    return match(l:line, '{')
  endif

  if l:line =~# '([^)]*$'
    return matchend(l:line, '(\s*')
  endif

  if l:line =~# '\<case\>.*\<of$'
    return match(l:line, '\<case\>') + &shiftwidth
  endif

  if l:line =~# '\<if\>'
    return match(l:line, '\<if\>') + &shiftwidth
  endif

  if l:line =~# '\<where$'
    return match(l:line, '\<where$') + &shiftwidth
  endif

  if l:line =~# '\<\%(do\|let\|in\)$'
    return indent(a:lnum) + &shiftwidth
  endif

  return -1
endfunction " }}}


function! vim2hs#haskell#editing#indenting() " {{{
  setlocal indentexpr=vim2hs#haskell#editing#indentexpr(v:lnum)
  setlocal indentkeys=!^F,o,O
endfunction " }}}


function! vim2hs#haskell#editing#foldtext() " {{{
  return matchstr(getline(v:foldstart), '\k\+')
endfunction " }}}

function! vim2hs#haskell#editing#folding() " {{{
  setlocal foldmethod=syntax
  setlocal foldtext=vim2hs#haskell#editing#foldtext()
endfunction " }}}


function! vim2hs#haskell#editing#keywords() " {{{
  setlocal iskeyword=a-z,A-Z,48-57,_,'
endfunction " }}}


function! vim2hs#haskell#editing#comments() " {{{
  setlocal comments=s1:{-,mb:-,ex:-},:--
  setlocal commentstring=--%s
  setlocal formatoptions+=croql1
  setlocal formatoptions-=t
  setlocal textwidth=75
endfunction " }}}


function! vim2hs#haskell#editing#tabular() " {{{
  AddTabularPattern! colon /^[^:]*\zs:/
  AddTabularPattern! haskell_binding /^[^=]*\zs=/
  AddTabularPattern! haskell_do_arrow / <- /l0r0
  AddTabularPattern! haskell_function_arrow / -> /l0r0
  AddTabularPattern! haskell_import_as / as /l0r0
  AddTabularPattern! haskell_type / :: /l0r0
  AddTabularPattern! parenthesis /^[^(]*\zs(/l1r0
endfunction " }}}
