function! haskell#includeexpr(fname) " {{{
  return substitute(a:fname, '\.', '/', 'g') . '.hs'
endfunction " }}}


function! haskell#tabular() " {{{
  AddTabularPattern! ( /^[^(]*\zs(/l1r0
  AddTabularPattern! as / as /l0r0
  AddTabularPattern! = /^[^=]*\zs=/
  AddTabularPattern! :: / :: /l0r0
  AddTabularPattern! : /^[^:]*\zs:/
  AddTabularPattern! > / -> /l0r0
  AddTabularPattern! < / <- /l0r0
endfunction " }}}


function! haskell#literate() " {{{
  syntax include @haskell syntax/haskell.vim
  unlet b:current_syntax

  syntax match hsLiterateDelimiter
    \ "^>"
    \ contained

  syntax region hsLiterate matchgroup=hsLiterateDelimiter
    \ start="^>" end="\%(^[^>]\)\@="
    \ contains=hsLiterateDelimiter,@haskell

  highlight! link hsLiterateDelimiter Delimiter
endfunction " }}}


function! haskell#gfm() " {{{
  syntax include @haskell syntax/haskell.vim
  unlet b:current_syntax

  syntax region mkdnHaskell matchgroup=mkdnHaskellBlock
    \ start="^```\%(haskell\|hs\)$" end="^```$"
    \ contains=@haskell

  highlight! link mkdnHaskellBlock Delimiter
endfunction " }}}


function! haskell#keywords(kwdops) " {{{
  setlocal iskeyword=a-z,A-Z,48-57,_,'
  syntax case match

  syntax keyword hsStructure
    \ module import data family class
    \ where instance default deriving

  syntax keyword hsTypedef
    \ type newtype

  syntax keyword hsInfix
    \ infix infixl infixr

  syntax keyword hsStatement
    \ do case of let in

  syntax keyword hsConditional
    \ if then else

  if a:kwdops
    syntax match hsStructure
      \ "[[:punct:]]\@<!\%(=>\|->\|<-\|=\|::\)[[:punct:]]\@!"
  endif

  syntax match hsDelimiter
    \ "(\|)\|,\|;\|_\|{\|}"

  highlight! link hsStructure Structure
  highlight! link hsTypedef Typedef
  highlight! link hsInfix Keyword
  highlight! link hsStatement Statement
  highlight! link hsConditional Conditional
  highlight! link hsDelimiter Delimiter
endfunction " }}}


function! haskell#bindings() " {{{
  syntax match hsType
    \ "^\k\+\s*::.*\%(\n\s.*\)*"
    \ contains=TOP

  syntax match hsIdentifier
    \ "^\k\+\%(.*\%(\n\s.*\)*[[:punct:]]\@<!=[[:punct:]]\@!\)\@="

  highlight! link hsType Type
  highlight! link hsIdentifier Identifier
endfunction " }}}


function! haskell#strings() " {{{
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


function! haskell#comments() " {{{
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


function! haskell#haddock() " {{{
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
    \ start=">\%(>>\)\?" end="$"
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
  highlight! link haddockURL Underlined
  highlight! link haddockREPL Delimiter
  highlight! link haddockLabel Label
  highlight! link haddockAnchor Underlined

  highlight haddockEmphasis term=bold gui=bold
endfunction " }}}


function! haskell#cpp() " {{{
  syntax match cppPreCondit "^#\s*\%(else\|endif\)$"

  syntax region cppPreCondit
    \ start="^#\s*\%(if\|ifdef\|ifndef\|elif\)\>"
    \ skip="\\$"
    \ end="$"

  highlight! link cppPreCondit PreCondit
endfunction "}}}


function! haskell#th() " {{{
  syntax match hsTHMacro "^\k\+\%(.*=\|.*::\)\@!"

  syntax region hsTHContent matchgroup=hsTHSplice
    \ start="\$(" end=")"
    \ contains=TOP

  highlight! link hsTHMacro Macro
  highlight! link hsTHSplice Macro
endfunction " }}}


function! haskell#quasi() " {{{
  syntax region hsQuasi matchgroup=hsQuasiQuote
    \ start="\[\$\?\k\+|" end="|\]"
    \ keepend

  highlight! link hsQuasiQuote Macro
  highlight! link hsQuasi String
endfunction " }}}


function! haskell#jmacro() " {{{
  syntax include @jmacro syntax/jmacro.vim
  unlet b:current_syntax

  syntax region hsJmacroSplice matchgroup=hsJmacroAntiQuote
    \ start="`(" end=")`"
    \ keepend contained contains=TOP

  syntax region hsJmacro matchgroup=hsJmacroQuote
    \ start="\[\$\?jmacroE\?|" end="|\]"
    \ keepend contains=hsJmacroSplice,@jmacro

  highlight! link hsJmacroQuote PreProc
  highlight! link hsJmacroAntiQuote PreProc
endfunction " }}}


function! haskell#shqq() " {{{
  syntax include @shell syntax/sh.vim
  unlet b:current_syntax

  syntax match hsShQQInterpolation
    \ "\$+\?\%({\k\+}\|\k\+\)"
    \ contained

  syntax region hsShQQ matchgroup=hsShQQuote
    \ start="\[\$\?shc\?|" end="|\]"
    \ keepend contains=hsShQQInterpolation,@shell

  highlight! link hsShQQuote PreProc
  highlight! link hsShQQInterpolation Identifier
endfunction " }}}


function! haskell#sql() " {{{
  syntax include @sql syntax/sql.vim
  unlet b:current_syntax

  syntax region hsSQLSplice matchgroup=hsSQLSpliceQuote
    \ start="\$[si]\?(" end=")"
    \ contains=TOP

  syntax region hsSQL matchgroup=hsSQLQuote
    \ start="\[\$\?\%(sql\|sqlStmts\?\|pgsqlStmts\?\|sqlExpr\)|" end="|\]"
    \ keepend contains=hsSQLSplice,@sql

  highlight! link hsSQLQuote Preproc
  highlight! link hsSQLSpliceQuote Preproc
endfunction " }}}


function! haskell#hsp() " {{{
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


function! haskell#conceal(wide, bad) " {{{
  syntax match hsConceal
    \ "\\\ze[[:alpha:][:space:]_([]"
    \ conceal cchar=λ

  syntax match hsConceal
    \ "\s\.\_s"ms=s+1,me=e-1
    \ conceal cchar=∘

  " These can mess up the layout (alignment)
  if a:wide " {{{
    syntax match hsConceal
      \ "\s/=\_s"ms=s+1,me=e-1
      \ conceal cchar=≠

    syntax match hsConceal
      \ "\s::\_s"ms=s+1,me=e-1
      \ conceal cchar=⦂

    syntax match hsConceal
      \ "\s>>\_s"ms=s+1,me=e-1
      \ conceal cchar=»

    syntax match hsConceal
      \ "\s<<\_s"ms=s+1,me=e-1
      \ conceal cchar=«

    syntax match hsConceal
      \ "\<sum\>"
      \ conceal cchar=∑

    syntax match hsConceal
      \ "\<product\>"
      \ conceal cchar=∏

    syntax match hsConceal
      \ "\<sqrt\>"
      \ conceal cchar=√
  endif " }}}

  " These work badly in the fonts I've tested.
  if a:bad " {{{
    syntax match hsConceal
      \ "\<elem\>"
      \ conceal cchar=∈

    syntax match hsConceal
      \ "\<notElem\>"
      \ conceal cchar=∉

    syntax match hsConceal
      \ "()"
      \ conceal cchar=∅

    syntax match hsConceal
      \ "\s->\_s"ms=s+1,me=e-1
      \ conceal cchar=→

    syntax match hsConceal
      \ "\s<-\_s"ms=s+1,me=e-1
      \ conceal cchar=←
  endif " }}}

  setlocal conceallevel=2

  highlight! link hsConceal Operator
  highlight! link Conceal Operator
endfunction " }}}
