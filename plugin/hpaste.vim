if has('python') || has('python3')
  command! -range=% LPaste call vim2hs#hpaste#hpaste(<line1>, <line2>)
  command! -range=% HPaste call vim2hs#hpaste#hpaste(<line1>, <line2>)
endif
