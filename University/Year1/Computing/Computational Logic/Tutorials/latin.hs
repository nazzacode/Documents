import System.Random
import Test.QuickCheck

-- Square
type Column = Int -- [0..n-1]
type Row    = Int -- [0..n-1]
type Digit  = Int -- [1..n]
data Square = Square [[Digit]] deriving (Show)

latin :: Square -> Bool
latin (Square m) =
  let n = length m
  in
   if any ((/=n).length) m then undefined
   else
     let -- define a relation p
       p c r d = ((m !! r) !! c) == d
       columns = [0..n-1]
       rows    = [0..n-1]
       digits  = [1..n]
     in
     undefined -- check that each digit
     &&        -- occurs in each row
     undefined -- and in each column
            
-- code for quickCheck below
squareGen :: Int -> Gen Square
squareGen n = fmap Square (vectorOf n (vectorOf n(choose (1,n)) ))

-- squareGen n produces nxn squares
-- (forAll (squareGen n) (not.latin)) is a quickCheck property
-- quickCheck (withMaxSuccess (2^32)(forAll (squareGen 5) (not . latin)))

