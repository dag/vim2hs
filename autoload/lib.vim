function! lib#letdefault(var, val) " {{{
  if !exists(a:var)
    execute "let " . a:var . " = " . a:val
  endif
endfunction " }}}
