-- Informatics 1 - Introduction to Computation
-- Functional Programming Tutorial 5
--
-- Week 6(22-26 Oct.)
--
-- Solutions
--
-- Remember: there are many possible solutions, and if your solution produces
-- the right results, then it is (most likely) correct. However, if your code
-- looks far more complicated than these sample solutions, then you're probably
-- making things too difficult for yourself---try to keep it simple!

module Tutorial5 where

import Control.Monad( liftM, liftM2 )
import Data.List( nub, sort, delete, tails )
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

-- turns a wff into a string approximating mathematical notation
showWff :: Wff -> String
showWff (Var x)        =  x
showWff (F)            =  "F"
showWff (T)            =  "T"
showWff (Not p)        =  "(~" ++ showWff p ++ ")"
showWff (p :|: q)      =  "(" ++ showWff p ++ "|" ++ showWff q ++ ")"
showWff (p :&: q)      =  "(" ++ showWff p ++ "&" ++ showWff q ++ ")"
showWff (p :->: q)     =  "(" ++ showWff p ++ "->" ++ showWff q ++ ")"
showWff (p :<->: q)    =  "(" ++ showWff p ++ "<->" ++ showWff q ++ ")"

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
wff1  =  (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")
wff2  =  (Var "P" :&: (Var "Q" :|: Var "R")) :&:
       ((Not (Var "P") :|: Not (Var "Q")) :&: (Not (Var "P") :|: Not (Var "R")))


-- 2.
tautology :: Wff -> Bool
tautology p  =  and [ eval e p | e <- envs (names p) ]

prop_taut1 :: Wff -> Bool
prop_taut1 p  =  tautology p || satisfiable (Not p)

prop_taut2 :: Wff -> Bool
prop_taut2 p  =  not (satisfiable p) || not (tautology (Not p))


prop_taut :: Wff -> Bool
prop_taut p  =  tautology p == not (satisfiable (Not p))

-- 3.
wff3  =  (Var "P" :->: Var "Q") :&: (Var "P" :&: Not (Var "Q"))
wff4  =  (Var "P" :<->: Var "Q") :&: ((Var "P" :&: Not (Var "Q")) :|: (Not (Var "P") :&: Var "Q"))


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
isBloodOrange :: Fruit -> Bool
isBloodOrange (Orange "Tarocco" _) = True
isBloodOrange (Orange "Moro" _) = True
isBloodOrange (Orange "Sanguinello" _) = True
isBloodOrange _ = False

-- 7.
segments :: Fruit -> Int
segments(Orange _ n) = n
segments(Apple _ _) = 0

bloodOrangeSegments :: [Fruit] -> Int
bloodOrangeSegments fl = sum [ segments f | f <- fl, isBloodOrange f ]

-- 8.
isWormy :: Fruit -> Bool
isWormy(Apple _ b) = b
isWormy(Orange _ _) = False

worms :: [Fruit] -> Int
worms fl = length [ True | f <- fl, isWormy f ]

-- Test your Logic
-- 9.
wff5  =  (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

wff6  =  (Var "P" :->: Var "Q") :&: (Var "P" :<->: Var "Q")

equivalent' :: Wff -> Wff -> Bool
equivalent' p q  =  tautology (p :<->: q)

prop_equivalent :: Wff -> Wff -> Bool
prop_equivalent p q  =  equivalent p q == equivalent' p q
--------------------------------------------------
--------------------------------------------------
-- Optional Material
--------------------------------------------------
--------------------------------------------------
-- 9.
-- check for negation normal form
isNNF :: Wff -> Bool
isNNF (p :&: q)      =  isNNF p && isNNF q
isNNF (p :|: q)      =  isNNF p && isNNF q
isNNF (Not (Var _))  =  True
isNNF (Var _)        =  True
isNNF T              =  True
isNNF F              =  True
isNNF _              =  False

-- 10.
-- convert to negation normal form
toNNF :: Wff -> Wff
toNNF (p :|: q)       = toNNF p :|: toNNF q
toNNF (p :&: q)       = toNNF p :&: toNNF q
toNNF (p :->: q)      = toNNFnot p :|: toNNF q
toNNF (p :<->: q)     = (toNNFnot p :|: toNNF q) :&: (toNNF p :|: toNNFnot q)
toNNF (Not p)         = toNNFnot p
toNNF p               = p

toNNFnot (p :|: q)    = toNNFnot p :&: toNNFnot q
toNNFnot (p :&: q)    = toNNFnot p :|: toNNFnot q
toNNFnot (p :->: q)   = toNNF p :&: toNNFnot q
toNNFnot (p :<->: q)  = (toNNFnot p :|: toNNFnot q) :&: (toNNF p :|: toNNF q)
toNNFnot (Not p)      = toNNF p
toNNFnot T            = F
toNNFnot F            = T
toNNFnot (Var a)      = Not (Var a)


toNNF' :: Wff -> Wff
toNNF' = toNNF
  where toNNF (Not (p :|: q)) = toNNF (Not p) :&: toNNF (Not q)
        toNNF (Not (p :&: q)) = toNNF (Not p) :|: toNNF (Not q)
        toNNF (Not (Not x)) = toNNF x
        toNNF (Not F) = T
        toNNF (Not T) = F
        toNNF (Not (p :->: q)) = toNNF (Not (toNNF (p :->: q)))
        toNNF (Not (p :<->: q)) = toNNF (Not (toNNF (p :<->: q)))
        toNNF (p :->: q) = toNNF (Not p) :|: toNNF q
        toNNF (p :<->: q) = toNNF (p :->: q) :&: toNNF (q :->: p)
        toNNF (p :|: q) = toNNF p :|: toNNF q
        toNNF (p :&: q) = toNNF p :&: toNNF q
        toNNF x = x -- Var, F, T

-- check if result of toNNF is in neg. normal form
prop_NNF1 :: Wff -> Bool
prop_NNF1 p  =  isNNF (toNNF p)

-- check if result of toNNF is equivalent to its input
prop_NNF2 :: Wff -> Bool
prop_NNF2 p  =  equivalent p (toNNF p)

-- 11.
-- check whether a formula is in conj. normal form
isCNF :: Wff -> Bool
isCNF T          =  True
isCNF F          =  True
isCNF (p :&: q) | p == T || p == F || q == T || q == F = False
                | otherwise = isCNF p && isCNF q
isCNF p          =  isClause p
    where
      isClause (p :|: q)  =  isClause p && isClause q
      isClause p          =  isLiteral p
          where
            isLiteral (Not (Var _))  =  True
            isLiteral (Var _)        =  True
            isLiteral _              =  False


-- 13.
-- transform a list of lists into a (CNF) formula
listsToCNF :: [[Wff]] -> Wff
listsToCNF xss  |  null xss      =  T
                |  any null xss  =  F
                |  otherwise     =  (foldl1 (:&:) . map (foldl1 (:|:))) xss

-- 14.
-- transform a CNF formula into a list of lists
listsFromCNF :: Wff -> [[Wff]]
listsFromCNF p  |  not (isCNF p)  =  error "listsFromCNF: formula is not in CNF"
                |  otherwise      =  getClauses p
                where
                  getClauses (p :&: q)  =  getClauses p ++ getClauses q
                  getClauses p          =  [getLiterals p]
                  getLiterals (p :|: q) =  getLiterals p ++ getLiterals q
                  getLiterals p         =  [p]


-- 15.

-- transform an arbitrary formula into a list of lists
toCNFList :: Wff -> [[Wff]]
toCNFList p = cnf (toNNF p)
    where
      cnf F              =  [[]]
      cnf T              =  []
      cnf (Var n)        =  [[Var n]]
      cnf (Not (Var n))  =  [[Not (Var n)]]
      cnf (p :&: q)      =  nub (cnf p ++ cnf q)
      cnf (p :|: q)      =  [nub $ x ++ y | x <- cnf p, y <- cnf q]


-- convert to conjunctive normal form
toCNF :: Wff -> Wff
toCNF p  =  listsToCNF (toCNFList p)

-- check if result of toCNF is equivalent to its input
wff_CNF :: Wff -> Bool
wff_CNF p  =  equivalent p (toCNF p)

-- -- -- 15.

-- -- Resolution
-- -- Determine whether a clause contains a tautology
-- trivial :: [Wff] -> Bool
-- trivial xs = or [ elem (toNNF (Not p)) ps | (p:ps) <- tails xs ]

-- complements :: [Wff] -> [Wff] -> [(Wff,Wff)]
-- complements ps qs = nub $ [ (p,q) | p <- ps, q <- qs, p == toNNF (Not q) ]

-- -- Compute all resolvents from two clauses
-- resolve :: [Wff] -> [Wff] -> [[Wff]]
-- resolve xs ys = [ delete p xs ++ delete q ys | (p,q) <- complements xs ys ]

-- -- Compute the first level of the search.
-- resolveBase :: [[Wff]] -> [[Wff]]
-- resolveBase xss = concat [ resolve xs ys | xs:yss <- tails (filter (not . trivial) xss), ys <- yss ]

-- -- Resolution
-- resolution xss = any null xss || or [ r xs xss | xs <- resolveBase xss ]
--   where r [] xss = True
--         r xs yss = or [ r (nub $ sort zs) (add xs yss) | ys <- yss, zs <- resolve xs ys ]
--         add xs xss | xs `elem` xss = []
--                    | trivial xs    = []
--                    | otherwise     = xs : xss

-- prop_resolve p = resolution (toCNFList (Not p)) == tautology p



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
