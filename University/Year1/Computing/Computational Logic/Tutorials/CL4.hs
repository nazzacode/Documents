import System.Random
import qualified Data.Map as Map
(==>) :: Bool -> Bool -> Bool
(==>) a  b = if a then b else True

type Lit     = Int -- must be non-zero; positive is atom, negative its negation
data Clause  = Or  [Lit]
data Form    = And [Clause]

eval :: (Int -> Bool) -> Form ->  Bool
eval v = evalForm -- v is valuation of (some) positive integers
  where
    evalForm   (And clauses ) = and [ evalClause c | c <- clauses  ]
    evalClause (Or  literals) =  or [ evalLit x    | x <- literals ]
    evalLit (x) = if x > 0 then v x else not(v x)

type Person = String
girl :: Person -> Bool
boy :: Person -> Bool
scientist :: Person -> Bool
artist :: Person -> Bool
politician :: Person -> Bool
loves :: Person -> Person -> Bool 
people :: [Person]
girls :: [Person]
boys :: [Person]
girls = [ "Carmina", "Malika", "Margherita", "Ginny", "Loida", "Rosalie", "Nikki",
  "Bea", "Delores", "Soledad", "Sheba", "Elsy", "Lashanda", "Carolynn", "Easter",
  "Lakenya", "Glenda", "Almeda", "Crissy", "Birgit", "Lashaun", "Ashely", "Araceli",
  "Nanci", "Flo", "Cristina", "Myriam", "Randa", "Danika", "Irene", "Macy", "Larue",
  "Melaine", "Jaye", "Madalene", "Catalina", "Danille", "Adrien", "Mayra", "Donella",
  "Lajuana", "Setsuko", "Maile", "Leontine", "Jeanne", "Yesenia", "Sheri", "Ladonna",
  "Samira", "Georgianne" ]
boys = [ "Joey", "Derick", "Irwin", "Truman", "Alphonso", "Colton", "Clifton", "Merle",
  "Dewitt", "Reid", "Julius", "Glenn", "Alfonso", "Freddy", "Delmer", "Bennie", "Yong",
  "Matthew", "Irving", "Danny", "Darrell", "Lazaro", "Johnathon", "Marion", "Isreal",
  "Emil",  "Benjamin", "Stanton", "Rudolf", "Bradly", "Elbert", "Wilton", "Noble", "Ty",
  "Jon", "Brian", "Dallas", "Josh", "Randall", "Erich", "Jackson", "Sidney", "Damien",
  "Keven", "Norman", "Cristopher", "Ricky", "Cordell", "Wilber", "Rashad" ]
people = girls ++ boys
girl  = (`elem` girls)
boy   = (`elem` boys)
pairs = [ ( x, y ) | x <- people, y <- people ]

coinFlip :: (Ord a, Eq a) => [a] -> Int -> a -> Bool
coinFlip  pop seed =
  let flip = Map.fromList(zip pop (randomRs (False, True) (mkStdGen seed)))
  in
   \x -> let Just v = Map.lookup x flip in v

isHappy = coinFlip people 47

diceThrow2 :: (Ord x, Ord y, Eq x, Eq y) => Int -> [(x,y)] -> Int -> x -> y -> Bool
diceThrow2 n pop seed =
  let rolls = Map.fromList(zip pop (map (==1)(randomRs (1, n) (mkStdGen seed))))
  in
   \x y ->let Just v = Map.lookup (x,y) rolls in v

diceThrow1 :: (Ord x, Eq x) => Int -> [x] -> Int -> x -> Bool
diceThrow1 n pop seed =
  let rolls = Map.fromList(zip pop (map (==1)(randomRs (1, n) (mkStdGen seed))))
  in
   \x  ->let Just v = Map.lookup x rolls in v
    
loves      = diceThrow2 6  pairs 21
scientist  = diceThrow1 2  people 42
politician = diceThrow1 10 people 46
artist     = diceThrow1 3  people 33

couple x y = (x `loves` y) && (y `loves` x)
triangle x y z =  (x `loves` y) && (y `loves` z)  && (z `loves` x)

-- DFA another representation
type Trans state symbol =
  state -> symbol -> state -> Bool
type DFA state symbol = (
    [state]            -- k 
  , [symbol]           -- sigma 
  , state              -- q0 
  , Trans state symbol -- tau 
  , state -> Bool      -- f (accepting?)
  )
--australia
