`vim2hs :: Vim -> Haskell`
==========================

*"Vim to Haskell": A collection of vimscripts for Haskell development.*

Features
--------

* Written from scratch for clean and organized code, though some parts are
  borrowed from existing vimscripts.
* Highlights Haskell code in GitHub Flavored Markdown, and Literate Haskell
  documents as Markdown.
* Improved syntax highlighting including Haddock markup in comments,
  support for HSP and many quasi-quotes such as jmacro, shqq, regex, sql,
  string interpolation...
* Liberal syntax highlighting for Cabal package descriptions, yielding less
  false-positives for mistakes than other syntax files for Cabal.
* Makes Vim aware of Haskell modules and imports allowing you to `gf` with
  the cursor on a module to "go" to its source "file", etc.
* Support for using HLint both as a compiler and a command, integrated into
  the quickfix system in Vim.
* Unicode conceals for various operators and syntax, such as lambda and
  function composition.
* Integrates with third-party plugins, but doesn't require them:
  snippets for UltiSnips and patterns for Tabular.
* Posts buffers and line-ranges to [hpaste.org](http://hpaste.org).
* Highly configurable, most of the above can be disabled if it gets in the
  way.

Installation
------------

You need at least Vim 7.3, and for the HPaste command Python 2, not too
ancient.  Beyond that, just clone this repo and add it to your
`'runtimepath'`.  [Vundle](https://github.com/gmarik/vundle) is great for
automating that, [Pathogen](https://github.com/tpope/vim-pathogen) is also
popular.

See Also
--------

Here are some other Vimscripts that complement vim2hs nicely:

* Omni completion: [neco-ghc](https://github.com/ujihisa/neco-ghc)
* Syntax checking and linting: [syntastic](https://github.com/scrooloose/syntastic)
* Type inspection: [haskellmode](https://github.com/lukerandall/haskellmode-vim) or [ghcmod](https://github.com/eagletmt/ghcmod-vim)
* Shakespeare templates highlighting: [html-template-syntax](https://github.com/pbrisbin/html-template-syntax)

Overview
--------

### Quasi Quoting

Haskell supports embedding arbitrary syntax that is processed at
compile-time.  Vim supports embedding external syntax highlighting.

![Quasi Quotes screenshot](https://github.com/dag/vim2hs/raw/master/screenshots/quasi.png)

These are all enabled by default but you can selectively opt out by adding
the relevant configuration overrides to your `~/.vimrc`:

```vim
let g:haskell_quasi         = 0
let g:haskell_interpolation = 0
let g:haskell_regex         = 0
let g:haskell_jmacro        = 0
let g:haskell_shqq          = 0
let g:haskell_sql           = 0
let g:haskell_json          = 0
let g:haskell_xml           = 0
```

### HSP

[Haskell Server Pages](http://hackage.haskell.org/package/hsp) and
[Haskell Source with XML](http://hackage.haskell.org/package/hsx)
pre-processes literal XML in Haskell source code into function application
and vim2hs provides limited support for this syntax - I have yet to figure
out how to highlight the body of XML elements differently while still
highlighting the attributes as Haskell.

![HSP screenshot](https://github.com/dag/vim2hs/raw/master/screenshots/hsp.png)

This is enabled by default and can be disabled thusly:

```vim
let g:haskell_hsp = 0
```

### Haddock

Haddock generates API documentation from markup in the comments of Haskell
source files; vim2hs supports highlighting this markup distinctly.

![Haddock screenshot](https://github.com/dag/vim2hs/raw/master/screenshots/haddock.png)

This is currently disabled by default because it needs work. To enable it
try this:

```vim
let g:haskell_haddock = 1
```

### Markdown

It is common to mark up the Literate in Literate Haskell using Markdown,
and vim2hs substitutes the TeX-centric lhaskell filetype with a
Markdown-centric one.  TeX might be supported in the future.

GitHub's custom-flavored Markdown supports pygmented code blocks; vim2hs
extends your existing markdown filetype to highlight haskell in such
blocks.

![Markdown screenshot](https://github.com/dag/vim2hs/raw/master/screenshots/markdown.png)

There aren't yet any configuration options for these features.

### Strings

Haskell actually supports multi-line strings by escaping the newline, but I
don't think it's a widely used feature and I think quasi quoting is better
for such purposes.  Thus I have opted to keep string literals from crossing
lines so half your source file doesn't highlight as a string while you're
entering one, and instead, string literals without a matching end quote
highlight as errors.

The bottom half of this screenshot is just for filling the empty space and
tests that keywords are case sensitive - something many Vim syntax files
gets wrong.

![Strings and Keywords screenshot](https://github.com/dag/vim2hs/raw/master/screenshots/strings-and-keywords.png)

There are currently no configuration options for this, but I might add one
in the future if anyone is actually using the escaped newline syntax.

### HLint

HLint is provided as a compiler for Vim.

```vim
:compiler hlint
:make
```

As a convenience there's also a command that does the above and then resets
the compiler to its previous value.

```vim
:HLint
```

Either way any HLint suggestions and warnings will be put in Vim's quickfix
list and you can jump between them with `:cn` and `:cp`, although I
recommend setting up
[FuzzyFinder](https://github.com/vim-scripts/FuzzyFinder) and using its
`:FufQuickfix` command instead.

### HPaste

To pastebin the contents of the current buffer do this:

```vim
:HPaste
```

The newly created paste URL will be put in the `+` register, meaning your
normal desktop clipboard.

Alternatively, you can select a range of lines with Vim's VISUAL modes and
type the same as above, which should result in this:

```vim
:'<,'>HPaste
```

Which of course will paste the selected lines only.

If you get tired of entering your author name every time you can configure
it globally like so:

```vim
let g:hpaste_author = 'donri'
```

### UltiSnips

If you're using the excellent
[UltiSnips](https://github.com/sirver/ultisnips) Vimscript, vim2hs provides
some useful snippets for Haskell programming.  You can list all active
snippets by hitting `Ctrl+Tab` in INPUT mode.

### Tabular

Another useful Vimscript is
[Tabular](https://github.com/godlygeek/tabular).  If it's installed, vim2hs
adds some named patterns useful for maintaining layout in Haskell code.
You can list all named patterns by tab-completing after entering the
`:Tabularize` command.  You probably want to configure some mappings or
commands for the ones you find useful.

To disable them, use this configuration:

```vim
let g:haskell_tabular = 0
```
