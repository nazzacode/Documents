-- Informatics 1 - Introduction to Computation
-- Functional Programming Tutorial 6
--
-- Week 7(29 Oct.-02 Nov.)

module Tutorial6 where

import LSystem
import Test.QuickCheck

pathExample = (Go 30 :#: Turn 120 :#: Go 30 :#: Turn 120 :#:  Go 30)

-- Exercise 1

-- 1a. split
split :: Command -> [Command]
split x = spitOn :#: . remove Sit

-- 1b. join
join :: [Command] -> Command
join = foldr (:#:) Sit

-- 1c. equivalent
equivalent :: Command -> Command -> Bool
equivalent = undefined

-- 1d. testing join and split
prop_split_join :: Command -> Bool
prop_split_join = undefinded

prop_split :: Command -> Bool
prop_split = undefined


-- Exercise 2
-- 2a. copy
copy :: Int -> Command -> Command
copy n cmd = join (replicate n cmd)

-- 2b. pentagon
pentagon :: Distance -> Command
pentagon d = copy 5 ( Go d :#: Turn 72.0)

-- 2c. polygon
polygon :: Distance -> Int -> Command
polygon d s = copy s (Go d :#: Turn (360/ fromIntergral s))



-- Exercise 3
-- 3a. spiral
spiral :: Distance -> Int -> Distance -> Angle -> Command
spiral = undefined


-- Exercise 4
-- 4a. optimise
-- Remember that Go does not take negative arguments.

optimise :: Command -> Command
optimise = undefined

-- L-Systems

-- 5a. arrowhead
arrowhead :: Int -> Command
arrowhead = undefined

--------------------------------------------------
--------------------------------------------------
---------------- Tutorial Activities -------------
--------------------------------------------------
--------------------------------------------------

-- 6. snowflake
snowflake :: Int -> Command
snowflake = undefined


-- 7. hilbert
hilbert :: Int -> Command
hilbert = undefined

--------------------------------------------------
--------------------------------------------------
---------------- Optional Material ---------------
--------------------------------------------------
--------------------------------------------------

-- Bonus L-Systems

peanoGosper = undefined


cross = undefined


branch = undefined

thirtytwo = undefined

-- main :: IO ()
-- main = display pathExample
