function! vim2hs#heist#tags() " {{{
  syntax region heistBind matchgroup=heistBindTag
    \ start='<bind' end='>'
    \ contains=heistBindAttr

  syntax match heistBindAttr
    \ 'tag='
    \ nextgroup=htmlString contained

  syntax region heistApply matchgroup=heistApplyTag
    \ start='<apply' end='>'
    \ contains=heistApplyAttr

  syntax match heistApplyAttr
    \ 'template='
    \ nextgroup=htmlString contained

  syntax match heistBindTag '</bind>'
  syntax match heistApplyTag '</apply>'
  syntax match heistContentTag '<content\s*/>'

  highlight! link heistBindTag Define
  highlight! link heistBindAttr Identifier
  highlight! link heistApplyTag Include
  highlight! link heistApplyAttr Identifier
  highlight! link heistContentTag Macro
endfunction " }}}


function! vim2hs#heist#substitution() " {{{
  syntax region heistSubstitution
    \ start='${' end='}'
    \ contained containedin=htmlString

  highlight! link heistSubstitution PreProc
endfunction " }}}
