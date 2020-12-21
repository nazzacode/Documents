-- Inf2d Assignment 1
-- Matriculation number: s1869292
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
type Graph = [Node]

-- not used, calculated within the functions
--numNodes::Int
--numNodes = 4

-- The next function should return all the possible continuations of input search branch through the grid.
-- Remember that the robot can only move up, down, left and right, and can't move outside the grid.
-- The current location of the robot is the head of the input branch.
-- Your function should return an empty list if the input search branch is empty.
-- This implementation of next function does not backtrace branches.


-- getNumNodes returns the number of nodes in the graph
getNumNodes :: Graph -> Int
getNumNodes = ceiling . sqrt . fromIntegral . length  -- sqrt size of adj matrix


-- returns all possible contiuations of input search branch
next :: Branch -> Graph -> [Branch]
next [] _ = []
next (x:xs) graph = [ y:x:xs | y <- frontier ]  -- construct frontier with next available paths
    where
        frontier = map fst $ filter ((/=0).snd) (zip [0..] nodeRow)
        nodeRow = take n . drop (n*x) $ graph
        n = getNumNodes graph

-- |The checkArrival function should return true if the current location of the robot is the destination, and false otherwise.
checkArrival :: Node -> Node -> Bool
checkArrival = (==)

-- returns true if node is already explored
explored :: Node-> [Node] -> Bool
explored = elem

-- Section 3 Uninformed Search
-- | Breadth-First Search
-- The breadthFirstSearch function should use the next function to expand a node,
-- and the checkArrival function to check whether a node is a destination position.
-- The function should search nodes using a breadth first search order.
-- BFSInternal perfoms the search on a branch
breadthFirstSearch :: Graph -> Node -> (Branch -> Graph -> [Branch]) -> [Branch] -> [Node] -> Maybe Branch
breadthFirstSearch [] _ _ _ _ = Nothing  -- edge case of empty graph 
breadthFirstSearch graph goal next frontier exploredNodes = searchBranch frontier exploredNodes
    where
        searchBranch :: [Branch] -> [Node] -> Maybe Branch
        searchBranch [] _ = Nothing
        searchBranch (firstOfFrontier:restOfFrontier) exploredNodes
            | isSolution firstOfFrontier = Just firstOfFrontier
            | explored (head firstOfFrontier) exploredNodes = searchBranch restOfFrontier exploredNodes
            | otherwise = case isChildGoal (next firstOfFrontier graph) of
                Just child -> Just child
                Nothing -> searchBranch (restOfFrontier ++ next firstOfFrontier graph) (head firstOfFrontier : exploredNodes)
        -- checks if children are goal node (before expanding futher)
        isChildGoal :: [Branch] -> Maybe Branch
        isChildGoal [] = Nothing
        isChildGoal (child:restOfChildren)
            | isSolution child = Just child
            | otherwise = isChildGoal restOfChildren
        -- performs BFS on a branch
        -- Checks if a branch is a solution
        isSolution :: Branch -> Bool
        isSolution = checkArrival goal . head


-- | Depth-Limited Search
-- The depthLimitedSearch function is similiar to the depthFirstSearch function,
-- except its search is limited to a pre-determined depth, d, in the search tree.
depthLimitedSearch :: Graph -> Node -> (Branch -> Graph -> [Branch]) -> [Branch] -> Int -> [Node] -> Maybe Branch
depthLimitedSearch [] _ _ _ _ _ = Nothing  -- edge case of empty graph 
depthLimitedSearch graph goal next frontier maxDepth exploredNodes = searchBranch frontier maxDepth
  where
    -- performs DLS on a branch
    searchBranch :: [Branch] -> Int -> Maybe Branch
    searchBranch [] _  = Nothing
    searchBranch (firstOfFrontier:restOfFrontier) maxDepth
      | isSolution firstOfFrontier = Just firstOfFrontier
      | length firstOfFrontier <= maxDepth && not (explored (head firstOfFrontier) (tail firstOfFrontier)) =
          searchBranch (next firstOfFrontier graph ++ restOfFrontier) maxDepth
      | otherwise = searchBranch restOfFrontier maxDepth
    isSolution :: Branch -> Bool
    isSolution = checkArrival goal . head


-- | Section 4: Informed search


-- | AStar Helper Functions

-- | The cost function calculates the current cost of a trace. The cost for a single transition is given in the adjacency matrix.
-- The cost of a whole trace is the sum of all relevant transition costs.
cost :: Graph -> Branch  -> Int
cost [] _ = 0  -- edge case empty graph
cost graph branch =  sum $ map (\(a,b) -> graph !! ((getNumNodes graph *b) + a)) edges
    where
        edges = zip (init branch) (tail branch)



