    -- 1. SQUARES (REVISITED)
squares :: [Int] -> [Int]
squares xs      = [ x*x | x <- xs ] --wooosh (list comprehension)
--OR
squares :: [Int -> [Int]
squares []      = []
squares (x:xs)  = x*x : squares xs -- tic tic tic (recursion)

    -- 2.MAP
  map :: (a -> b) -> [a] -> [b]
  map f []      = []
  map f (x:xs)  = f x : map f xs
