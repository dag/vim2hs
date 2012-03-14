function! vim2hs#haskell#editing#includes() " {{{
  setlocal include=^import\\s*\\(qualified\\)\\?\\s*
  setlocal includeexpr=substitute(v:fname,'\\.','/','g')
  setlocal suffixesadd=.hs,.lhs,.hsc
endfunction " }}}


function! vim2hs#haskell#editing#indentexpr(lnum) " {{{
  let l:line = getline(a:lnum - 1)

  if l:line =~# '^\s*$'
    return 0
  endif

  if l:line =~# '^data\>.*=.\+'
    return match(l:line, '=')
  endif

  if l:line =~# '^data\>[^=]\+'
    return &shiftwidth
  endif

  if l:line =~# '^newtype\>.*=.\+'
    return match(l:line, '=') + 2
  endif

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

  if l:line =~# '\<case\>.*\<of\>'
    return match(l:line, '\<of\>') + 3
  endif

  if l:line =~# '\<if\>.*\<then\>.*\%(\<else\>\)\@!'
    return match(l:line, '\<then\>')
  endif

  if l:line =~# '\<if\>'
    return match(l:line, '\<if\>') + &shiftwidth
  endif

  if l:line =~# '\<\%(do\|let\|where\|in\|then\|else\)$'
    return indent(a:lnum - 1) + &shiftwidth
  endif

  if l:line =~# '\<do\>'
    return match(l:line, '\<do\>') + 3
  endif

  if l:line =~# '\<let\>'
    return match(l:line, '\<let\>') + 4
  endif

  if l:line =~# '\<where\>'
    return match(l:line, '\<where\>') + 6
  endif

  return -1
endfunction " }}}


function! vim2hs#haskell#editing#indenting() " {{{
  setlocal indentexpr=vim2hs#haskell#editing#indentexpr(v:lnum)
  setlocal indentkeys=!^F,o,O
endfunction " }}}


function! vim2hs#haskell#editing#foldtext() " {{{
  let l:line = getline(v:foldstart)
  let l:keyword = matchstr(l:line, '\k\+')
  if count(['type', 'newtype', 'data'], l:keyword)
    return substitute(l:line, '\s*=.*', '', '') . ' '
  elseif count(['class', 'instance'], l:keyword)
    return substitute(l:line, '\s*\<where\>.*', '', '') . ' '
  endif
  return l:keyword . ' = '
endfunction " }}}


function! vim2hs#haskell#editing#folding() " {{{
  setlocal foldmethod=syntax
  setlocal foldtext=vim2hs#haskell#editing#foldtext()
endfunction " }}}


function! vim2hs#haskell#editing#keywords() " {{{
  setlocal iskeyword=@,48-57,_,'
  setlocal keywordprg=hoogle\ -i
endfunction " }}}


function! vim2hs#haskell#editing#comments() " {{{
  setlocal comments=s1:{-,mb:-,ex:-},:--
  setlocal commentstring=--%s
  setlocal formatoptions+=croql1
  setlocal formatoptions-=t
  setlocal textwidth=75
endfunction " }}}


function! vim2hs#haskell#editing#tabular() " {{{
  AddTabularPattern! colon                  /^[^:]*\zs:/
  AddTabularPattern! haskell_bindings       /^[^=]*\zs=/
  AddTabularPattern! haskell_do_arrows      / <- /l0r0
  AddTabularPattern! haskell_imports        /^[^(]*\zs(.*\|\<as\>.*/
  AddTabularPattern! haskell_pattern_arrows / -> /l0r0
  AddTabularPattern! haskell_types          / :: /l0r0
endfunction " }}}
