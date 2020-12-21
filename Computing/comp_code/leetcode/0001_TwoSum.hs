{- 
LeetCode 0001: Two Sum 

Question:
Given an array of integers, return indices of the two numbers such that they
add up to a specific target

You may assume that each input hs exactly one solution, and you may not use
the same element twice.
 
Example 1:
input: numbers = [2,7,11,15], target = 9
output: [0,1]
-}

module LeetCode0001TwoSum (twoSum) where

import Data.Maybe
import Data.Foldable (foldl')
import Data.IntSet   (IntSet)
import qualified Data.IntSet as IntSet
import Data.Map (Map)
import qualified Data.Map as Map
import Test.QuickCheck 


-- Attempt 2
twoSum :: [Int] -> Int -> (Int, Int)
twoSum nums target = head $ snd $ foldl' go (Map.empty, []) (zip [0..] nums)
  where
    go :: (Map Int Int, [(Int, Int)]) -> (Int, Int) -> (Map Int Int, [(Int, Int)])
    go (checkedMap, results) (index, checknum) =
       let numtofind = target - checknum
        in if Map.member numtofind checkedMap
         then (checkedMap, (fromJust (Map.lookup numtofind checkedMap), index):results)
         else (Map.insert checknum index checkedMap, results)


-- -- Attempt 1 
--twoSum :: [Int] -> Int -> [(Int, Int)]
--twoSum nums target = snd . foldl' go (IntSet.empty, []) $ nums
  --where
    --go :: (IntSet, [(Int, Int)]) -> Int -> (IntSet, [(Int, Int)])
    --go (checkSet, results) checknum =
      --let numtofind = target - checknum
       --in if IntSet.member numtofind checkSet
          --then (checkSet, (numtofind, checknum):results)
          --else (IntSet.insert checknum checkSet, results)


-- Original
--twoSum :: Int -> [Int] -> [(Int, Int)]
--twoSum x = snd . foldl' go (IntSet.empty, [])
  --where
    --go :: (IntSet, [(Int, Int)]) -> Int -> (IntSet, [(Int, Int)])
    --go (ys, results) z =
      --let y = x - z
       --in if IntSet.member y ys
          --then (ys, (y, z):results)
          --else (IntSet.insert z ys, results)


-- Testing
prop_01 = twoSum [2,7,11,15] 9 == (0,1)
prop_02 = twoSum [3,2,4] 6 == (1,2)
{- 
Submission:
_ ms, faster than _ %
_ Mb, less than _ %

Complexity Anaylsis:
- Brute force would be O(n^2) as requires double loop 
- Single pass hash table implementation O(n)
   - single loop + amortized hash lookup
-}
