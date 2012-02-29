syntax include @haskell syntax/haskell.vim

syntax region mkdnHaskell matchgroup=mkdnHaskellBlock
  \ start="^```haskell" end="^```$"
  \ contains=@haskell

highlight! link mkdnHaskellBlock Delimiter
