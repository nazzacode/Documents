    --1. NATURAL NUMBERS
-- the following twon examples are the same function with diffrent notation
--With names
data Nat = Zero
  | Succ Nat
power :: Float -> Nat -> Float
power x Zero = 1.0
power x (Succ n) = x * power x n
   where (Succ (Succ Zero)) = 2  -- so theat you can input power 3 2

--With built-in notation
(ˆˆ) :: Float -> Int -> Float
x ˆˆ 0 = 1.0
x ˆˆ n = x * (x ˆˆ (n-1))

    -- 2. OPTIONAL DATA
    data Maybe a = Nothing | Just a

  --case 1: Optional argument
  power :: Maybe Int -> Int -> Int
  power Nothing n = 2 ˆ n
  power (Just m) n = m ˆ n

  --case2: Optional result
  divide :: Int -> Int -> Maybe Int
  divide n 0 = Nothing
  divide n m = Just (n ‘div‘ m)

      --3. UNION OF 2 TPYES
--a) either a or b

data Either a b = Left a | Right b

  --case 1) fuckknows
mylist :: [Either Int String]
mylist = [Left 4, Left 1, Right "hello", Left 2, Right " ", Right "world", Left 17]

  --case 2) reccursive
addints :: [Either Int String] -> Int
addints [] = 0
addints (Left n : xs) = n + addints xs
addints (Right s : xs) = addints xs

  -- case 3) comprehension
addints’ :: [Either Int String] -> Int
addints’ xs = sum [n | Left n <- xs]
