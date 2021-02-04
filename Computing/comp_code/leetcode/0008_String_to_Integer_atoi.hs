{-
Leetocode 0007: Implement `atoi` which converts a string to an integer.

The funcitn first discards as many whitespace character as necessary until the
first non-whitespace character is found. Then, strting from this character
takes an optional initial plus or minus sign followed by as many numerical
didgets as possible, and interprets them as numerical value. 

The string can contain additonal  characters after those that form the integral
number, which are ignored and have no effect on the behavior of this function.

If the first sequence of non-whitespace characters in str is not a valid
integral, or if no sch sequence exists because either str is empty or it 
contains only whitespace  characters, no conversion is performed.

Note
  - the only whiitespace character to be considred is ' ' (space)
  - only deal wiht 32-bit signed integers, if out of range return 2^31-1 or -2^31

Examples
  Input: str = "42"
  Output: 42

  Input: str = "   -42"
  Output: -42

  Input: "4193 with words"
  Output: 4193

  Input "words and 987"
  Output 0
-}

module LeetCode0008Atoi (atoi) where

import Data.Char (isDigit)
import Data.Maybe
import Test.QuickCheck
import Text.Read (readMaybe)

atoi :: String ->Int
atoi xss = case mabyeInt xs of 
  Just xs -> return to32signed xs
  Nothing -> return 0
  where 
    xs takeWhile (\x -> (x=='-') || isDigit x) $ dropWhile (==' ') xs  -- nb: " " not allowed
    maybeInt x = readMaybe x :: Maybe Int

to32signed :: Int->Int
to32signed x
  | x >  2^31 - 1 =  2^31 -1
  | x < -2^31     = -2^31


-- Testing
prop_01 = atoi "   -42" == -42
prop_02 = atoi "4193 with words" = 4193
prop_03 = atoi "words and 987" = 0
prop_4 = atoi 

{-
Complexity Anaylsis:
- O(log(n))
    - roughly log_10 digits 
-}
