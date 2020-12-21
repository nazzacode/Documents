-- Informatics 1 - Introduction to Computation
-- Functional Programming Tutorial 1
--
-- Week 1(24-28 Sep.)

import Data.Char
import Data.List
import Test.QuickCheck
import Control.Monad (guard)


-- 1. halveEvens

-- List-comprehension version
halveEvens :: [Int] -> [Int]
halveEvens xs = undefined


-- This is for testing only. Do not try to understand this (yet).
halveEvensReference :: [Int] -> [Int]
halveEvensReference = (>>= \x -> guard (x `mod` 2 == 0) >>= \_ -> return $ x `div` 2)


-- -- Mutual test
prop_halveEvens :: [Int] -> Bool
prop_halveEvens xs = undefined


-- 2. inRange

-- List-comprehension version
inRange :: Int -> Int -> [Int] -> [Int]
inRange lo hi xs = undefined


-- 3. countPositives: sum up all the positive numbers in a list

-- List-comprehension version
countPositives :: [Int] -> Int
countPositives list = undefined


-- 4. multDigits

-- List-comprehension version
multDigits :: String -> Int
multDigits str = undefined

countDigits :: String -> Int
countDigits str = undefined

prop_multDigits :: String -> Bool
prop_multDigits xs = undefined


-- 5. capitalise

-- List-comprehension version
capitalise :: String -> String
capitalise s = undefined


-- 6. title

lowercase :: String -> String
lowercase xs = undefined

-- List-comprehension version
title :: [String] -> [String]
title _ = undefined


-- 7. signs


sign x | 0 < x && x <= 9     = '+'
       | 0 == x              = '0'
       | 0 > x && x >= (-9)  = '-'
       | otherwise           = error ("dat issa shambeles")

signs :: [Int] -> String
signs xs = [sign x | x <- xs, (-9) <= x, x <= 9 ] -- cant wite as: (-9) <= x <= 9


-- 8. score

score :: Char -> Int
score x  = undefined

totalScore :: String -> Int
totalScore xs = undefined

prop_totalScore_pos :: String -> Bool
prop_totalScore_pos xs = undefined

-- Tutorial Activity
-- 10. pennypincher

-- List-comprehension version.
discount :: Int -> Int
discount x = round (9/10 *  fromIntegral x)


pennypincher :: [Int] -> Int
pennypincher prices = sum [discount price | price <- prices, discount price <= 19900]

-- -- And the test itself
prop_pennypincher :: [Int] -> Bool
prop_pennypincher xs = pennypincher xs < sum [ x | x <- xs]

-- Optional Material

-- 11. crosswordFind

-- List-comprehension version
crosswordFind :: Char -> Int -> Int -> [String] -> [String]
crosswordFind letter pos len words = [ word | word <- words,
                                              length [word] == len,
                                              word!!pos == letter]
--could also paramatise that 0 <= pos < len



-- 12. search

-- List-comprehension version


search :: String -> Char -> [Int]
search str goal = [ i | (a, i) <- zip str [0..], a == goal]


-- Depending on the property you want to test, you might want to change the type signature
prop_search :: String -> Char -> Bool
prop_search str goal = undefined


-- 13. contains

suffixes :: String -> [String]
suffixes str = [ drop i str | i <- [0..length str]]

contains :: String -> String -> Bool
contains str substr = [] /= [ True | s <- suffixes str, substr `isPrefixOf` s ]


-- Depending on the property you want to test, you might want to change the type signature
prop_contains :: String -> String -> Bool
prop_contains str1 str2 = undefined
