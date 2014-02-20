def hpaste():
    import vim, sys, urllib, urllib2

    enc = vim.eval('&fileencoding') or vim.eval('&encoding')
    code = vim.eval('l:code').decode(enc, 'ignore').encode('utf-8')

    title = vim.eval('input("Title: ")')
    if not title:
        print 'aborted'
        return

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
        res = urllib2.urlopen('http://lpaste.net/new', data)
        paste = res.geturl()
        print 'Created new paste %s' % paste
        vim.command('call setreg("+", %r)' % paste)
    finally:
        res.close()
