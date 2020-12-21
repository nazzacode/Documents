-- Inf2d Assignment 1 2019-2020
-- Matriculation number: s1870142
-- {-# OPTIONS -Wall #-}

module Inf2d1 where

import Data.List (sortBy, elemIndices, elemIndex, sortOn)
import ConnectFourWithTwist





{- NOTES:

-- DO NOT CHANGE THE NAMES OR TYPE DEFINITIONS OF THE FUNCTIONS!
You can write new auxillary functions, but don't change the names or type definitions
of the functions which you are asked to implement.

-- Comment your code.

-- You should submit this file when you have finished the assignment.

-- The deadline is the  10th March 2020 at 3pm.

-- See the assignment sheet and document files for more information on the predefined game functions.

-- See the README for description of a user interface to test your code.

-- See www.haskell.org for haskell revision.

-- Useful haskell topics, which you should revise:
-- Recursion
-- The Maybe monad
-- Higher-order functions
-- List processing functions: map, fold, filter, sortBy ...

-- See Russell and Norvig Chapters 3 for search algorithms,
-- and Chapter 5 for game search algorithms.

-}

-- Section 1: Uniform Search

-- 6 x 6 grid search states

-- The Node type defines the position of the robot on the grid.
-- The Branch type synonym defines the branch of search through the grid.
type Node = Int
type Branch = [Node]
type Graph= [Node]

-- not used, calculated within the functions
numNodes::Int
numNodes = 4



-- 


-- The next function should return all the possible continuations of input search branch through the grid.
-- Remember that the robot can only move up, down, left and right, and can't move outside the grid.
-- The current location of the robot is the head of the input branch.
-- Your function should return an empty list if the input search branch is empty.
-- This implementation of next function does not backtrace branches.

next :: Branch -> Graph -> [Branch]
next [] _ = []            -- edge case empty list
next (x:xs) g = [y:x:xs | y<- frontier]       -- construct frontier with next available paths
    where 
        n = ceiling . sqrt . fromIntegral . length $ g                --find number of nodes in graph
        row = [g !! i|i<- [n*x..n*(x+1)-1]]                           -- sections off corresponding row for first node in input branch
        frontier = map (fst) (filter ((/=0).snd)(zip [0..n-1] row))   -- gives index of each element in row which is not 0
      

-- |The checkArrival function should return true if the current location of the robot is the destination, and false otherwise.
checkArrival::Node -> Node -> Bool
checkArrival = (==)


explored::Node-> [Node] ->Bool
explored = elem

-- Section 3 Uninformed Search
-- | Breadth-First Search
-- The breadthFirstSearch function should use the next function to expand a node,
-- and the checkArrival function to check whether a node is a destination position.
-- The function should search nodes using a breadth first search order.

breadthFirstSearch::Graph -> Node -> (Branch -> Graph -> [Branch]) -> [Branch] -> [Node] -> Maybe Branch
breadthFirstSearch [] _ _ _ _ = Nothing -- edge case empty graph
breadthFirstSearch _ _ _ [] _ = Nothing -- edge case empty branches


breadthFirstSearch g destination next (b:bs) exploredList   --branches argument renamed as (b:bs)
    | checkArrival destination (head b) = Just b            --checks if start node is goal
    | not (null solution)  = Just (head solution)           -- if solution solution found, return first solution

    -- if solution empty recall breadthfirst on updated frontier (FIFO) with updated exploredList
    | otherwise = breadthFirstSearch g destination next (bs++childrenBranches) (exploredList++children)  
            where 
                  childrenBranches = filter (\(x:xs) -> not $ explored x exploredList) (next b g)  -- generates unexplored children to first branch in frontier
                  solution = filter (\(x:xs) -> checkArrival destination x) childrenBranches -- checks if any of children generated is solution
                  children = map (\(x:xs)->x) childrenBranches  --gets children nodes, without path to append to exploredList




-- | Depth-Limited Search
-- The depthLimitedSearch function is similiar to the depthFirstSearch function,
-- except its search is limited to a pre-determined depth, d, in the search tree.
depthLimitedSearch::Graph ->Node->(Branch -> Graph -> [Branch]) -> [Branch] -> Int -> [Node] -> Maybe Branch
depthLimitedSearch [] _ _ _ _ _ = Nothing --edge case empty graph
depthLimitedSearch _ _ _ [] _ _= Nothing  --edge case empty branches

depthLimitedSearch g destination next (b:bs) d exploredList   --branches arg renamed as (b:bs)
    | checkArrival destination (head b) = Just b              --if current node destination, return path

    -- if past depth limit explore frontier for others within depth limit
    | length b > d = depthLimitedSearch g destination next bs d (drop 2 exploredList) 
    | otherwise = depthLimitedSearch g destination next (childrenBranches ++ bs) d ((head b) : exploredList)  -- recall BF on updated frontier (LIFO), exploredList
    where 
        childrenBranches = filter (\(x:xs) -> not $ explored x ((head b): exploredList )) (next b g)  -- generates unexplored children to first branch in frontier


-- | Section 4: Informed search


-- | AStar Helper Functions

-- | The cost function calculates the current cost of a trace. The cost for a single transition is given in the adjacency matrix.
-- The cost of a whole trace is the sum of all relevant transition costs.
cost :: Graph ->Branch  -> Int
cost [] _ = 0 --edge case empty graph
cost g branch =  sum $ map (\(a,b)-> g !! ((n*b) + a)) edges -- for each edge find cost in graph matrix, sum cost of all edges

    where
        n = ceiling . sqrt . fromIntegral . length $ g  -- number of nodes in graph 
        edges = zip (init branch) (tail branch)         -- list of tuples for each adjacent pair of nodes in branch
        
        

      
    
-- | The getHr function reads the heuristic for a node from a given heuristic table.
-- The heuristic table gives the heuristic (in this case straight line distance) and has one entry per node. It is ordered by node (e.g. the heuristic for node 0 can be found at index 0 ..)  
getHr :: [Int] -> Node -> Int
getHr = (!!) 


-- | A* Search
-- The aStarSearch function uses the checkArrival function to check whether a node is a destination position,
---- and a combination of the cost and heuristic functions to determine the order in which nodes are searched.
---- Nodes with a lower heuristic value should be searched before nodes with a higher heuristic value.


aStarSearch::Graph -> Node -> (Branch -> Graph -> [Branch]) -> ([Int] -> Node -> Int) -> [Int] -> (Graph -> Branch -> Int) -> [Branch] -> [Node]-> Maybe Branch
aStarSearch [] _ _ _ _ _ _ _ = Nothing  -- edge case empty graoh
aStarSearch _ _ _ _ _ _ [] _ = Nothing  -- edge case empty branches
aStarSearch g destination next getHr hrTable cost (b:bs) exploredList   -- branches argument renamed as (b:bs)
    | checkArrival destination (head b) = Just b                        -- if current node destination, return path
    | otherwise = aStarSearch g destination next getHr hrTable cost priorityQueue ((head b):exploredList) -- recurse with ordered frontier and updated exploredList
    where 
        childrenBranches = filter (\(x:xs) -> not $ explored x exploredList) (next b g)  -- generates unexplored children to first branch in frontier
        priorityQueue = sortOn (\branch@(b:bs) -> (getHr hrTable b) + (cost g branch) ) (childrenBranches ++ bs) -- sorts frontier according to path cost and heuristic 



-- | Section 5: Games
-- See ConnectFour.hs for more detail on  functions that might be helpful for your implementation. 



-- | Section 5.1 Connect Four with a Twist

 

-- The function determines the score of a terminal state, assigning it a value of +1, -1 or 0:
eval :: Game -> Int
eval game  
    | checkWin game maxPlayer = 1
    | checkWin game minPlayer = -1
    | otherwise = 0







-- | The alphabeta function should return the minimax value using alphabeta pruning.
-- The eval function should be used to get the value of a terminal state. 

alphabeta:: Role -> Game -> Int
alphabeta  player game =  maxValue (-2) (2) game player  -- initiate maxValue with alpha beta values
    where
        maxValue :: Int -> Int -> Game -> Role -> Int 
        maxValue alpha beta game player 
            | terminal game = eval game
            | otherwise = maxEval (-2) alpha beta (movesAndTurns game (switch player)) -- call maxEval on possible opponent moves in game, initialise v as -2
            where
                -- evaluates possible opponent moves for maxplayer
                maxEval :: Int -> Int -> Int -> [Game] -> Int  
                maxEval v _ _ [] = v          -- when all moves explored, return current v  
                maxEval v alpha beta (x:xs)
                    | v' >= beta = v'         -- return value v if bigger or equal to beta (pruning)
                    | otherwise = maxEval v' (max alpha v') beta xs -- update alpha and recall maxEval with v' on remaining moves
                    where v' = max v (minValue alpha beta x (switch player))  -- new v' is maximum gamevalue from exploring each possible opponent move

        minValue :: Int -> Int -> Game -> Role -> Int
        minValue alpha beta game player 
            | terminal game = eval game
            | otherwise = minEval (2) alpha beta (movesAndTurns game (switch player)) -- call maxEval on possible opponent moves in game, initialise v as 2
            where 
                -- evaluates possible opponent moves for minplayer
                minEval :: Int -> Int -> Int -> [Game] -> Int 
                minEval v _ _ [] = v           -- when all moves explored, return current v 
                minEval v alpha beta (x:xs)
                    | v' <= alpha = v'         -- return value v if smaller or equal to alpha (pruning)
                    | otherwise = minEval v' alpha (min beta v') xs  -- update beta and recall minEval with v' on remaining moves
                    where v' = min v (maxValue alpha beta x (switch player))  -- new v' is minimum gamevalue from exploring each possible opponent move






-- | OPTIONAL!
-- You can try implementing this as a test for yourself or if you find alphabeta pruning too hard.
-- If you implement minimax instead of alphabeta, the maximum points you can get is 10% instead of 15%.
-- Note, we will only grade this function IF YOUR ALPHABETA FUNCTION IS EMPTY.
-- The minimax function should return the minimax value of the state (without alphabeta pruning).
-- The eval function should be used to get the value of a terminal state.
minimax:: Role -> Game -> Int
minimax player game=undefined



{- Auxiliary Functions
-- Include any auxiliary functions you need for your algorithms below.
-- For each function, state its purpose and comment adequately.
-- Functions which increase the complexity of the algorithm will not get additional scores
-}
