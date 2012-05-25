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

  highlight! link heistBindTag Define
  highlight! link heistBindAttr Identifier
  highlight! link heistApplyTag Include
  highlight! link heistApplyAttr Identifier
  highlight! link heistIgnore Comment
  highlight! link heistContentTag Macro
endfunction " }}}


function! vim2hs#heist#substitution() " {{{
  syntax region heistSubstitution
    \ start='${' end='}'
    \ contained containedin=htmlString

  highlight! link heistSubstitution PreProc
endfunction " }}}
