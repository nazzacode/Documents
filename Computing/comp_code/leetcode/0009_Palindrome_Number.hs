-- Leetocode 0009: Given an integer x, return true if x is a palindrome integer

module LeetCode0009PalindromeNumber (palindromeNumber) where

-- Testing / Examples
prop_01 = not (palindromeNumber 123)
prop_02 = not (palindromeNumber (-123))
prop_03 = palindromeNumber 0
prop_04 = palindromeNumber 111

palindromeNumber :: Int -> Bool
palindromeNumber x = show x == reverse (show x)

-- Complexity Anaylsis:
-- O(1)

-- Notes:
-- - why does `prop_00 = not $ pal...` not work
-- - similarly, `reverse $ show x` 
-- - how to use quickchek to do multiple autotests