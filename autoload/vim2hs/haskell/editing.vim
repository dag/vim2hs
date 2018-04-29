function! vim2hs#haskell#editing#includes() " {{{
  setlocal include=^import\\s*\\(qualified\\)\\?\\s*
  setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.'
  setlocal suffixesadd=hs,lhs,hsc,hsx
endfunction " }}}


function! vim2hs#haskell#editing#indentexpr(lnum) " {{{
  let l:line = getline(a:lnum - 1)

  if l:line =~# '^\s*$'
    return 0
  endif

  let l:indent = indent(a:lnum - 1)

  if l:line =~# '^data\>.*=.\+'
    let l:indent = match(l:line, '=')

  elseif l:line =~# '^data\>[^=]\+\|^class\>\|^instance\>'
    if get(g:, "haskell_indent_double", 1)
        let l:indent = &shiftwidth * 2
    else
        let l:indent = &shiftwidth
    end

  elseif l:line =~# '^newtype\>.*=.\+'
    let l:indent = match(l:line, '=') + 2

  elseif l:line =~# '^\k\+.*=\s*\%(do\)\?$'
    if get(g:, "haskell_indent_double", 1)
        let l:indent = &shiftwidth * 2
    else
        let l:indent = &shiftwidth
    end

  elseif l:line =~# '\[[^\]]*$'
    let l:indent = match(l:line, '\[')

  elseif l:line =~# '{[^}]*$'
    let l:indent = match(l:line, '{')

  elseif l:line =~# '([^)]*$'
    let l:indent = match(l:line, '(')

  elseif l:line =~# '\<case\>.*\<of$'
    let l:indent = match(l:line, '\<case\>') + &shiftwidth

  elseif l:line =~# '\<case\>.*\<of\>'
    let l:indent = match(l:line, '\<of\>') + 3

  elseif l:line =~# '\<if\>.*\<then\>.*\%(\<else\>\)\@!'
    let l:indent = match(l:line, '\<then\>')

  elseif l:line =~# '\<if\>'
    let l:indent = match(l:line, '\<if\>') + &shiftwidth

  elseif l:line =~# '\<\%(do\|let\|where\|in\|then\|else\)$'
    let l:indent = indent(a:lnum - 1) + &shiftwidth

  elseif l:line =~# '\<do\>'
    let l:indent = match(l:line, '\<do\>') + 3

  elseif l:line =~# '\<let\>.*\s=$'
    let l:indent = match(l:line, '\<let\>') + 4 + &shiftwidth

  elseif l:line =~# '\<let\>'
    let l:indent = match(l:line, '\<let\>') + 4

  elseif l:line =~# '\<where\>'
    let l:indent = match(l:line, '\<where\>') + 6

  elseif l:line =~# '\s=$'
    let l:indent = indent(a:lnum - 1) + &shiftwidth

  endif

  if synIDattr(synIDtrans(synID(a:lnum - 1, l:indent, 1)), 'name')
    \ =~# '\%(Comment\|String\)$'
    return indent(a:lnum - 1)
  endif

  return l:indent
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


function! vim2hs#haskell#editing#formatting() " {{{
  if executable('pointfree')
    setlocal formatprg=xargs\ pointfree
  endif
  setlocal comments=s1:{-,mb:-,ex:-},:--
  setlocal commentstring=--%s
  setlocal formatoptions+=croql1
  setlocal formatoptions-=t
  silent! setlocal formatoptions+=j
  setlocal textwidth=75
endfunction " }}}


function! vim2hs#haskell#editing#tabular() " {{{
  AddTabularPattern! colon                  /^[^:]*\zs:/
  AddTabularPattern! haskell_bindings       /^[^=]*\zs=\ze[^[:punct:]]/
  AddTabularPattern! haskell_comments       /--.*/l2
  AddTabularPattern! haskell_do_arrows      / \(<-\|←\) /l0r0
  AddTabularPattern! haskell_imports        /^[^(]*\zs(.*\|\<as\>.*/
  AddTabularPattern! haskell_pattern_arrows / \(->\|→\) /l0r0
  AddTabularPattern! haskell_types          / \(::\|∷\) /l0r0
endfunction " }}}
