    --1. QUICK CHECK
-- tests a property with 100 randomly-generated values

import Test.QuickCheck

prop_revapp :: [Int] -> [Int] -> Bool
prop_revapp xs ys = reverse (ys++xs) == reverse xs ++ reverse ys

quickCheck prop_revapp --to check dis shizzle.
