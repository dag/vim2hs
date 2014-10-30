def hpaste():
    import vim, sys, urllib.request, urllib.parse, urllib.error

    code = vim.eval('l:code')

    title = vim.eval('input("Title: ")')
    if not title:
        print('aborted')
        return

    author = vim.eval('s:GetHPasteAuthor()')
    language = vim.eval('&filetype')
    channel = vim.eval('input("Channel: ")')

    data = urllib.parse.urlencode({
        'title'    : title,
        'author'   : author,
        'language' : language,
        'channel'  : channel,
        'paste'    : code,
        'email'    : ''
    })

    try:
        res = urllib.request.urlopen('http://lpaste.net/new', data.encode())
        paste = res.geturl()
        print(res.info())
        print('Created new paste {!s}'.format(paste))
        vim.command('call setreg("+", {!r})'.format(paste))
    finally:
        res.close()
