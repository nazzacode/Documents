    --1. REPLICATE
replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
      | n <= 0    = []
      | otherwise = x:replicate' (n-1) x
-- Eventually, the (n-1) part will cause our function to reach the edge condition.

    --2. TAKE
  take' :: (Num i, Ord i) => i -> [a] -> [a]  --defining i in both num and ord class
  take' n _
      | n <= 0   = []  -- no otherwise part -> falls through to next pattern
  take' _ []     = []  -- two edge conditions for n*0 and 0*x
  take' n (x:xs) = x : take' (n-1) xs

      -- 3. ZIP
-- takes two lists and zips them together
zip [1,2,3] [2,3] returns [(1,2),(2,3)]

zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

    -- 4. QUICK SORT (ORD)
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort [a | a <- xs, a <= x]
            biggerSorted = quicksort [a | a <- xs, a > x]
    in  smallerSorted ++ [x] ++ biggerSorted
