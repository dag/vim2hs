function! vim2hs#letdefault(var, val) " {{{
  if !exists(a:var)
    execute "let " . a:var . " = " . string(a:val)
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


function! vim2hs#pointfree(bang) " {{{
  normal! gv"xy
  let l:output = system('pointfree ' . shellescape(split(@x, "\n")[0]))
  if l:output =~# '(line \d\+, column \d\+):'
    for l:line in split(l:output, '\n')
      echoerr l:line
    endfor
  else
    let l:pointfree = substitute(l:output, '\n', '', 'g')
    if a:bang ==# '!'
      call setreg('y', l:pointfree)
      normal! gv"yp
    else
      echo l:pointfree
    endif
  endif
endfunction " }}}
