-- Informatics 1 - Introduction to Computation
-- Functional Programming Tutorial 2
--
-- Week 3(01-05 Oct.)
module Tutorial2 where

import Data.Char
import Data.List
import Test.QuickCheck

import Data.Function
import Data.Maybe


-- 1.

halveEvensRec :: [Int] -> [Int]
halveEvensRec [] = []
halveEvensRec (x:xs) | x `mod` 2 == 0 = x `div` 2 : halveEvensRec xs
                     | otherwise = halveEvensRec xs

halveEvens :: [Int] -> [Int]
halveEvens xs = [x `div` 2 | x <- xs, x `mod` 2 == 0]

prop_halveEvens :: [Int] -> Bool
prop_halveEvens xs = halveEvens xs == halveEvensRec xs


-- 2.

inRangeRec :: Int -> Int -> [Int] -> [Int]
inRangeRec lo hi [] = []
inRangeRec lo hi (x:xs) {-no '=' -}  | lo <= x && x <= hi    = x : inRangeRec lo hi xs
                                      | otherwise             = inRangeRec lo hi xs

    --inRange :: Int -> Int -> [Int] -> [Int]
    --inRange lo hi xs = [x | x <- xs, lo <= x, x <= hi]

--prop_inRange :: Int -> Int -> [Int] -> Bool
--prop_inRange lo hi xs = inRange xs == inRangeRec xs


-- 3.

countPositivesRec :: [Int] -> Int
countPositivesRec [] = 0
countPositivesRec (x:xs)   | x > 0       = 1 + countPositivesRec xs
                          | otherwise   = countPositivesRec xs

countPositives :: [Int] -> Int
countPositives list = length [x | x <- list, x > 0]

prop_countPositives :: [Int] -> Bool
prop_countPositives ls = countPositives ls == countPositivesRec ls

-- QuickCheck prop_countPositives  <3

-- 4.

multDigitsRec :: String -> Int
multDigitsRec [] = 0

-- multDigits :: String -> Int
-- multDigits str = product [digitToInt ch | ch <- str, isDigit ch]

prop_multDigits :: String -> Bool
prop_multDigits xs = undefined


-- These are some helper functions for makeKey and makeKey itself.
-- Exercises continue below.

rotate :: Int -> [Char] -> [Char]
rotate k list | 0 <= k && k <= length list = drop k list ++ take k list
              | otherwise = error "Argument to rotate too large or too small"

--  prop_rotate rotates a list of lenght l first an arbitrary number m times,
--  and then rotates it l-m times; together (m + l - m = l) it rotates it all
--  the way round, back to the original list
--
--  to avoid errors with 'rotate', m should be between 0 and l; to get m
--  from a random number k we use k `mod` l (but then l can't be 0,
--  since you can't divide by 0)
prop_rotate :: Int -> String -> Bool
prop_rotate k str = rotate (l - m) (rotate m str) == str
                        where l = length str
                              m = if l == 0 then 0 else k `mod` l

alphabet = ['A'..'Z']

makeKey :: Int -> [(Char, Char)]
makeKey k = zip alphabet (rotate k alphabet)

-- Ceasar Cipher Exercises
-- ===================:====


-- 5.

lookUp :: Char -> [(Char, Char)] -> Char
lookUp ch xs = head ([ y | (x , y) <- xs, ch == x ] ++ [ch])

lookUpRec :: Char -> [(Char, Char)] -> Char
lookUpRec ch []                           = ch
lookUpRec ch ((x,y):xs)   | ch == x      = y
                          | otherwise    = lookUpRec ch xs

prop_lookUp :: Char -> [(Char, Char)] -> Bool
prop_lookUp c k = lookUp c k == lookUpRec c k


-- 6.

encipher :: Int -> Char -> Char
encipher k ch = lookUp ch (makeKey k)


-- 9.

normalise :: String -> String
normalise []      = []
normalise (x:xs)  | isAlpha x   = toUpper x : normalise xs
                  | isDigit x   = x : normalise xs
                  | otherwise   = normalise xs


encipherStr :: Int -> String -> String
encipherStr k str = [ encipher k ch | ch <- normalise str ]


-- 10.

reverseKey :: [(Char, Char)] -> [(Char, Char)]
reverseKey ((x , y):ys) = [ (y , x) | (x , y) <- ys ]
    -- BETTER: reverseKey key = [(y, x) | (x, y) <- key]

reverseKeyRec :: [(Char, Char)] -> [(Char, Char)]
reverseKeyRec [] = []
reverseKeyRec ((x , y):ys) = (y , x) : ys

prop_reverseKey :: [(Char, Char)] -> Bool
prop_reverseKey ((x,y):ys) = reverseKey ((x,y):ys) == reverseKeyRec ((x,y):ys)


-- 11.

decipher :: Int -> Char -> Char
decipher k ch =  lookUp ch (reverseKey ( makeKey k))

decipherStr :: Int -> String -> String
decipherStr k (x:xs) = [lookUp x (reverseKey ( makeKey k)) | x <- xs]

-- Optional Material
-- =================


-- 12.

contains :: String -> String -> Bool
contains _ [] = True
contains [] _ = False
contains str substr = isPrefixOf substr str || contains (tail str) substr



-- 13.

-- returns possible candidate keys by decrypting a string into 26 possible keys and searching for the words 'the' & 'and'.

candidates :: String -> [(Int, String)]
candidates str =  [ (k, decipherStr k str) | k <- [0..25], candidate (decipherStr k str)]
  where candidate str = str `contains` "AND" || str `contains` "THE"


-- 14.

splitEachFive :: String -> [String]
splitEachFive xs  | length xs > 5   = take 5 xs : splitEachFive (drop 5 xs)
                  | otherwise       =  [fillWithXs xs]

fillWithXs :: String -> String
fillWithXs xs = take 5 (xs ++ repeat 'X')

prop_transpose :: String -> Bool
prop_transpose xs = splitEachFive xs == transpose (transpose (splitEachFive xs))


-- 15.
encrypt :: Int -> String -> String
encrypt k str =  concat (transpose (splitEachFive (encipherStr k str)))


-- 16.
reverseTranspose :: String -> String
reverseTranspose str = concat (transpose (chunksOf (length str `div` 5) str))


decrypt :: Int -> String -> String
decrypt str = undefined
