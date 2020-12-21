{-
Leetocode 0005: Longest Palindromic Substring 
Given a string s, find the longest palindromic substring in s.

Example:
Input: "babad"
Output: "bab"
Note, "aba" is alo a valid answer
-}

module LeetCode0005LongestPalendromicSubstring (longestPalendromicSubstring) where

import Data.Maybe
import Test.QuickCheck

longestPalendromicSubstring :: [Char] -> [Char]
longestPalendromicSubstring [] = []
longestPalendromicSubstring [x] = [x]
longestPalendromicSubstring (x:xs) = longestPalendromicSubstring' (x:xs) 0 1 [] 
  where
  longestPalendromicSubstring' :: [Char] -> Int -> Int -> [Char] -> [Char]
  longestPalendromicSubstring' str i j result
    | j == length str + 1          = result
    | isPalindrome  substr           = longestPalendromicSubstring' str   i   (j+1)  substr
    | i >= 1 && isPalindrome ssubstr = longestPalendromicSubstring' str (i-1) (j+1) ssubstr
    | otherwise                      = longestPalendromicSubstring' str (i+1) (j+1) result 
    where substr  = slice   i   j str
          ssubstr = slice (i-1) j str

slice :: Int -> Int -> [a] -> [a]
slice i j x = drop i (take j x) 

isPalindrome :: [Char] -> Bool
isPalindrome x = x == reverse x

-- Testing
prop_01 = longestPalendromicSubstring "abccba" == "abccba"
prop_02 = longestPalendromicSubstring "banana" == "anana"
prop_03 = longestPalendromicSubstring "a" == "a"

{-
Complexity Anaylsis:
- O(n^2)
- can be done in O(n) with manachers algorithm
Notes:
-}
