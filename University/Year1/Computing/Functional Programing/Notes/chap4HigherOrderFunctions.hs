-- Notes chapter 4: HIGHER ORDER FUNCTIONS

    --1. INFIX FUNCTIONS (PARTIAL APPLICATION)
--infix functions can be partialy applied
-- divideByTen 200 is equivalent to doing 200 / 10, as is doing (/10) 200
divideByTen :: (Floating a) => a -> a
divideByTen = (/10)

    --2. APPLY TWICE
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

ghci> applyTwice (3:) [1]
[3,3,1]

    --3. ZIPWITH
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

    --4. MAP
--map takes a function and a list and applies that function to every element in the list
map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

ghci > map (replicate 3) [3..6]
[[3,3,3],[4,4,4],[5,5,5],[6,6,6]]

--note this could also be done with list comprehension
ghci > [replicate 3 x | x <- [3..6]]

    --5. FILTER
--filter takes a predicate (function that returns a bool) and returns a list of elem that sasisfies that predicate
fliter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
fliter p (x:xs)
    | p x         = x :fliter p xs
    | otherwise   = filter p xs


-- Map and Filter are equivalent to list comp. and the bread and butter of FP

    --6. TAKEWHILE
  --takes a predicate and a list the goes to the beginnning of the list returning elements that are true until one isnt, then it stop.
ghci > takeWhile (/=' ') "elephants know how to party"
elephants

ghci> sum (takeWhile (<10000) (filter odd (map (^2) [1..])))
166650

--OR

ghci> sum (takeWhile (<10000) [n^2 | n <- [1..], odd (n^2)])
166650

    --7. LAMBDAS
--anonymous functions that are used when we need functions only once.
ghci> map (\(a,b) -> a + b) [(1,2),(3,5),(6,3),(2,6),(2,5)]
[3,8,9,8,7]

    --8. FOLDS
--takes a binary function, a starting value and a list to 'fold' up
-- sort of like map but combines function to return a single value

    --8a) Left Fold
ghci > sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs
--'acc' for acumulator
--'l' for left fold

ghci > sum' :: (Num a) => [a] -> a
sum' = foldl (+) 0
-- more elegant but less readable

    -- 8b) Right Fold
folr
--foldr binary function has the current value as the 1st parameter and the accumulator as the 2nd
\x acc -> ...)
--right folds work on infintie lists, left folds dont!
-- any time you want to traverse a list to return somthing, you want a fold.

    -- 8c) R1 & L1
foldl1 & foldr1
 -- work same but assumes the first(last) elem of [] to be the starting value
-- starts the fold with the element next to it
product' :: (Num a) => [a] -> a
product' = foldr1 (*)


    -- 9. scan
scanl & scanr
-- like fold only report all the intermediary acc states
-- scan1l & scan1r are quivalent to their fold namesakes
ghci > scanl1 (\acc x -> if x > acc then x else acc) [3,4,5,3,7,9,2,1]
[3,4,5,5,7,9,9,9]

    -- 10. $$$$ BITCHES
-- lowest precedence functions
-- function applications with a $ are right associative
-- equivalent of writing opening/closing parenthisis
f (g (z x)) = f $ g $ z x

sum (filter (> 10) (map (*2) [2..10]))
-- OR
sum $ filter (> 10) $ map (*2) [2..10].

    --11. COMPOSITE FUNCTIONS
-- haskell notation for (f o g) (x) f( g (x))
(.) :: (b -> c) -> (a -> b) -> a -> c
f . g = \x -> f (g x)


-- Original
oddSquareSum :: Integer
oddSquareSum = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))


-- Most elegant (composite)
oddSquareSum :: Integer
oddSquareSum = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]


-- Most readable for others
oddSquareSum :: Integer
oddSquareSum =
    let oddSquares = filter odd $ map (^2) [1..]
        belowLimit = takeWhile (<10000) oddSquares
    in  sum belowLimit
