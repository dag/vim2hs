function! lib#letdefault(var, val) " {{{
  if !exists(a:var)
    exec "let " . a:var . " = " . a:val
  endif
endfunction " }}}
