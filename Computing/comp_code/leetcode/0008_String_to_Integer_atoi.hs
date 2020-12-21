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

module LeetCode0007ReverseInteger (reverseInteger) where

import Data.Maybe
import Test.QuickCheck

atoi :: String -> Int
atoi (x:xs) isSigned32int  takeWhile (==" ") 

-- strip whitespace 
-- strip from tail
  -- if converts to integer return

case mabyeInt x of 
  Just n  ->  
  Nothing ->  
          o
  where
    maybeInt = readMaybe char :: Maybe Int

isSigned32int :: Int 




reverseInteger x
  | ret > 2^31 = 0 
  | otherwise = sign * ret
  where sign = if x < 0 then -1 else 1   
        ret  = read.reverse.show.abs $ x 

-- Testing
prop_01 = reverseInteger 123 == 321
prop_02 = reverseInteger (-123) == (-321)
prop_03 = reverseInteger 0 == 0

{-
Complexity Anaylsis:
- O(log(n))
    - roughly log_10 digits 
-}
