function! vim2hs#haskell#markdown#literate() " {{{
  syntax include @haskell syntax/haskell.vim
  unlet b:current_syntax

  syntax match hsLiterateDelimiter
    \ "^>"
    \ contained

  syntax region hsLiterate matchgroup=hsLiterateDelimiter
    \ start="^>" end="\%(^[^>]\)\@="
    \ contains=hsLiterateDelimiter,@haskell

  highlight default link hsLiterateDelimiter Delimiter
endfunction " }}}


function! vim2hs#haskell#markdown#gfm() " {{{
  syntax include @haskell syntax/haskell.vim
  unlet b:current_syntax

  syntax region mkdnHaskell matchgroup=mkdnHaskellBlock
    \ start="^```\%(haskell\|hs\)$" end="^```$"
    \ contains=@haskell

  highlight default link mkdnHaskellBlock Delimiter
endfunction " }}}
