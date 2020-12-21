
    --1. EXPLICIT TYPES
Int : interger -- whole numbers (bounded - by 32 bit machines to +/-2147483647)
  Interger : also interger -- unbounded so used to represent really big numbers
Float : real floating point -- real number
  Double : real floating point -- double the precision
Char ; character -- single quotes 'a', a list of chars is a String
Bool : boolean  --True or False '4 ==5'
Turples --infinite number of turple types, empty tuple ()

a -- type variable, can be of any type (very powerful)
:t --to print the type class of an expression

--functions also have types, when writing our own its good practice to give them and explicit type decleration
  addThree :: Int -> Int -> Int -> Int
  addThree x y z = x + y + z


    --2. TYPECLASS
--A typeclass is an interface that defines some behavior. If a type is a part of a typeclass, that means that it supports and implements the behavior the typeclass describes.

Eq -- used for types that support equality testing (==, /=) (all above included)
Ord -- for types that have ordering, Ord is contained in Eq and covers comparing functions such as >,<,>=,<=.
  5 `compare` 3  --conpare function can be used to return  3 values GT, LT, EQ.
  -> GT
Show -- can be presented as strings
  show 5.332
  -> "5.332"
Read --opposite of show, take a string and returs a typeclass memeber of Read
  read "8.2" + 3.8
  -> 12.0 -- read knows what typeclass to convert to because you have used the information in an operation
  read "4" --will return an error message
  read "(3, 'a')" :: (Int, Char)
  (3, 'a')  --this is more like it :)
Enum -- sequentialy ordered types (Bool, Char, Ordering, Int, Integer, Float and Double)
Bounded -- members have an upper and lower bound
  minBound :: Int  -- also maxbound
_ -> -2147483648
Num -- members can act like numbers

fromIntegral :: (Num b, Integral a) => a -> b --takes anintergral and turns it into a general number
  length :: [a] -> Int --has a type decleration of Int
-- if we try to get the length of a list and add it to 3.2 we'll get an error
solution:
  fromIntegral (length [1,2,3,4]) + 3.2

  


























--
