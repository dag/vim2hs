main =
    putStrLn $ yell str
  where
    str = "hello"

yell :: String
     -> String
yell s = map toUpper s

data Something = Something

makeLens ''Something

isLarge :: (Ord a, Num a) => a -> String
isLarge x
  | x > 10    = "yep"
  | otherwise = "nope"