-- | The getHr function reads the heuristic for a node from a given heuristic table.
-- The heuristic table gives the heuristic (in this case straight line distance) and has one entry per node. It is ordered by node (e.g. the heuristic for node 0 can be found at index 0 ..)  
getHr :: [Int] -> Node -> Int
getHr = (!!)


-- | A* Search
-- The aStarSearch function uses the checkArrival function to check whether a node is a destination position,
---- and a combination of the cost and heuristic functions to determine the order in which nodes are searched.
---- Nodes with a lower heuristic value should be searched before nodes with a higher heuristic value.
aStarSearch::Graph -> Node -> (Branch -> Graph -> [Branch]) -> ([Int] -> Node -> Int) -> [Int] -> (Graph -> Branch -> Int) -> [Branch] -> [Node] -> Maybe Branch
aStarSearch [] _ _ _ _ _ _ _ = Nothing  -- empty graph
aStarSearch _ _ _ _ _ _ [] _ = Nothing  -- empty branches (no solution)
aStarSearch graph goal next getHr hrTable cost frontier@(firstOfFrontier:restOfFrontier) exploredNodes
    | isSolution firstOfFrontier = Just firstOfFrontier
    -- recursive call to A* with updated & ordered frontier and explored node list
    | otherwise = aStarSearch graph goal next getHr hrTable cost orderedFrontier updatedExploredNodes
        where
            isSolution :: Branch -> Bool
            isSolution = checkArrival goal . head
            -- sorts frontier according to evaluation funtion
            orderedFrontier = sortOn evalFunction (expandedFrontier ++ restOfFrontier)
            -- combination of cost and heuristic
            evalFunction frontier@(firstOfFrontier:restOfFrontier) = (cost graph frontier) + (getHr hrTable firstOfFrontier)
            -- generates children of first element in frontier
            -- and checks if they are already explored
            expandedFrontier = filter (\(node:nodes) -> not $ explored node exploredNodes) (next firstOfFrontier graph)
            -- completes the search and adds the node to the list of explored nodes
            updatedExploredNodes = (head firstOfFrontier : exploredNodes)


-- | Section 5: Gamess
-- See ConnectFour.hs for more detail on  functions that might be helpful for your implementation. 

-- | Section 5.1 Connect Four with a Twist

-- The function determines the score of a terminal state, assigning it a value of +1, -1 or 0:
eval :: Game -> Int
eval game
  | checkWin game maxPlayer = 1
  | checkWin game minPlayer = -1
  | otherwise = 0
  
type Bounds = (Int, Int)

-- min/max bounds
bounds :: Bounds
bounds = (-1, 1)

-- | Funtion to perform minimax generation using alphabeta pruning
-- Arguments: player role, game
-- Returns: the minimax value using alphabeta pruning
alphabeta :: Role -> Game -> Int
alphabeta 0 = minValue bounds 0
alphabeta 1 = maxValue bounds 1


-- | Funtion to find min value in search tree
-- Arguments: Alpha & Beta values, player role, game
-- Return: evaluation value if we reached a terminal state
minValue :: Bounds -> Role -> Game -> Int
minValue bounds playerRole game
    | terminal game = eval game
    | otherwise = searchForMin bounds playerRole (movesAndTurns game playerRole) (snd bounds)


-- | Funtion to find max value in search tree
-- Arguments: Alpha & Beta bounds, player role, game
-- Return: evaluation value if we reached a terminal state
maxValue :: Bounds -> Role -> Game -> Int
maxValue bounds playerRole game
    | terminal game = eval game
    | otherwise = searchForMax bounds playerRole (movesAndTurns game playerRole) (fst bounds)

 
-- | Function to recursivly search through the tree to find  max value
-- Arguments: alpha & beta bounds, player role, game tree, current max value 
-- Returns: max value in tree
searchForMax ::  Bounds -> Role -> [Game] -> Int -> Int
searchForMax _ _ [] maxVal = maxVal  -- edge case: empty game
searchForMax (alpha,beta) playerRole (game:games) currMaxVal
    | (newVal >= beta) = newVal
    | otherwise = searchForMax ((max alpha newVal), beta) playerRole games newVal
    where
        newVal = max currMaxVal $ minValue (alpha,beta) (switch playerRole) game


-- | Function to recursivly search through the tree to find min value
-- | (alpha, beta) bounds for the pruning. Also takes the current v value
-- | Returns the new v value if lower than the lower bound
-- | Keeps looping with updated upper bound otherwise.
searchForMin :: Bounds -> Role -> [Game] ->  Int -> Int
searchForMin _ _ [] maxVal = maxVal -- edge case: empty game
searchForMin (alpha,beta) playerRole (game:games) currMaxVal
    | (newVal <= alpha) = newVal
    | otherwise = searchForMin (alpha, (min beta newVal)) playerRole games newVal
    where
        newVal = min currMaxVal $ maxValue (alpha,beta) (switch playerRole) game
