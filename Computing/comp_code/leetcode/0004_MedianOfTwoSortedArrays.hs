{- Leetcode 0004. Meadian of Two Sorted Arrays

Question:
There are two sorted arrays `nums1` and `nums2` of size `m` and `n` respectivly, return the median of the two sorted arrays. (You may assume the arrays cannot both be empty.)
Aim: 
Overall runtime complexity should be O(log(m+n)).
-}

module LeetCode0004MedianOfTwoSortedArrays (medianOfTwoSortedArrrays) where

import Test.QuickCheck

medianOfTwoSortedArrrays :: (Ord a, Integral a, Fractional b) => [a] -> [a] -> b
medianOfTwoSortedArrrays xs ys = median $ map fromIntegral $ merge xs ys

merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) | x <= y    = x : merge xs (y:ys)
                    | otherwise = y : merge (x:xs) ys

median :: (Fractional a) => [a] -> a
median xs | odd  len = xs !! mid 
          | even len = (xs !! (mid - 1) + xs !! mid) / 2 
  where len = length xs
        mid = len `div` 2 


-- Testing
prop_01 = medianOfTwoSortedArrrays [1,3] [2] == 2
prop_02 = medianOfTwoSortedArrrays [1,2] [3,4] == 2.5
prop_03 = medianOfTwoSortedArrrays [0,0] [0,0] == 0
prop_04 = medianOfTwoSortedArrrays [] [1] == 1


{-
Complexity Anaylsis:
- O(n)

Notes:
- can be done faster, namely O(log(min(m,n)))
-}
