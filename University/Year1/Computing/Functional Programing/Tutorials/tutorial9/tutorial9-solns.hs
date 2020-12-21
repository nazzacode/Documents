-- Informatics 1 - Introduction to Computation
-- Functional Programming Tutorial 9
--
-- Week 10(19-23 Nov.)
--
-- Solutions
--
-- Remember: there are many possible solutions, and if your solution produces
-- the right results, then it is (most likely) correct. However, if your code
-- looks far more complicated than these sample solutions, then you're probably
-- making things too difficult for yourself---try to keep it simple!

module Tutorial9 where
-- Sudoku solver
-- Based on Bird, "Thinking Functionally with Haskell"

import Data.List (sort,nub,(\\),transpose,genericLength)
import Data.String (lines,unlines)

type Row a     =  [a]
type Col a     =  [a]
type Matrix a  =  Col (Row a)
type Digit     =  Char

digits :: [Digit]
digits =  ['1'..'9']

blank :: Digit -> Bool
blank d  =  d == ' '


-- 2.
group :: [a] -> [[a]]
group = groupBy 3

groupBy :: Int -> [a] -> [[a]]
groupBy n []  =  []
groupBy n xs  =  take n xs : groupBy n (drop n xs)

-- 3.
intersperse :: a -> [a] -> [a]
intersperse x []      =  [x]
intersperse x (y:ys)  =  x : y : intersperse x ys

-- 5.
showRow :: String -> String
showRow  =  concat . intersperse "|" . group

-- 6. instead of showMat
showGrid :: Matrix Digit ->  String
showGrid =  unlines . showCol . map showRow
  where
  -- showRow  =  concat . intersperse "|" . group
  showCol  =  concat . intersperse [bar] . group
  bar      =  replicate 13 '-'

-- 6.
put :: Matrix Digit -> IO ()
put =  putStrLn . showGrid

-- 7.
choices :: Matrix Digit -> Matrix [Digit]
choices =  map (map choice)
  where
  choice d | d `elem` digits  =  [d]
           | blank d          =  digits

-- 8.
cp :: [[a]] -> [[a]]
cp []        =  [[]]
cp (xs:xss)  =  [ x:ys | x <- xs, ys <- cp xss ]

expand :: Matrix [Digit] -> [Matrix Digit]
expand = cp . map cp

-- 11, 12, 13
ungroup :: [[a]] -> [a]
ungroup =  concat

rows, cols, boxs :: Matrix a -> Matrix a
rows  =  id
cols  =  transpose
boxs  =  map ungroup . ungroup . map cols . group . map group

-- 14.
distinct :: Eq a => [a] -> Bool
distinct xs  =  nub xs == xs

-- 15.
valid :: Matrix Digit -> Bool
valid g  =    all distinct (rows g)
           && all distinct (cols g)
           && all distinct (boxs g)
      
-- 16.
simple :: Matrix Digit -> [Matrix Digit]
simple =  filter valid . expand . choices

-- 18.
splits :: [a] -> [(a, [a])]
splits []      =  []
splits (x:xs)  =  (x,xs) : [ (y,x:ys) | (y,ys) <- splits xs ]

single :: [Digit] -> Bool
single [d]  =  True
single _    =  False

the :: [Digit] -> Digit
the [d]  =  d

fixed :: Row [Digit] -> [Digit]
fixed row  =  [ the ds | ds <- row, single ds ]

pruneRow :: Row [Digit] -> Row [Digit]
pruneRow row  =  [ ds \\ fixed rest | (ds,rest) <- splits row ]

-- 19.
pruneBy :: (Matrix [Digit] -> Matrix [Digit])
             -> Matrix [Digit] -> Matrix [Digit]
pruneBy f  =  f . map pruneRow . f

prune :: Matrix [Digit] -> Matrix [Digit]
prune =  pruneBy boxs . pruneBy cols . pruneBy rows

-- 20.
many :: Eq a => (a -> a) -> a -> a
many f x | x == y     =  x
         | otherwise  =  many f y
         where  y = f x

-- 21.
extract :: Matrix [Digit] -> Matrix Digit
extract mat | all (all single) mat  =  map (map the) mat

-- 22.
solve :: Matrix Digit -> Matrix Digit
solve =  extract . many prune . choices

-- 23.
failed :: Matrix [Digit] -> Bool
failed mat  =  any (any null) mat

-- 23.
solved :: Matrix [Digit] -> Bool
solved =  all (all single)

-- 27.
counts :: Matrix [Digit] -> [Int]
counts =  filter (> 1) . map length . concat

expand1 :: Matrix [Digit] -> [Matrix [Digit]]
expand1 mat
  =  [ preMat ++ [preRow ++ [[d]] ++ postRow] ++ postMat
     | d <- ds ]
     where
     shortest               =  minimum (counts mat)
     short ds               =  length ds == shortest
     (preMat, row:postMat)  =  break (any short) mat
     (preRow, ds:postRow)   =  break short row

-- 28.
search :: Matrix Digit -> [Matrix Digit]
search =  loop . choices
  where 
  loop mat | solved pruned  =  [extract pruned]
           | failed pruned  =  []
           | otherwise      =  concat (map loop (expand1 pruned))
           where pruned = many prune mat

-- Computing the search tree
-- (How hard was it to solve the puzzle?)

data Tree = Fail Int
          | Soln Int
          | Node Int [Tree]
  deriving (Show)

howmany :: Eq a => (a -> a) -> a -> (Int, a)
howmany f x | x == y     =  (0, x)
            | otherwise  =  (n+1, z)
            where  y = f x
                   (n,z) = howmany f y 

searchTree :: Matrix Digit -> Tree
searchTree = loop . choices
  where
  loop mat | solved pruned  =  Soln n
           | failed pruned  =  Fail n
           | otherwise      =  Node n (map loop (expand1 pruned))
           where (n, pruned) = howmany prune mat

-- Example from Bird

book    :: Matrix Digit
book    =  ["  4  57  ",
            "     94  ",
            "36      8",
            "72  6    ",
            "   4 2   ",
            "    8  93",
            "4      56",
            "  53     ",
            "  61  9  "]

-- Examples from websudoku.com

easy    :: Matrix Digit
easy    =  ["    345  ",
            "  89   3 ",
            "3    2789",
            "2 4  6815",
            "    4    ",
            "8765  4 2",
            "7523    6",
            " 1   79  ",
            "  942    "]

medium  :: Matrix Digit
medium  =  ["   4 6 9 ",
            "     3  5",
            "45     86",
            "6 2 74  1",
            "    9    ",
            "9  56 7 8",
            "71     64",
            "3  6     ",
            " 6 9 2   "]

hard    :: Matrix Digit
hard    =  ["9 3  42  ",
            "4 65     ",
            "  28     ",
            "     5  4",
            " 67 4 92 ",
            "1  9     ",
            "     87  ",
            "     94 3",
            "  83  6 1"]

evil    :: Matrix Digit
evil    =  ["  9      ",
            "384   5  ",
            "    4 3  ",
            "   1  27 ",
            "2  3 4  5",
            " 48  6   ",
            "  6 1    ",
            "  7   629",
            "     5   "]
br :: IO ()
br = putStrLn "***"

puts :: [Matrix Digit] -> IO ()
puts  =  sequence_ . map put

puzzle :: Matrix Digit -> IO ()
puzzle g  =  put g >>
             puts (search g) >>
             br

main =  puzzle easy >>
        puzzle medium >>
        puzzle hard >>
        puzzle evil

size :: Matrix [Digit] -> Integer
size = product . map genericLength . concat

g1 :: Matrix Digit
g1 =  replicate 9 digits