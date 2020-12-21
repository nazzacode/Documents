-- Informatics 1 - Introduction to Computation
-- Functional Programming Tutorial 5
--
-- Week 6(22-26 Oct.)
module Tutorial5 where

import Control.Monad( liftM, liftM2 )
import Data.List( nub )
import Test.QuickCheck( quickCheck,
                        Arbitrary( arbitrary ),
                        oneof, elements, sized  )


--------------------------------------------------
--------------------------------------------------
---Implementing propositional logic in Haskell----
--------------------------------------------------
--------------------------------------------------

-- The datatype 'Wff'

type Name = String
data Wff = Var Name
          | F
          | T
          | Not Wff
          | Wff :|: Wff
          | Wff :&: Wff
          | Wff :->: Wff
          | Wff :<->: Wff
          deriving (Eq, Ord)

type Names = [Name]
type Env = [(Name, Bool)]


-- Functions for handling Wffs

-- turns a Wff into a string approximating mathematical notation
showWff :: Wff -> String
showWff (Var x)        =  x
showWff (F)            =  "F"
showWff (T)            =  "T"
showWff (Not p)        =  "(~" ++ showWff p ++ ")"
showWff (p :|: q)      =  "(" ++ showWff p ++ "|" ++ showWff q ++ ")"
showWff (p :&: q)      =  "(" ++ showWff p ++ "&" ++ showWff q ++ ")"
showWff (p :->: q)     =  "(" ++ showWff p ++ "->" ++ showWff q ++ ")"
showWff (p :<->: q)     =  "(" ++ showWff p ++ "<->" ++ showWff q ++ ")"
-- evaluates a wff in a given environment
eval :: Env -> Wff -> Bool
eval e (Var x)        =  lookUp x e
eval e (F)            =  False
eval e (T)            =  True
eval e (Not p)        =  not (eval e p)
eval e (p :|: q)      =  eval e p || eval e q
eval e (p :&: q)      =  eval e p && eval e q
eval e (p :->: q)     =  not (eval e p) || eval e q
eval e (p :<->: q)    =  eval e p == eval e q
-- retrieves the names of variables from a wff -
--  NOTE: variable names in the result must be unique
names :: Wff -> Names
names (Var x)        =  [x]
names (F)            =  []
names (T)            =  []
names (Not p)        =  names p
names (p :|: q)      =  nub (names p ++ names q)
names (p :&: q)      =  nub (names p ++ names q)
names (p :->: q)     =  nub (names p ++ names q)
names (p :<->: q)    =  nub (names p ++ names q)


-- creates all possible truth assignments for a set of variables
envs :: Names -> [Env]
envs []      =  [[]]
envs (x:xs)  =  [ (x,False):e | e <- envs xs ] ++
                [ (x,True ):e | e <- envs xs ]

-- checks whether a wff is satisfiable
satisfiable :: Wff -> Bool
satisfiable p  =  or [ eval e p | e <- envs (names p) ]


--------------------------------------------------
--------------------------------------------------
------------------ Exercises ---------------------
--------------------------------------------------
--------------------------------------------------

-- 1.
wff1 = ((Var "P" :|: Var "Q" ) :&: ( Var "P" :&: Var "Q"))
wff2 = ((Var "P" :&: ( Var "Q" :|: Var "R")) :&: ((Not (Var "P") :|: Not (Var "Q")) :&: (Not (Var "P") :|: Not (Var "R"))))


-- 2.
tautology :: Wff -> Bool
tautology p = and [ eval e p | e <- envs (names p) ]

prop_taut1 :: Wff -> Bool
prop_taut1 p = tautology p || satisfiable (Not p)

prop_taut2 :: Wff -> Bool
prop_taut2 = undefined


-- 3.
wff3 = undefined
wff4 = undefined

-- 4.
equivalent :: Wff -> Wff -> Bool
equivalent p q  =  and [eval e p == eval e q | e <- theEnvs]
    where
      theNames  =  nub (names p ++ names q)
      theEnvs   =  envs theNames

-- 5.
subformulas :: Wff -> [Wff]
subformulas (Not p)      = Not p : subformulas p
subformulas (p :|: q)    = (p :|: q)   : nub (subformulas p ++ subformulas q)
subformulas (p :&: q)    = (p :&: q)   : nub (subformulas p ++ subformulas q)
subformulas (p :->: q)   = (p :->: q)  : nub (subformulas p ++ subformulas q)
subformulas (p :<->: q)  = (p :<->: q) : nub (subformulas p ++ subformulas q)
subformulas p            = [p]
--------------------------------------------------
--------------------------------------------------
---------------- Tutorial Activities -------------
--------------------------------------------------
--------------------------------------------------
-- Warmup exercises

-- The datatype 'Fruit'
data Fruit = Apple String Bool
           | Orange String Int

-- Some example Fruit
apple, apple', orange :: Fruit
apple  = Apple "Granny Smith" False -- a Granny Smith apple with no worm
apple' = Apple "Braeburn" True     -- a Braeburn apple with a worm
orange = Orange "Sanguinello" 10    -- a Sanguinello with 10 segments

fruits :: [Fruit]
fruits = [Orange "Seville" 12,
          Apple "Granny Smith" False,
          Apple "Braeburn" True,
          Orange "Sanguinello" 10]

