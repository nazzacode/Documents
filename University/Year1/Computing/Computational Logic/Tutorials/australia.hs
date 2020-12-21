-- Australia - map colouring
import Test.QuickCheck
import qualified Data.Map.Strict as Map 
import Data.Maybe

data City   = P | B | H | A | S | D | M deriving (Eq, Ord, Show)
data Colour = Red | Green | Amber       deriving (Eq, Ord, Show)
type Colouring = City -> Colour -> Bool
cities  = [ P, B, H, A, S, D, M ]
colours = [Red, Green, Amber]
neighbours                  :: [(City, City)] 
neighbours = undefined
-- define what it means to be a legal colouring
-- each node has a colour
eachCityHasAColour          :: Colouring -> Bool
eachCityHasAColour colouring = undefined
--adjacent cities cannot have the same colour
adjacentCitiesNotSameColour :: Colouring -> Bool
adjacentCitiesNotSameColour colouring = undefined

-- the code below allows you to use quickCheck to search for
-- a valuation that satsfies your constraints
-- we have 21 (City, Colour) pairs
pairs = [(city, colour) | city <- cities, colour <- colours]
-- we use 21 booleans to define a colouring
colourBy a b c d e f g h i j k l m n o p q r s t u =
  let table =
        Map.fromList
        (zip pairs [ a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u ])
  in
    curry (fromJust . (Map.!?) table)

-- to get quickCheck to search for a colouring that satisfies
-- the conditions, we hypothesise that one of our conditions
-- always fails
test_prop a b c d e f g h i j k l m n o p q r s t u =
  let colouring =
        colourBy a b c d e f g h i j k l m n o p q r s t u
  in
    not (adjacentCitiesNotSameColour colouring)
    ||
    not (eachCityHasAColour colouring)

-- if you run quickCheck with a large enough number of tests e.g.
--        quickCheck (withMaxSuccess 12345 test_prop)
-- (but 12345 may not be big enough) you should find a
-- counter-example to our test proposition. 
