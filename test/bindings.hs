main =
    putStrLn $ yell str
  where
    str = "hello"

yell :: String -> String
yell s = map toUpper s

makeLens ''Something

isLarge x
  | x > 10    = "yep"
  | otherwise = "nope"
