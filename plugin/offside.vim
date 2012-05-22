function! s:InnerOffside() " {{{
  let l:line = line('.')
  let l:indent = indent(l:line)
  for l:start in range(l:line, 0, -1)
    if indent(l:start) <# l:indent
      break
    endif
  endfor
  for l:end in range(l:line, line('$') + 1)
    if indent(l:end) <# l:indent
      break
    endif
  endfor
  execute 'normal! ' . (l:start + 1) . 'GV' . (l:end - 1) . 'G'
endfunction " }}}


vnoremap <Plug>InnerOffside :<c-u>call <SID>InnerOffside()<cr>

if !hasmapto('<Plug>InnerOffside')
  vmap <unique> <silent> io <Plug>InnerOffside
  onoremap <unique> <silent> io :normal vio<cr>
endif
