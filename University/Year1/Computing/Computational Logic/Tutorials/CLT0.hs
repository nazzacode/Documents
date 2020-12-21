
base :: Int -> Int -> [Char]
  base x 0 = ""
  base x n = base x d ++ [digits !! m]
    where (d,m) = n ‘divMod‘ x
