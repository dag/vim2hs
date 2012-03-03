function! vim2hs#haskell#editing#includes() " {{{
  setlocal include=^import\\s*\\(qualified\\)\\?\\s*
  setlocal includeexpr=substitute(v:fname,'\\.','/','g')
  setlocal suffixesadd=.hs,.lhs,.hsc
endfunction " }}}


function! vim2hs#haskell#editing#hlint(args) " {{{
  if exists('b:current_compiler')
    let l:previous_compiler = b:current_compiler
  endif
  compiler hlint
  execute "make " . a:args
  if exists('l:previous_compiler')
    execute "compiler " . l:previous_compiler
  endif
endfunction " }}}


function! vim2hs#haskell#editing#tabular() " {{{
  AddTabularPattern! ( /^[^(]*\zs(/l1r0
  AddTabularPattern! as / as /l0r0
  AddTabularPattern! = /^[^=]*\zs=/
  AddTabularPattern! :: / :: /l0r0
  AddTabularPattern! : /^[^:]*\zs:/
  AddTabularPattern! > / -> /l0r0
  AddTabularPattern! < / <- /l0r0
endfunction " }}}
