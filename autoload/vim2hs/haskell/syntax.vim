function! vim2hs#haskell#syntax#operators() " {{{
  syntax match hsOperator
    \ '[([:blank:]]\@<=\%([[:upper:]]\k*\.\)*[-!#$%&\*\+/=\?@\\^|~.<>][-!#$%&\*\+/=\?@\\^|~:.<>]*\ze\_[[:blank:])]'
    \ display

  syntax match hsOperator
    \ "`\k\%(\k\|\.\)*`"
    \ display

  highlight default link hsOperator Operator
endfunction " }}}


function! vim2hs#haskell#syntax#delimiters() " {{{
  syntax match hsDelimiter
    \ '(\|)\|\[\|\]\|,\|;\|{\|}\|\k\@<!_\k\@!\|[[:punct:]]\@<!@[[:punct:]]\@!'
    \ display
  syntax match hsDelimiter
    \ '[-!#$%&\*\+/=\?@\\^|~.<>]\@<!|[-!#$%&\*\+/=\?@\\^|~.<>]\@!'
    \ display

  highlight default link hsDelimiter Delimiter
endfunction " }}}


function! vim2hs#haskell#syntax#keywords(conceal_wide, conceal_enumerations, conceal_bad) " {{{
  syntax case match

  syntax keyword hsStructure
    \ module where deriving

  syntax keyword hsExprKeyword
    \ let in do proc

  highlight default link hsExprKeyword hsStructure

  if a:conceal_enumerations
    syntax match hsDeriving
      \ '\%(deriving\s*(\)\@<=.*,.*)\@='
      \ conceal cchar=…
  endif

  syntax match hsTypedef
    \ '\<\%(type\|newtype\|data\|class\|instance\|pattern\)\>'
    \ display

  syntax keyword hsStatement
    \ infix infixl infixr

  syntax keyword hsConditional
    \ if then else case of

  syntax keyword hsKeyword
    \ safe default family

  syntax match hsImport
    \ "\<import\>.*"he=s+6
    \ contains=hsImportKeyword,hsComment,hsBlockComment

  syntax match hsImportKeyword
    \ contained "\<\(as\|qualified\|hiding\)\>"

  highlight default link hsImport hsStatement
  highlight default link hsImportKeyword hsKeyword

  syntax match hsStructure
    \ "[[:punct:]]\@<!\%(=\)[[:punct:]]\@!"
    \ display

  if !a:conceal_wide
    syntax match hsStructure
      \ "[[:punct:]]\@<!\%(->\|→\|<-\|←\|::\|∷\)[[:punct:]]\@!"
      \ display
  endif

  if !a:conceal_bad
    syntax match hsStructure
      \ "[[:punct:]]\@<!\%(=>\|⇒\|-<<\?\)[[:punct:]]\@!"
      \ display
  endif

  highlight default link hsStructure Structure
  highlight default link hsTypedef Typedef
  highlight default link hsStatement Statement
  highlight default link hsConditional Conditional
  highlight default link hsKeyword Keyword
endfunction " }}}


function! vim2hs#haskell#syntax#numbers() " {{{
  syntax match hsNumber
    \ "\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>"
    \ display

  syntax match hsFloat
    \ "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"
    \ display

  highlight default link hsNumber Number
  highlight default link hsFloat Float
endfunction " }}}


function! vim2hs#haskell#syntax#types() " {{{
  syntax match hsType
    \ "^\(\s*\)\%(default\s\+\)\?\%(\k\+\|([^[:alnum:]]\+)\)\_s*\(::\|∷\).*\%(\n\1\s.*\)*"
    \ contains=TOP,@Spell

  highlight default link hsType Type
endfunction " }}}


function! vim2hs#haskell#syntax#bindings() " {{{
  syntax match hsIdentifier
    \ "^\k\+\ze.*\%(\n\s.*\|\n\)*[[:punct:]]\@<!=[[:punct:]]\@!"

  syntax match hsIdentifierNested
    \ "^\s\+\k\+\ze.*\%(\n\s\+|.*\|\n\s*\)*\([[:punct:]]\+\|{[^}]*\)\@<!=[[:punct:]]\@!"

  highlight default link hsIdentifier Identifier
  highlight default link hsIdentifierNested Identifier
endfunction " }}}


function! vim2hs#haskell#syntax#folds() " {{{
  syntax region hsFold
    \ start="^\%(type\|newtype\|class\|instance\|data\)\@!
            \\k\+.*\%(\n\s.*\|\n\)*[[:punct:]]\@<!=[[:punct:]]\@!"
    \ skip='\n#\|\n--'
    \ end='\ze\%(\s*\n\)\+\S'
    \ transparent fold

  syntax region hsFold
    \ start='^\%(type\|newtype\|class\|instance\|data\)\>'
    \ end='\ze\%(\s*\n\)\+\S'
    \ transparent fold
endfunction " }}}


