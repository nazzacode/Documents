{-
LeetCode 0003: Longest Substring without repeating characters

Question:
Given a string s, find the length of the longest substring without repeating characters.

Example 1:
    Input: s = "abcabcbb"
    Output: 3
    Explanation: "abc" with length of 3
-}

module LeetCode0003LongestSubstring (longestSubstring) where

import Data.Maybe
import Test.QuickCheck
import Data.Map (Map)
import qualified Data.Map as M

-- Attempt 2
longestSubstring :: [Char] -> Int
longestSubstring [] = 0
longestSubstring x  = go x M.empty 0 0
  where 
    go :: [Char] -> Map Char Int -> Int -> Int -> Int
    go   []   hmap i j = 0  -- i,j = substring start, substring end 
    go (x:xs) hmap i j
      | x `M.member` hmap = go (x:xs) (M.delete x hmap) i' j
      | otherwise         = max lenSubstr (go xs (M.insert x i hmap) i (j+1))
        where
          i' = max i fromMaybe 0 (x `M.lookup` hmapIn) + 1
          lenSubstr = j - i + 1 
          hmapIn    = M.insert x i hmap


-- Testing
prop_01 = longestSubstring "aaaaaa" == 1
prop_02 = longestSubstring "abcabcbb" == 3

{-
Complexity Anaylsis:
- O(n)

Notes:
- 'sliding window'
- very fast and efficient
-}

{-
-- Attempt 1
longestSubstring :: [Char] -> Int
longestSubstring []   = 0
longestSubstring str = go str Map.empty 0 0
  where 
    go :: [Char] -> Map Char Int -> Int -> Int -> Int
    go   []   hmap i j = 0  -- i : substring start, j : substring end 
    go (x:xs) hmap i j 
       | Map.member x hmap = go (x:xs) hmapDel i' j
       | otherwise         = max lenSubstr (go xs hmapIn i (j+1))
        where
          i' = max x_prev i 
            where x_prev = (fromMaybe 0 (Map.lookup x hmapIn)) + 1
          lenSubstr = j - i + 1 
          hmapDel   = Map.delete x hmap 
          hmapIn    = Map.insert x i hmap
-}
