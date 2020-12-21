-- Informatics 1 - Introduction to Computation
-- Functional Programming Tutorial 4
--
-- Week 5(15-19 Oct.)

module Tutorial4 where

import Data.Char
import Test.QuickCheck

-- 1. Map

-- a.
doubles :: [Int] -> [Int]
doubles = undefined

-- b.
penceToPounds :: [Int] -> [Float]
penceToPounds = undefined

-- c.
uppersComp :: String -> String
uppersComp = undefined


-- 2. Filter
-- a.
alphas :: String -> String
alphas = undefined

-- b.
above :: Int -> [Int] -> [Int]
above = undefined

-- c.
unequals :: [(Int,Int)] -> [(Int,Int)]
unequals = undefined

-- d.
rmCharComp :: Char -> String -> String
rmCharComp ch str = [c | c <- str, c /= ch]


-- 3. Comprehensions vs. map & filter
-- a.
largeDoubles :: [Int] -> [Int]
largeDoubles xs = [2 * x | x <- xs, x > 3]

largeDoubles' :: [Int] -> [Int]
largeDoubles' = undefined

prop_largeDoubles :: [Int] -> Bool
prop_largeDoubles xs = largeDoubles xs == largeDoubles' xs

-- b.
reverseEven :: [String] -> [String]
reverseEven strs = [reverse s | s <- strs, even (length s)]

reverseEven' :: [String] -> [String]
reverseEven' = undefined

prop_reverseEven :: [String] -> Bool
prop_reverseEven strs = reverseEven strs == reverseEven' strs



-- 4. Foldr
-- a.
productRec :: [Int] -> Int
productRec []     = 1
productRec (x:xs) = x * productRec xs

productFold :: [Int] -> Int
productFold = foldr1 (*)

prop_product :: [Int] -> Bool
prop_product xs = productRec xs == productFold xs

-- b.
concatRec :: [[a]] -> [a]
concatRec = undefined

concatFold :: [[a]] -> [a]
concatFold = undefined

prop_concat :: [String] -> Bool
prop_concat strs = concatRec strs == concatFold strs

-- c.
rmCharsRec :: String -> String -> String
rmCharsRec [] _  = []
rmCharsRec (x:xs) str  = rmCharsRec xs (rmCharComp x str)

rmCharsFold :: String -> String -> String
rmCharsFold substr str = foldr rmCharComp str substr

--dont really understand order of str substr

prop_rmChars :: String -> String -> Bool
prop_rmChars chars str = rmCharsRec chars str == rmCharsFold chars str


type Matrix = [[Rational]]

-- 5
-- a.
uniform :: [Int] -> Bool
uniform = undefined

-- b.
valid :: Matrix -> Bool
valid = undefined


-- 6.
plusM :: Matrix -> Matrix -> Matrix
plusM = undefined

-- 7.
timesM :: Matrix -> Matrix -> Matrix
timesM = undefined

-------------------------------------
-------------------------------------
-- Tutorial Activities
-------------------------------------
-------------------------------------

-- 9.
-- a.
uppers :: String -> String
uppers = undefined

prop_uppers :: String -> Bool
prop_uppers = undefined

-- b.
rmChar ::  Char -> String -> String
rmChar = undefined

prop_rmChar :: Char -> String -> Bool
prop_rmChar = undefined

-- c.
upperChars :: String -> String
upperChars s = [toUpper c | c <- s, isAlpha c]

upperChars' :: String -> String
upperChars' = undefined

prop_upperChars :: String -> Bool
prop_upperChars s = upperChars s == upperChars' s

-- d.
andRec :: [Bool] -> Bool
andRec = undefined

andFold :: [Bool] -> Bool
andFold = undefined

prop_and :: [Bool] -> Bool
prop_and xs = andRec xs == andFold xs

-- 11.
-- b.
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f xs ys = undefined

-- c.
zipWith'' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith'' f xs ys = undefined

-------------------------------------
-------------------------------------
-- Optional material
-------------------------------------
-------------------------------------
-- 13.

-- Mapping functions
mapMatrix :: (a -> b) -> [[a]] -> [[b]]
mapMatrix f = undefined

zipMatrix :: (a -> b -> c) -> [[a]] -> [[b]] -> [[c]]
zipMatrix f = undefined

-- All ways of deleting a single element from a list
removes :: [a] -> [[a]]
removes = undefined

-- Produce a matrix of minors from a given matrix
minors :: Matrix -> [[Matrix]]
minors m = undefined

-- A matrix where element a_ij = (-1)^(i + j)
signMatrix :: Int -> Int -> Matrix
signMatrix w h = undefined

determinant :: Matrix -> Rational
determinant = undefined

cofactors :: Matrix -> Matrix
cofactors m = undefined

scaleMatrix :: Rational -> Matrix -> Matrix
scaleMatrix k = undefined

inverse :: Matrix -> Matrix
inverse m = undefined
