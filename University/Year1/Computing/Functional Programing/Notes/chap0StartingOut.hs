        --1. BOOLEAN ALGEBRA
  -- && means a boolean 'And'
  -- || means 'Or'
  -- 'Not' negates a True or False


      -- 2. TESTING EQUALITY
5 == 5
-> = True

7 /= 7
-> = False

      --3. FUNCTIONS
-- In Haskell functions are called by writing the function name
--a space and then the parameters, separated by spaces.
succ 8
-> 9

min 3.4 3.2 3.2
-> 3.2

-- function precedence: space then parameters is highest
-- following two statments are equal
 succ 9 + max 5 4 +1
 -> 16
(succ 9) + (max (5 4) + 1
-> 16

    -- 4. DIVISION
92 'div' 10
= 9 -- for real division use '/'

    --5. CREATING FUNCTIONS
doubleMe x = x + x
-- functions cant begin with upper case letters
-- can include comas (to denote a strict version of a function)

    --6. 'IF' (THEN< ELSE) STATMENT
doubleSmallNumber x =   if x > 100
                        then x
                        else x*2
--else part is mandatory in Haskell

    --7. LISTS
-- homogenous data structure (all intergers or all chars)
-- NOTE: let a = 1 in GHCi is equivalent to a = 1 in script.
-- a STRING is just a list of characters


    -- 7a. OPERATION LIST FUNCTION
-- ++ puts two lists together
-- : 'cons' puts a number/char at the begining of a list
  'A' : Small Cat'
  -> 'A Small Cat'
-- !! gets an element out of a lists
  "Steve Buscemi" !! 6
  -> 'B'

    --7b. BASIC LIST FUNCTIONS
-- head - takes a list and returns its head.
-- tail - takes a list and returns its tail.
-- last - takes a list and returns its last element.
-- init - takes a list and returns everything except its last element
-- length - takes a list and returns its length
-- null - checks if a list is empty
-- reverse -  reverses a list
-- take - takes number and a list extracting that many elements from the the list
  take 3 [5,4,3,2,1]
  -> [5,4,3]
-- drop - drops a number of elements from the beginning of a list
-- maximum - returns the largest element
-- minimum - returns the smallest
-- sum - returns a sum of numbers
-- product - returns a product
-- elem - takes a thing and a list of things and tells us if that thing is an element of the list
  4 'elem' [3,4,5,6] -- serach functionality
-> True

    --7c. FUNCTIONS THAT PRODUCE INFINTE LISTS
  [1...20] -- this is a range
  -> [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

  [2,4...20] -- can even make an infinite list [1,2,3...]
  -> [2,4,6,8,10,12,14,16,18,20]

          --Example: Get the first 24 multiples of 13:
    [13,26...24*13]
    take 24 [13, 26...] -- sexy way

-- cycle -  takes a list and cycles it into an infinite list
-- repeat - takes an element and produces an infinite list of just that element
  take 10 (repeat 5)
  -> [5,5,5,5,5,5,5,5,5,5]
-- replicate
  replicate 3 10
  -> [10,10,10]


    --8. LIST COMPREHENSION
-- set comprehension: defining sets by properties

    S = {2*x | x ∈ ℕ, <= 10} -- in haskell we could write;
    [x*2 | x <- [1..10]]
    [x*2 | x <- [1..10], x*2 >= 12] --you could add aditional predicates
-- underscore _ means we don't care what we draw from the lists
  length' xs = sum [1 | _ <- xs]   --will calculate the length of a lists

-- there are 3 main way we define lists,
  --1) listing
  {1,2,3,4,5,6,} // {3,4,7,8,11,12,15,16..} // {0,2,-2,4,-4,6,-6}
  --2) by predicate notation (list comprehension)
  { x | x <- [1,2,3..], x < 7}  // [ n + 3 | n <- [0..], n `mod` 4 <= 1 ] // ( 0 : concat [ [x,-x] | x <- [2,4..] ] )
    --3) by reccursion
    TBC

    --9. TUPLES
[(1,2),(8,11),(4,5)] --kind of like list of list but magnitude become its own type
("Christopher", "Walken", 55) -- triple tuple
fst --takes a par and returns its first component
snd -- take a pair and returns its second (only works on pairs)
zip -- takes two lists and zips them together into a single tuple
    zip [1 .. 10] ["one", "two", "three", "four", "five"]
    -> [(1,"one"),(2,"two"),(3,"three"),(4,"four"),(5,"five")]
-- longer list gets cut off but the machine

--Q1) which right triangle that has integers for all sides and all sides equal to or smaller than 10 has a perimeter of 24?
  let rightTriangles = [(a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a+b+c == 24]
