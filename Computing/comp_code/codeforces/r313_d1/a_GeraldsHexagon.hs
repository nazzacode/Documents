module Main (main) where

readNumbers :: String -> [Integer]
readNumbers = map read . words

numberOfTriangles :: [Integer] -> Integer
numberOfTriangles [a,b,c,d,e,f] = ( a + b + c )^2 - a^2 - c^2 - e^2

main :: IO ()
main = do 
        line <- getLine
        print $ numberOfTriangles $ readNumbers line

