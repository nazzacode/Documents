{-
* Tower Hopper
You have an array of numbers, reach entry tells you the maximum you can hop 
forward in the array. You must check if it is possible to hop out of the array

* Examples
  In : [2,0,1,1]
  Out: True (note: '2' -> '0' is an illegal move)

  In : [1,0,1]
  Out: False 

* Notes
  - taken from: https://www.reddit.com/r/haskell/comments/9pdx6h/make_this_short_code_beautiful_haskell/
-}
import Prelude
import Data.List

-- hopper :: [Int] -> Bool
hopper [] = True
hopper (n:ns) = any hopper (take n (tails ns))

-- don't really understand
-- hopper' = head . foldr f [True]
--   where
--     f n bs = or (take n bs) : bs


hopper'' = (>0) . foldl' f 1
  where
    f 0 _ = 0
    f m x = max (m-1) x
-- The accumulator in the fold is the distance 
-- into the list that we know we can reach.

 