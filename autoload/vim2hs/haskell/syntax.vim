function! vim2hs#haskell#syntax#operators() " {{{
  syntax match hsOperator
    \ "[-!#$%&\*\+/=\?@\\^|~.][-!#$%&\*\+/=\?@\\^|~:.]*"

  syntax match hsOperator
    \ "`\k\%(\k\|\.\)*`"

  highlight! link hsOperator Operator
endfunction " }}}


function! vim2hs#haskell#syntax#keywords(kwdops) " {{{
  syntax case match

  syntax keyword hsStructure
    \ module let in where do deriving

  syntax keyword hsTypedef
    \ type newtype data family class instance

  syntax keyword hsStatement
    \ import infix infixl infixr

  syntax keyword hsConditional
    \ if then else case of

  syntax keyword hsKeyword
    \ qualified safe as default

  if a:kwdops
    syntax match hsStructure
      \ "[[:punct:]]\@<!\%(=>\|->\|<-\|=\|::\)[[:punct:]]\@!"
  endif

  syntax match hsDelimiter
    \ "(\|)\|,\|;\|{\|}\||\|\k\@<!_\k\@!"

  highlight! link hsStructure Structure
  highlight! link hsTypedef Typedef
  highlight! link hsStatement Statement
  highlight! link hsConditional Conditional
  highlight! link hsKeyword Keyword
  highlight! link hsDelimiter Delimiter
endfunction " }}}


function! vim2hs#haskell#syntax#numbers() " {{{
  syntax match hsNumber
    \ "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>"

  syntax match hsFloat
    \ "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"

  highlight! link hsNumber Number
  highlight! link hsFloat Float
endfunction " }}}


function! vim2hs#haskell#syntax#bindings() " {{{
  syntax match hsType
    \ "^\(\s*\)\%(\k\+\|([^[:alnum:]]\+)\)\s*::.*\%(\n\1\s.*\)*"
    \ contains=TOP

  syntax match hsIdentifier
    \ "^\k\+\ze.*\%(\n\s.*\|\n\)*[[:punct:]]\@<!=[[:punct:]]\@!"

  highlight! link hsType Type
  highlight! link hsIdentifier Identifier
endfunction " }}}


function! vim2hs#haskell#syntax#folds() " {{{
  syntax region hsFold
    \ start="^\k\+.*\%(\n\s.*\|\n\)*[[:punct:]]\@<!=[[:punct:]]\@!"
    \ skip='\n#\|\n--'
    \ end='\ze\%(\s*\n\)\+\S'
    \ transparent fold
endfunction " }}}


function! vim2hs#haskell#syntax#strings() " {{{
  syntax match hsSpecialChar
    \ contained
    \ "\\\%([0-9]\+\|o[0-7]\+\|
        \x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|
        \^[A-Z^_\[\\\]]\)"

  syntax match hsSpecialChar
    \ contained
    \ "\\\%(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|
        \BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|
        \DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|
        \ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|
        \RS\|US\|SP\|DEL\)"

  syntax match hsSpecialCharError
    \ contained
    \ "\\&\|'''\+"

  syntax match hsCharacter
    \ "[^a-zA-Z0-9_']'\%([^\\]\|\\[^']\+\|\\'\)'"lc=1
    \ contains=hsSpecialChar,hsSpecialCharError

  syntax match hsCharacter
    \ "^'\%([^\\]\|\\[^']\+\|\\'\)'"
    \ contains=hsSpecialChar,hsSpecialCharError

  syntax region hsStringError
    \ start=+"+ skip=+\\\\\|\\"+ end=+"\@!$+
    \ contains=hsSpecialChar,@Spell

  syntax region hsString
    \ start=+"+ skip=+\\\\\|\\"+ end=+"+
    \ oneline contains=hsSpecialChar,@Spell

  highlight! link hsSpecialChar SpecialChar
  highlight! link hsSpecialCharError Error
  highlight! link hsCharacter Character
  highlight! link hsStringError Error
  highlight! link hsString String
endfunction " }}}


