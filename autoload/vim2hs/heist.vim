function! vim2hs#heist#tags() " {{{
  syntax region heistBind matchgroup=heistBindTag
    \ start='<bind' end='>'
    \ contains=heistBindAttr

  syntax match heistBindAttr
    \ 'tag='
    \ nextgroup=htmlString display contained

  syntax region heistApply matchgroup=heistApplyTag
    \ start='<apply' end='>'
    \ contains=heistApplyAttr

  syntax match heistApplyAttr
    \ 'template='
    \ nextgroup=htmlString display contained

  syntax region heistIgnore
    \ start='<ignore>' end='</ignore>'

  syntax match heistBindTag '</bind>' display
  syntax match heistApplyTag '</apply>' display
  syntax match heistContentTag '<content\s*/>' display

  highlight default link heistBindTag Define
  highlight default link heistBindAttr Identifier
  highlight default link heistApplyTag Include
  highlight default link heistApplyAttr Identifier
  highlight default link heistIgnore Comment
  highlight default link heistContentTag Macro
endfunction " }}}


function! vim2hs#heist#substitution() " {{{
  syntax region heistSubstitution
    \ start='${' end='}'
    \ contained containedin=htmlString

  highlight default link heistSubstitution PreProc
endfunction " }}}
