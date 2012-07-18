{-# THIS is a pragma #-}

module Main
  ( notReallyHere -- * Heading
  , alsoMissing   -- ** Subheading
  -- $chunk
  ) where

-- this is a normal single-line comment

{- this,
   right here,
   is a normal multi-line comment
   but you should also remember,
   {- that they nest -}
   without ending the outer comment -}

-- | This is a Haddock annotation.

{- | As is this. -}

-- ^ And this.

-- I'll also 'Link.To.something' and a "Module"

-- Google: <http://google.com>

{-
>>> putStrLn "hello"
hello
-}

-- Some /emphasis/...

-- #A-label# can be Module#linked-to

-- the following arrows do not start line comments
myManageHook = composeAll
    [ foo --> bar
    , baz --> bat
    ]
