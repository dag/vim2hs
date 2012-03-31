function! vim2hs#letdefault(var, val) " {{{
  if !exists(a:var)
    execute "let " . a:var . " = " . a:val
  endif
endfunction " }}}


function! vim2hs#with_compiler(name, args) " {{{
  if exists('b:current_compiler')
    let l:previous_compiler = b:current_compiler
  endif
  execute "compiler " . a:name
  execute "make " . a:args
  if exists('l:previous_compiler')
    execute "compiler " . l:previous_compiler
  endif
endfunction " }}}


function! s:GetHPasteAuthor() " {{{
  if exists('g:hpaste_author')
    return g:hpaste_author
  else
    return input('Author: ')
  endif
endfunction " }}}


function! vim2hs#hpaste(line1, line2) " {{{
  let l:code = join(getline(a:line1, a:line2), "\n")

python <<endpython
try:
  import vim, sys, urllib, urllib2

  enc = vim.eval('&fileencoding') or vim.eval('&encoding')
  code = vim.eval('l:code').decode(enc, 'ignore').encode('utf-8')

  title = vim.eval('input("Title: ")')
  if not title:
    raise RuntimeError('aborted')

  author = vim.eval('s:GetHPasteAuthor()')
  language = vim.eval('&filetype')
  channel = vim.eval('input("Channel: ")')

  data = urllib.urlencode({
    'title'    : title,
    'author'   : author,
    'language' : language,
    'channel'  : channel,
    'paste'    : code,
    'email'    : ''
  })

  try:
    res = urllib2.urlopen('http://hpaste.org/new', data)
    paste = res.geturl()
    print 'Created new paste %s' % paste
    vim.command('call setreg("+", %r)' % paste)
  finally:
    res.close()

except:
  print 'error:', sys.exc_info()[1]
endpython
endfunction " }}}