-- This allows us to print out Fruit in the same way we print out a list, an Int or a Bool.
instance Show Fruit where
  show (Apple variety hasWorm)   = "Apple("  ++ variety ++ "," ++ show hasWorm  ++ ")"
  show (Orange variety segments) = "Orange(" ++ variety ++ "," ++ show segments ++ ")"

-- 6.
isBloodOrange :: Fruit -> Bool -- could have this been done with or?
isBloodOrange (Orange "Tarocco" _) = True
isBloodOrange (Orange "Moro" _) = True
isBloodOrange (Orange "Sanguinello" _) = True
isBloodOrange _ = False

-- 7.
segments :: Fruit -> Int
segments (Orange _ n) = n
segments (Apple _ _ ) = 0

bloodOrangeSegments :: [Fruit] -> Int
bloodOrangeSegments fl = sum [ segments f | f <- fl , isBloodOrange f == True ]

-- 8.

isWormy :: Fruit -> Bool
isWormy(Apple _ b) = b
isWormy(Orange _ _) = False

worms :: [Fruit] -> Int
worms fl = length [ True | f <- fl, isWormy f ]

-- Test your Logic
-- 9.
wff5 = undefined

wff6 = undefined

equivalent' :: Wff -> Wff -> Bool
equivalent' = undefined

prop_equivalent :: Wff -> Wff -> Bool
prop_equivalent = undefined

--------------------------------------------------
--------------------------------------------------
-- Optional Material
--------------------------------------------------
--------------------------------------------------

-- 9.
-- check for negation normal form
isNNF :: Wff -> Bool
isNNF = undefined

-- 10.
-- convert to negation normal form
toNNF :: Wff -> Wff
toNNF = undefined

-- check if result of toNNF is in neg. normal form
prop_NNF1 :: Wff -> Bool
prop_NNF1 f  =  isNNF (toNNF f)

-- check if result of toNNF is equivalent to its input
prop_NNF2 :: Wff -> Bool
prop_NNF2 f  =  equivalent f (toNNF f)


-- 11.
-- check whether a formula is in conj. normal form
isCNF :: Wff -> Bool
isCNF = undefined


-- 13.
-- transform a list of lists into a (CNF) formula
listsToCNF :: [[Wff]] -> Wff
listsToCNF = undefined


-- 14.
-- transform a CNF formula into a list of lists
listsFromCNF :: Wff -> [[Wff]]
listsFromCNF = undefined


-- 15.
-- transform an arbitrary formula into a list of lists
toCNFList :: Wff -> [[Wff]]
toCNFList = undefined



-- convert to conjunctive normal form
toCNF :: Wff -> Wff
toCNF wff  =  listsToCNF (toCNFList wff)

-- check if result of toCNF is equivalent to its input
prop_CNF :: Wff -> Bool
prop_CNF p  =  equivalent p (toCNF p)




-- For QuickCheck --------------------------------------------------------

instance Show Wff where
    show  =  showWff

instance Arbitrary Wff where
    arbitrary  =  sized wff
        where
          wff n | n <= 0     =  atom
                 | otherwise  =  oneof [ atom
                                       , liftM Not subform
                                       , liftM2 (:|:) subform subform
                                       , liftM2 (:&:) subform subform
                                       , liftM2 (:->:) subform subform
                                       , liftM2 (:<->:) subform' subform'
                                       ]
                 where
                   atom = oneof [liftM Var (elements ["P", "Q", "R", "S"]),
                                   elements [F,T]]
                   subform  =  wff (n `div` 2)
                   subform' =  wff (n `div` 4)


-- For Drawing Tables ----------------------------------------------------

-- centre a string in a field of a given width
centre :: Int -> String -> String
centre w s  =  replicate h ' ' ++ s ++ replicate (w-n-h) ' '
            where
            n = length s
            h = (w - n) `div` 2

-- make a string of dashes as long as the given string
dash :: String -> String
dash s  =  replicate (length s) '-'

-- convert boolean to T or F
fort :: Bool -> String
fort False  =  "F"
fort True   =  "T"

-- print a table with columns neatly centred
-- assumes that strings in first row are longer than any others
showTable :: [[String]] -> IO ()
showTable tab  =  putStrLn (
  unlines [ unwords (zipWith centre widths row) | row <- tab ] )
    where
      widths  = map length (head tab)

table p = tables [p]

tables :: [Wff] -> IO ()
tables ps  =
  let xs = nub (concatMap names ps) in
    showTable (
      [ xs            ++ ["|"] ++ [showWff p | p <- ps]           ] ++
      [ dashvars xs   ++ ["|"] ++ [dash (showWff p) | p <- ps ]   ] ++
      [ evalvars e xs ++ ["|"] ++ [fort (eval e p) | p <- ps ] | e <- envs xs]
    )
    where  dashvars xs        =  [ dash x | x <- xs ]
           evalvars e xs      =  [ fort (eval e (Var x)) | x <- xs ]

-- print a truth table, including columns for subformulas
fullTable :: Wff -> IO ()
fullTable = tables . filter nontrivial . subformulas
    where nontrivial :: Wff -> Bool
          nontrivial (Var _) = False
          nontrivial T       = False
          nontrivial F       = False
          nontrivial _       = True


-- Auxiliary functions

lookUp :: Eq a => a -> [(a,b)] -> b
lookUp z xys  =  the [ y | (x,y) <- xys, x == z ]
    where the [x]  =  x
          the _    =  error "eval: lookUp: variable missing or not unique"
