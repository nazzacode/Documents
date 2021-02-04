{-
Leetocode 0007: Given a 32-bit signed integer, reverse the digits of the integer 

Example:
Input: x = 123
Output: 321

Input: x = -123
Output: -321
-}

module LeetCode0007ReverseInteger (reverseInteger) where

import Data.Maybe
import Test.QuickCheck

reverseInteger :: Int -> Int
reverseInteger x
  | ret > 2^31 = 0 
  | otherwise = sign * ret
  where sign = if x < 0 then -1 else 1   
        ret  = read.reverse.show.abs $ x 

-- Testing
prop_01 = reverseInteger 123 == 321
prop_02 = reverseInteger (-123) == (-321)
prop_03 =reverseInteger 0 == 0

{-
Complexity Anaylsis:
- O(log(n))
    - roughly log_10 digits 
-}