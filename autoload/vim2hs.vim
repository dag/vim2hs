function! vim2hs#letdefault(var, val) " {{{
  if !exists(a:var)
    execute "let " . a:var . " = " . a:val
  endif
endfunction " }}}


function! vim2hs#with_compiler(name, args) " {{{
  if exists('b:current_compiler')
    let l:previous_compiler = b:current_compiler
  endif
  execute "compiler " . a:name
  execute "make " . a:args
  if exists('l:previous_compiler')
    execute "compiler " . l:previous_compiler
  endif
endfunction " }}}


function! s:GetHPasteAuthor() " {{{
  if exists('g:hpaste_author')
    return g:hpaste_author
  else
    return input('Author: ')
  endif
endfunction " }}}


function! vim2hs#hpaste(line1, line2) " {{{
  let l:code = join(getline(a:line1, a:line2), "\n")
  python hpaste()
endfunction " }}}
