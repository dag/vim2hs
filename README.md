`vim2hs ⦂ Vim → Haskell`
========================

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
* Syntax checking and linting:
  [syntastic](https://github.com/scrooloose/syntastic)
* Type inspection:
  [haskellmode](https://github.com/lukerandall/haskellmode-vim) or (better)
  [ghcmod](https://github.com/eagletmt/ghcmod-vim)
* Shakespeare templates highlighting:
  [html-template-syntax](https://github.com/pbrisbin/html-template-syntax)
* Layout as text objects:
  [textobj-indent](https://github.com/kana/vim-textobj-indent) *(vim2hs
  includes a less powerful version of this that I wrote before I discovered
  this Vimscript; it might be removed in favor of this one in the future)*

Overview
--------

### Top-level Definitions

The syntax highlighting of top-level definitions are improved in vim2hs:

![Bindings screenshot](https://github.com/dag/vim2hs/raw/master/screenshots/bindings.png)

This screenshot showcases a number of nice features:

* Type signatures are highlighted as a whole, even if spanning multiple
  lines.
* In function definitions, the name of the function is highlighted
  differently from its arguments, even if the equal sign is on another line
  (most or all other syntax highlighters get this wrong).
* Top-level definitions such as functions, classes and instances and data
  declarations form folds, as you can see in the `foldcolumn` to the left
  of the line numbers.  Closed folds are given a consistent `foldtext`
  producing a nice overview of the code.  Type signatures are intentionally
  not included in the folds, so as to allow you to read the type of folded
  definitions.

In this screenshot, "wide conceals" are enabled, which is what makes the
type colons and function arrows display as unicode.  This option is
disabled by default, since it can mess up the visual alignment between
lines.  To enable it like I have done here, try this:

```vim
let g:haskell_conceal_wide = 1
```

Other options like this that are safer are enabled by default, and can be
disabled should you so desire:

```vim
" disable all conceals, including the simple ones like
" lambda and composition
let g:haskell_conceal              = 0

" disable concealing of "enumerations": commatized lists like
" deriving clauses and LANGUAGE pragmas,
" otherwise collapsed into a single ellipsis
let g:haskell_conceal_enumerations = 0
```

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
let g:haskell_fold          = 0
```

### HSP & Heist

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

[Heist](http://hackage.haskell.org/package/heist) is a simple XML/HTML
templating system; simple enough that you could simply use the `xml` or
`html` filetype in Vim for these templates.  However, it includes a number
of pre-defined "splices" and a special syntax for "splice interpolation" in
attributes.  Included with vim2hs is a syntax file for Heist HTML templates
and automatic filetype detection for `*.tpl` files.

![Heist screenshot](https://github.com/dag/vim2hs/raw/master/screenshots/heist.png)

### Strings

Haskell actually supports multi-line strings by escaping the newline, but I
don't think it's a widely used feature and I think quasi quoting is better
for such purposes.  Thus, by default, I have opted to keep string literals from
crossing lines so half your source file doesn't highlight as a string while
you're entering one. Instead, string literals without a matching end quote
highlight as errors.

![Strings screenshot](https://github.com/dag/vim2hs/raw/master/screenshots/strings.png)

There is a configuration option for this. To enable multi-line strings, use
this:

```vim
:let g:haskell_multiline_strings = 1
```

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

```
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
