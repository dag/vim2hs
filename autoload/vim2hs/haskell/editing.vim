function! vim2hs#haskell#editing#includes() " {{{
  setlocal include=^import\\s*\\(qualified\\)\\?\\s*
  setlocal includeexpr=substitute(v:fname,'\\.','/','g')
  setlocal suffixesadd=.hs,.lhs,.hsc
endfunction " }}}


function! vim2hs#haskell#editing#indentexpr() " {{{
  let l:line = getline(line('.') - 1)
  let l:cur = match(l:line, '\S')

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

  if l:line =~# '\<\%(do\|let\|in\|where\)$\|\<if\>\|\<case\>.*\<of$'
    return l:cur + &shiftwidth
  endif

  return l:cur
endfunction " }}}


function! vim2hs#haskell#editing#indenting() " {{{
  setlocal indentexpr=vim2hs#haskell#editing#indentexpr()
  setlocal indentkeys=!^F,o,O
endfunction " }}}


function! vim2hs#haskell#editing#foldexpr(lnum) " {{{
  let l:line = getline(a:lnum)
  if l:line =~# '^\s*--'
    return 2
  elseif l:line =~# '^\s\+\|^#'
    return 1
  endif
  return 0
endfunction " }}}


function! vim2hs#haskell#editing#folding() " {{{
  setlocal foldexpr=vim2hs#haskell#editing#foldexpr(v:lnum)
  setlocal foldmethod=expr
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
