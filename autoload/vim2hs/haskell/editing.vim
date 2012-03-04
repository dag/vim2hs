function! vim2hs#haskell#editing#includes() " {{{
  setlocal include=^import\\s*\\(qualified\\)\\?\\s*
  setlocal includeexpr=substitute(v:fname,'\\.','/','g')
  setlocal suffixesadd=.hs,.lhs,.hsc
endfunction " }}}


function! vim2hs#haskell#editing#keywords() " {{{
  setlocal iskeyword=a-z,A-Z,48-57,_,'
endfunction " }}}


function! vim2hs#haskell#editing#comments() " {{{
  setlocal comments=s1:{-,mb:-,ex:-},:--
  setlocal commentstring=--%s
  setlocal formatoptions+=croqa1
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