function! vim2hs#haskell#syntax#strings(multiline_strings) " {{{
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

  if a:multiline_strings
    syntax match hsString
      \ /\v"(\\\_s*\\|\\[^\\]|[^\\"])*"/
      \ contains=hsSpecialChar,@Spell

  else
    syntax region hsString
      \ start=+"+ skip=+\\\\\|\\"+ end=+"+
      \ oneline contains=hsSpecialChar,@Spell

  endif

  highlight default link hsSpecialChar SpecialChar
  highlight default link hsLineContinuation SpecialChar
  highlight default link hsSpecialCharError Error
  highlight default link hsCharacter Character
  highlight default link hsStringError Error
  highlight default link hsString String
endfunction " }}}


function! vim2hs#haskell#syntax#comments(conceal_comments, conceal_enumerations) " {{{
  syntax case match

  syntax keyword hsTodo
    \ TODO FIXME XXX
    \ contained

  if a:conceal_comments
    syntax match hsComment
      \ '---*\%([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$'
      \ contains=hsTodo,@Spell
      \ conceal cchar=ℹ

    syntax match hsComment
      \ '^\s*---*\%([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$'
      \ contains=hsTodo,@Spell
  else
    syntax match hsComment
      \ '---*\%([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$'
      \ contains=hsTodo,@Spell
  endif

  syntax region hsBlockComment
    \ start="{-" end="-}"
    \ contains=hsBlockComment,hsTodo,@Spell

  if a:conceal_enumerations
    syntax match hsLANGUAGEPragma
      \ 'LANGUAGE\s\+\zs.*,.*\ze\s\+#-}'
      \ contained conceal cchar=…

    syntax region hsPragma
      \ start="{-#" end="#-}"
      \ contains=hsLANGUAGEPragma
  else
    syntax region hsPragma
      \ start="{-#" end="#-}"
  endif

  highlight default link hsTodo Todo
  highlight default link hsComment Comment
  highlight default link hsBlockComment Comment
  highlight default link hsLANGUAGEPragma PreProc
  highlight default link hsPragma PreProc
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

  highlight default link haddockHeading Title
  highlight default link haddockChunk PreProc
  highlight default link haddockAnnotation Title
  highlight default link haddockIdentifier Underlined
  highlight default link haddockModule Underlined
  highlight default link haddockEmphasis Todo
  highlight default link haddockURL Underlined
  highlight default link haddockREPL Delimiter
  highlight default link haddockLabel Label
  highlight default link haddockAnchor Underlined
endfunction " }}}


function! vim2hs#haskell#syntax#ffi() " {{{
  syntax case match
  syntax keyword hsFFI foreign export stdcall ccall unsafe
  highlight default link hsFFI Keyword
endfunction " }}}


function! vim2hs#haskell#syntax#cpp() " {{{
  syntax match cppPreCondit "^#\s*\%(else\|endif\)$"

  syntax region cppPreCondit
    \ start="^#\s*\%(if\|ifdef\|ifndef\|elif\)\>"
    \ skip="\\$"
    \ end="$"

  syntax region cppDefine
    \ start='^#\s*\%(define\)\>'
    \ end='$'

  syntax region cppInclude
    \ start='^#\s*\%(include\)\>\s*\%("\f\+"\|<\f\+>\)$'
    \ end='$'

  highlight default link cppPreCondit PreCondit
  highlight default link cppDefine Define
  highlight default link cppInclude Include
endfunction "}}}


function! vim2hs#haskell#syntax#th() " {{{
  syntax region hsTHContent matchgroup=hsTHSplice
    \ start="\$(" end=")"
    \ contains=TOP

  syntax region hsTHContent matchgroup=hsTHQuote
    \ start="\[\$\?[edtp]\?|" end="|\]"
    \ contains=TOP

  highlight default link hsTHSplice Macro
  highlight default link hsTHQuote Delimiter
endfunction " }}}


function! vim2hs#haskell#syntax#hsp() " {{{
  syntax match hspContain
    \ "<%>\|</%>"
    \ display

  syntax match hspTag
    \ "<\w\+/>\|</\w\+>"
    \ display

  syntax match hspAttrValue
    \ ""
    \ display contained contains=TOP

  syntax match hspAttrName
    \ "\w\+="
    \ display contained

  syntax region hspText matchgroup=hspTag
    \ start="<\z(\w\+\)>" end="</\z1>"
    \ contains=hspHaskell,hspTag,hspText,hspAttr

  syntax region hspAttr matchgroup=hspTag
    \ start="<\w\+\_s" end="/\?>"
    \ contains=hspAttrName,hspAttrValue

  syntax region hspHaskell matchgroup=hspSplice
    \ start="<%>\@!" end="\%(</\)\@!%>"
    \ contains=TOP

  syntax region hspQQContent matchgroup=hspQQuote
    \ start="\[\$\?hsx|" end="|\]"
    \ contains=TOP

  highlight default link hspContain Delimiter
  highlight default link hspTag PreProc
  highlight default link hspAttrName Constant
  highlight default link hspSplice Macro
  highlight default link hspQQuote Delimiter
  highlight default link hspQQContent String
  highlight default link hspText String
endfunction " }}}
