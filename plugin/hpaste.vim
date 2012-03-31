if has('python')
  pyfile <sfile>:p:h/hpaste.py
  command! -range=% HPaste call vim2hs#hpaste(<line1>, <line2>)
endif
