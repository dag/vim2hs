function! vim2hs#haskell#quasi#quote() " {{{

  syntax match hsQuasiQuote /\[\$\?\k\+|\%(\_.\%(|]\)\@!\)*\_.|\]/ contains=hsQuasi
  syntax match hsQuasi /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsQuasiQuote

  highlight default link hsQuasiQuote Delimiter
  highlight default link hsQuasi Macro
endfunction " }}}


function! vim2hs#haskell#quasi#interpolation() " {{{
  syntax match hsStringQQuote /\[\$\?[sq]|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsStringQQ

  syntax match hsStringQQ /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsStringQQuote contains=@Spell

  syntax region hsP6Interpolation matchgroup=hsP6AntiQuote
    \ start="{" end="}"
    \ keepend contained contains=TOP

  syntax match hsP6Identifier
    \ "\$\k\+"
    \ contained

  syntax match hsP6QQuote /\[\$\?qc|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsP6QQ

  syntax match hsP6QQ /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsP6QQuote contains=hsP6Interpolation,@Spell

  syntax match hsP6QQuote /\[\$\?qq|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsP6QQ

  syntax match hsP6QQ /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsP6QQuote contains=hsP6Identifier,hsP6Interpolation,@Spell

  syntax region hsRubyInterpolation matchgroup=hsRubyAntiQuote
    \ start="#{" end="}"
    \ keepend contained contains=TOP

  syntax match hsRubyQQuote /\[\$\?istr|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsRubyQQ

  syntax match hsRubyQQ /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsRubyQQuote contains=hsRubyInterpolation,@Spell

  highlight default link hsStringQQuote Delimiter
  highlight default link hsStringQQ String
  highlight default link hsP6QQuote Delimiter
  highlight default link hsP6QQ String
  highlight default link hsP6AntiQuote PreProc
  highlight default link hsP6Identifier Identifier
  highlight default link hsRubyQQuote Delimiter
  highlight default link hsRubyQQ String
  highlight default link hsRubyAntiQuote PreProc
endfunction " }}}

function! vim2hs#haskell#quasi#rlangqq() " {{{
  syntax include @r syntax/r.vim
  unlet b:current_syntax

  syntax match hsRlangQQuote /\[\$\?r\(Chan\)\?|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsRlangQQ

  syntax match hsRlangQQ /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsRlangQQuote contains=hsRlangIdentifier,hsRlangInterpolation,@r

  syntax region hsRlangInterpolation matchgroup=hsRlangQQAntiQuote
    \ start="$(" end=")"
    \ keepend contained contains=TOP

  syntax match hsRlangIdentifier
    \ "\(hs\|ch\)_\w*"
    \ contained

  highlight default link hsRlangIdentifier Identifier
  highlight default link hsRlangQQuote Delimiter
  highlight default link hsRlangQQ String
  highlight default link hsRlangAntiQuote PreProc
endfunction " }}}

function! vim2hs#haskell#quasi#regex() " {{{
  syntax match regexSpecialChar
    \ /\\[a-zA-Z]/
    \ contained

  syntax match regexOperator
    \ "[\(]\@<![.*+?]"
    \ contained

  syntax match regexDelimiter
    \ "(\|)\|\[\|\]\|{\|}"
    \ contained

  syntax match regexStructure
    \ "(\@<=?.\|[$^]"
    \ contained

  syntax cluster regex
    \ contains=regexSpecialChar,regexOperator,
              \regexDelimiter,regexStructure

  syntax region hsRexMap matchgroup=hsRexMapQuote
    \ start="(\@<=?{" end="}\%(.*)\)\@="
    \ keepend contained contains=TOP

  syntax match hsRexQuote /\[\$\?b\?rex|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsRex

  syntax match hsRexQQ /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsRexQuote contains=@regex,hsRexMap

  syntax match hsRelitQuote /\[\$\?b\?re|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsRelit

  syntax match hsRelit /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsRelitQuote contains=@regex

  syntax match hsRegexQQuote /\[\$\?b\?rx|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsRegexQQ

  syntax match hsRegexQQ /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsRegexQQuote contains=@regex

  highlight default link regexSpecialChar SpecialChar
  highlight default link regexOperator Operator
  highlight default link regexDelimiter Delimiter
  highlight default link regexStructure Structure

  highlight default link hsRexQuote Delimiter
  highlight default link hsRex String
  highlight default link hsRexMapQuote PreProc

  highlight default link hsRelitQuote Delimiter
  highlight default link hsRelit String

  highlight default link hsRegexQQuote Delimiter
  highlight default link hsRegexQQ String
endfunction " }}}


function! vim2hs#haskell#quasi#jmacro() " {{{
  syntax include @jmacro syntax/jmacro.vim
  unlet b:current_syntax

  syntax region hsJmacroSplice matchgroup=hsJmacroAntiQuote
    \ start="`(" end=")`"
    \ keepend contained contains=TOP

  syntax match hsJmacroQuote /\[\$\?jmacroE\?|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsJmacro

  syntax match hsJmacro /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsJmacroQuote contains=hsJmacroSplice,@jmacro

  highlight default link hsJmacroQuote Delimiter
  highlight default link hsJmacroAntiQuote PreProc
endfunction " }}}


function! vim2hs#haskell#quasi#shqq() " {{{
  syntax include @shell syntax/sh.vim
  unlet b:current_syntax

  syntax match hsShQQInterpolation
    \ "\$+\?\%({\k\+}\|\k\+\)"
    \ contained

  syntax match hsShQQuote /\[\$\?shc\?|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsShQQ

  syntax match hsShQQ /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsShQQuote contains=hsShQQInterpolation,@shell

  highlight default link hsShQQuote Delimiter
  highlight default link hsShQQInterpolation Identifier
endfunction " }}}


function! vim2hs#haskell#quasi#sql() " {{{
  syntax include @sql syntax/sql.vim
  unlet b:current_syntax

  syntax region hsSQLSplice matchgroup=hsSQLSpliceQuote
    \ start="\$[si]\?(" end=")"
    \ contained contains=TOP

  syntax match hsSQLQuote /\[\$\?\%(sql\|sqlStmts\?\|pgsqlStmts\?\|sqlExpr\)|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsSQL

  syntax match hsSQL /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsSQLQuote contains=hsSQLSplice,@sql

  highlight default link hsSQLQuote Delimiter
  highlight default link hsSQLSpliceQuote Preproc
endfunction " }}}


function! vim2hs#haskell#quasi#json() " {{{
  try
    syntax include @json syntax/json.vim
  catch /^Vim\%((\a\+)\)\=:E484/
    syntax include @json syntax/javascript.vim
  endtry
  unlet b:current_syntax

  syntax match hsJSONQuote /\[\$\?json|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsJSON

  syntax match hsJSON /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsJSONQuote contains=@json

  syntax match hsJSONQQKey
    \ '\$\k\+'
    \ contained

  syntax region hsJSONQQSplice matchgroup=hsJSONQQSpliceQuote
    \ start='<<' end='>>'
    \ contained contains=TOP

  syntax region hsJSONQQSplice matchgroup=hsJSONQQSpliceQuote
    \ start='<|' end='|>'
    \ contained contains=TOP

  syntax match hsJSONQuote /\[\$\?\%(jsonQQ\|aesonQQ\)|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsJSON

  syntax match hsJSON /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsJSONQuote contains=hsJSONQQKey,hsJSONQQSplice,@json

  highlight default link hsJSONQuote Delimiter
  highlight default link hsJSONQQSpliceQuote PreProc
  highlight default link hsJSONQQKey Identifier
endfunction " }}}


function! vim2hs#haskell#quasi#xml() " {{{
  syntax include @xml syntax/xml.vim
  unlet b:current_syntax

  syntax match hsXMLQuote /\[\$\?xml|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsXML

  syntax match hsXML /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsXMLQuote contains=@xml

  syntax region hsXMLQQElement matchgroup=hsXMLQQElementQuote
    \ start='<<' end='>>'
    \ contained contains=TOP

  syntax region hsXMLQQSplice matchgroup=hsXMLQQSpliceQuote
    \ start='{' end='}'
    \ contained contains=TOP containedin=xmlTag,xmlEndTag

  syntax match hsXMLQuote /\[\$\?xmlQQ|\%(\_.\%(|]\)\@!\)*\_.|\]/
    \ contains=hsXML

  syntax match hsXML /|\%(\_.\%(|]\)\@!\)*\_.|/hs=s+1,he=e-1
    \ contained containedin=hsXMLQuote contains=hsXMLQQElement,hsXMLQQSplice,@xml

  highlight default link hsXMLQuote Delimiter
  highlight default link hsXMLQQElementQuote PreProc
  highlight default link hsXMLQQSpliceQuote PreProc
endfunction " }}}