function! vim2hs#haskell#syntax#comments() " {{{
  syntax match hsComment
    \ /--.*/

  syntax region hsComment
    \ start="{-" end="-}"
    \ contains=hsComment

  syntax region hsPragma
    \ start="{-#" end="#-}"

  highlight! link hsComment Comment
  highlight! link hsPragma PreProc
endfunction " }}}


function! vim2hs#haskell#syntax#haddock() " {{{
  syntax match haddockHeading
    \ "\*\+.*\%(-}\)\@=\|\*\+.*$"
    \ contained containedin=hsComment

  syntax match haddockChunk
    \ "\$[[:alnum:]]\+"
    \ contained containedin=hsComment

  syntax match haddockAnnotation
    \ "[|^].*\%(-}\)\@=\|[|^].*$"
    \ contained containedin=hsComment

  syntax match haddockIdentifier
    \ "'\%(\k\|\.\)\+'"ms=s+1,me=e-1
    \ contained containedin=hsComment

  syntax match haddockModule
    \ /"[A-Z]\%(\k\|\.\)\+"/ms=s+1,me=e-1
    \ contained containedin=hsComment

  syntax match haddockEmphasis
    \ "\/.\+/"ms=s+1,me=e-1
    \ contained containedin=hsComment

  syntax match haddockURL
    \ "<\S\+>"ms=s+1,me=e-1
    \ contained containedin=hsComment

  syntax region haddockExample matchgroup=haddockREPL
    \ start="\%(<\S\+\)\@<!>\%(>>\)\?" end="$"
    \ contained contains=TOP containedin=hsComment

  syntax match haddockLabel
    \ /#\S\+#/
    \ contained containedin=hsComment

  syntax match haddockAnchor
    \ "[A-Z]\%(\k\|\.\)\+#\S\+"
    \ contained containedin=hsComment

  highlight! link haddockHeading Title
  highlight! link haddockChunk PreProc
  highlight! link haddockAnnotation Title
  highlight! link haddockIdentifier Underlined
  highlight! link haddockModule Underlined
  highlight! link haddockEmphasis Todo
  highlight! link haddockURL Underlined
  highlight! link haddockREPL Delimiter
  highlight! link haddockLabel Label
  highlight! link haddockAnchor Underlined
endfunction " }}}


function! vim2hs#haskell#syntax#ffi() " {{{
  syntax case match
  syntax keyword hsFFI foreign export stdcall ccall unsafe
  highlight! link hsFFI Keyword
endfunction " }}}


function! vim2hs#haskell#syntax#cpp() " {{{
  syntax match cppPreCondit "^#\s*\%(else\|endif\)$"

  syntax region cppPreCondit
    \ start="^#\s*\%(if\|ifdef\|ifndef\|elif\)\>"
    \ skip="\\$"
    \ end="$"

  highlight! link cppPreCondit PreCondit
endfunction "}}}


function! vim2hs#haskell#syntax#th() " {{{
  syntax match hsTHMacro "^\k\+\%(.*=\|.*::\)\@!"

  syntax region hsTHContent matchgroup=hsTHSplice
    \ start="\$(" end=")"
    \ contains=TOP

  syntax region hsTHContent matchgroup=hsTHQuote
    \ start="\[\$\?[edtp]\?|" end="|\]"
    \ contains=TOP

  highlight! link hsTHMacro Macro
  highlight! link hsTHSplice Macro
  highlight! link hsTHQuote Delimiter
endfunction " }}}


function! vim2hs#haskell#syntax#hsp() " {{{
  syntax match hspTag
    \ "<%>\|</%>\|</\w\+>"

  syntax match hspAttrValue
    \ ""
    \ contained contains=TOP

  syntax match hspAttrName
    \ "\w\+="
    \ contained

  syntax region hspAttr matchgroup=hspTag
    \ start="<\w\+" end="/\?>"
    \ contains=hspAttrName,hspAttrValue

  syntax region hspHaskell matchgroup=hspSplice
    \ start="<%>\@!" end="\%(</\)\@!%>"
    \ contains=TOP

  highlight! link hspTag PreProc
  highlight! link hspAttrName Constant
  highlight! link hspSplice Macro
endfunction " }}}
