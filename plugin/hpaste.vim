if has('python')
  command! -range=% HPaste call vim2hs#hpaste#hpaste(<line1>, <line2>)
endif
