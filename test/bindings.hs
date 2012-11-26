main =
    putStrLn $ yell str
  where
    str = "hello"

yell :: String
     -> String
yell s = map toUpper s

data Something
    = Something
    | Other

isLarge :: (Ord a, Num a) => a -> String
isLarge x
  | x > 10    = "yep"
  | otherwise = "nope"

instance Functor [] where
    fmap :: (a -> b)
         -> f a -> f b
    fmap = map

($) :: (a -> b) -> a -> b
f $ x =  f x

buildLib
  :: Verbosity -> PackageDescription -> LocalBuildInfo
  -> Library -> ComponentLocalBuildInfo -> IO ()
