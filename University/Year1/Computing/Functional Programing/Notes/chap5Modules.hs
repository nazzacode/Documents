-- Notes chapter 5: MODULES

    -- 1. LOADING MODULES
-- A module is a collection of related functions types and typeclasses
-- A program is a collection of modules (where the main load up others)

import <module name> -- to import a module

import Data.List (nub, sort) -- to import secected functions only

    -- 2. NEW DATA.LIST FUNCTIONS

  --a) intersperse & intercarlate
ghci> intersperse '.' "MONKEY"
"M.O.N.K.E.Y"  --puts an element between each pair

ghci> intercalate " " ["hey","there","guys"]
"hey there guys"  -- takes a list and a [list] and inserts the list between lists

  --b) transpose & map
ghci> transpose [[1,2,3],[4,5,6],[7,8,9]]
[[1,4,7],[2,5,8],[3,6,9]] --you know da ting

ghci> concatMap (replicate 4) [1..3]  --NO COMPRENDE!
[1,1,1,1,2,2,2,2,3,3,3,3]  -- sam as mapping a function to a list then concatenating

  --c) and/or & all/any
ghci> and $ map (>4) [5,6,7,8]
True  -- take a list of bool values and returns true is all values are true

ghci> or $ map (==4) [2,3,4,5,6,1]
True  -- returns True is any bool values is True

-- prefered over or/and $ map f(x))
all (>4) [6,9,10]
True   -- checks if all elements satisfy a predicate

any (==4) [2,3,5,6,1,4]
True -- checks if any elements satisy a predicate

  --d) interate & splitAt
take 10 $ iterate (*2) 1  - take a function and starting value and infinatly applies it
[1,2,4,8,16,32,64,128,256,512]

ghci> let (a,b) = splitAt 3 "foobar" in b ++ a
"barfoo" -- splits a list at a specified number of elements

  --e) (take)dropWhile, span & break
dropWhile --opp of takeWhile

span -- returns a pair of lists; 1st contains takeWhile, 2nd contains the rest
ghci> let (fw, rest) = span (/=' ') "This is a sentence" in "First word:" ++ fw ++ ", the rest:" ++ rest
"First word: This, the rest: is a sentence"

break (==4) [1,2,3,4,5,6,7]
([1,2,3],[4,5,6,7])  --2nd list starts with 1srt elem that satisfies the predicate
--break = span (not. p)
span (/=4) [1,2,3,4,5,6,7]
([1,2,3],[4,5,6,7])

  --f) sort & group
ghci> sort [8,5,3,2,1,6,4,2]
[1,2,2,3,4,5,6,8]  -- needs to be part of Ord typeclass
ghci> sort "This will be sorted soon"
"    Tbdeehiillnooorssstw"

group [1,1,1,1,2,2,2,2,3,3,2,2,2,5,6,7]  -- groups to equal sublists
[[1,1,1,1],[2,2,2,2],[3,3],[2,2,2],[5],[6],[7]]

-- we can find out how many times each element appears in the list.
ghci> map (\l@(x:xs) -> (x,length l)) . group . sort $ [1,1,1,1,2,2,2,2,3,3,2,2,2,5,6,7]
[(1,4),(2,7),(3,2),(5,1),(6,1),(7,1)]

  --g) inits & tails
ghci> inits "w00t"  -- like innit but recursivly applied
["","w","w0","w00","w00t"]

ghci> tails "w00t"
["w00t","00t","0t","t",""]

  --h) `fix` it & partition
isPrefixOf
isInfixOf
isSuffixOf

ghci> partition (>3) [1,3,5,6,3,2,1,0,3,7]
([5,6,7],[1,3,3,2,1,0,3])  -- takes a list & predicate returns two list (1st sats the pred)

  -- i) find elem & index(ices)
ghci> find (>4) [1,2,3,4,5,6]
Just 5  -- takes a list and predicate, returing the first element that sats the predicate, wraped in mabye valu

notElem -- ckecks if an element isnt inside a lists

ghci> 4 `elemIndex` [1,2,3,4,5,6]
Just 3  -- like elem but returns the index rather than a Bool

ghci> ' ' `elemIndices` "Where are the spaces?"
[5,9,13]  -- like elemIndex but returns a list of indices rather than mabye type

findIndex & findIndices -- like find but it mabye retures the index rather than elem

  --j) lots of zips
zip2, zip3 ... zip7 & zipWith3, zipWith4

ghci> zipWith3 (\x y z -> x + y + z) [1,2,3] [4,5,2,2] [2,2,3]
[7,9,8]

  -- k) lines bines & quines
ghci> lines "first line\nsecond line\nthird line"
["first line","second line","third line"]  -- returns every line as a seperate list

unlines ["first line", "second line", "third line"]
"first line\nsecond line\nthird line\n"  --opposite ting
