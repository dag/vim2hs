if has('python')
  command! -range=% HPaste call vim2hs#hpaste(<line1>, <line2>, <count>)
endif
