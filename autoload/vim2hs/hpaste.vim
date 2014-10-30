if has('python') 
  pyfile <sfile>:p:h/hpaste.py
elseif has('python3') 
  py3file <sfile>:p:h/hpaste.py3
endif

function! s:GetHPasteAuthor() " {{{
  if exists('g:hpaste_author')
    return g:hpaste_author
  else
    return input('Author: ')
  endif
endfunction " }}}


function! vim2hs#hpaste#hpaste(line1, line2) " {{{
  let l:code = join(getline(a:line1, a:line2), "\n")
  if has('python')
    python hpaste()
  elseif has('python3')
    python3 hpaste()
  endif
  
endfunction " }}}

