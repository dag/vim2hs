`vim2hs :: Vim -> Haskell`
==========================

*"Vim to Haskell": A collection of vimscripts for Haskell development.*

Features
--------

* Written from scratch for clean and organized code, though some parts are
  borrowed from existing vimscripts.
* Highlights Haskell code in GitHub Flavored Markdown, and Literate Haskell
  documents as Markdown.
* Improved syntax highlighting including support for HSP and many
  quasi-quotes such as jmacro, shqq, regex, sql, string interpolation...
* Liberal syntax highlighting for Cabal package descriptions, yielding less
  false-positives for mistakes than other syntax files for Cabal.
* Haskell-module-aware `'includeexpr'`.
* Support for using HLint both as a compiler and a command, integrated into
  the quickfix system in Vim.
* Unicode conceals for various operators and syntax, such as lambda and
  function composition.
* Integrates with third-party plugins, but doesn't require them:
  snippets for UltiSnips and patterns for Tabular.
* Highly configurable, most of the above can be disabled if it gets in the
  way.
