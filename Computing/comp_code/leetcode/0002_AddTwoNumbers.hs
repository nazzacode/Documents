
{-
LeetCode 0001: Add Two Numbers 

Question:
You are given two non-empty linked lists representing two non-negative integers.
The digits are stored in reverse order, and each of their nodes contains a single digit.
Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.
 
Example 1:
    Input: l1 = [2,4,3], l2 = [5,6,4]
    Output: [7,0,8]
    Explanation: 342 + 465 = 807.

Todo 
- [ ] remove quickcheck warning (run vim in nixshell with haskell env
- [ ] 

-}

module LeetCode0002AddTwoNumbers (addTwoNumbers) where

import Test.QuickCheck


data MyList a = Cons a (MyList a) | MyNil deriving (Show, Eq)

myHead :: MyList a -> a
myHead l = case l of Cons a _ -> a 

myTail :: MyList a -> MyList a  
myTail MyNil = MyNil
myTail l = case l of Cons _ a -> a 

myInsert :: a -> MyList a -> MyList a
myInsert x xs = Cons

-- Solution 
addTwoNumbers :: (Num a, Ord a) => MyList a -> MyList a -> MyList a
addTwoNumbers MyNil l2 = l2
addTwoNumbers l1 MyNil = l1
addTwoNumbers l1 l2
  | val < 10  = myInsert val (addTwoNumbers (myTail l1) (myTail l2))
  | otherwise = myInsert (val-10) (addTwoNumbers (Cons 1 MyNil) (addTwoNumbers (myTail l1) (myTail l2)))
    where val = myHead l1 + myHead l2


-- Testing
prop_01 = addTwoNumbers (Cons 1 MyNil) (Cons 1 MyNil) == Cons 2 MyNil
prop_02 = addTwoNumbers (Cons 1 (Cons 3 MyNil)) (Cons 7 MyNil) == Cons 8 (Cons 3 MyNil)
prop_03 = addTwoNumbers (Cons 4 (Cons 5 MyNil)) (Cons 0 (Cons 0 (Cons 1 MyNil))) == Cons 4 (Cons 5 (Cons 1 MyNil))
prop_04 = addTwoNumbers (Cons 3 (Cons 1 (Cons 6 MyNil))) (Cons 4 (Cons 7 (Cons 9 MyNil))) == Cons 7 (Cons 8 (Cons 5 (Cons 1 MyNil)))
-- NOTE: do with a fromList constructor function to save space 

--  Analysis:
-- O(max(m,n))  
--   where m,n are the lengths of the lists 
-- justification: the algorithm has at most (max m n) recursive calls (plus singleton?)    
