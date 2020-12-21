-- Inf2d Assignment 1 2017-2018
-- Matriculation number: s1864074
-- {-# OPTIONS -Wall #-}

{-# LANGUAGE BangPatterns #-}

module Inf2d1 where

import Data.List (sortBy, foldl') -- for minmax
import Data.Function (on) -- for A* search 

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

-- The Node type defines the position of the agent on the graph.
-- The Branch type synonym defines the branch of search through the graph.
type Node = Int
type Branch = [Node]
type Graph= [Node]

-- | Not used, calculated in the relevant functions
numNodes :: Int
numNodes = 4
-- 

-- The next function should return all the possible continuations of input search branch through the grid.
-- Remember that the robot can only move up, down, left and right, and can't move outside the grid.
-- The current location of the robot is the head of the input branch.
-- Your function should return an empty list if the input search branch is empty.
-- This implementation of next function does not backtrace branches.
next :: Branch -> Graph -> [Branch]
next [] _ = []            -- edge case, empty branch
next (currentNode:path) graph = [nextNode:currentNode:path | nextNode <- frontier] 
    where 
        numNodes = ceiling . sqrt . fromIntegral . length $ graph               
        -- gets row for first node in input branch
        row = [graph !! rowIndex | rowIndex <- [numNodes * currentNode..numNodes * (currentNode + 1) - 1]]   
        -- returns indexes of elements in row which are not 0
        frontier = map fst (filter ((/=0).snd) (zip [0..numNodes - 1] row)) 


-- The checkArrival function should return true if the current location of the robot is the destination, and false otherwise.
-- As Nodes are represented by 'Int', we can just check for equality
checkArrival :: Node -> Node -> Bool
checkArrival = (==)


-- | Check if a node was already visited
explored :: Node -> [Node] ->Bool
explored = elem


-- Section 3 Uninformed Search
-- | Breadth-First Search
-- The breadthFirstSearch function should use the next function to expand a node,
-- and the checkArrival function to check whether a node is a destination position.
-- The function should search nodes using a breadth first search order.
breadthFirstSearch :: Graph -> Node -> (Branch -> Graph -> [Branch]) -> [Branch]
  -> [Node] -> Maybe Branch
breadthFirstSearch [] _ _ _ _ = Nothing -- edge case, empty graph
breadthFirstSearch graph destination next frontier@(rootNodePath@(rootNode:_):_) exploredNodes 
  -- since we check for goal node when nodes are generated, 
  -- this is the edge case for when the goal node is the root node  
  | checkArrival destination rootNode = Just rootNodePath
  | otherwise = search frontier exploredNodes
    where
      -- | Function to do the breadth first search. 
      -- | Arguments: list of frontier branches to search and list of explored nodes
      -- | Returns Nothing if all nodes are explored
      -- | Returns Just b if (head b) is the goal node 
      search :: [Branch] -> [Node] -> Maybe Branch
      search [] _ = Nothing       -- base case, empty frontier
      search (currentNodePath@(currentNode:_) : restOfFrontierToBeSearch) exploredNodes
        -- if current node is already explored, skip it
        | explored currentNode exploredNodes = search restOfFrontierToBeSearch exploredNodes
        -- otherwise, generate next frontiers to be searched, and if goal node is generated,
        -- return that, else add generated next frontiers to search agenda, add current node to
        -- explored nodes and continue searching
        | otherwise = case (isGoalGenerated (next currentNodePath graph)) of 
                            Just goalNodePath -> Just goalNodePath
                            Nothing           -> search (restOfFrontierToBeSearch ++ next currentNodePath graph) 
                                                        (currentNode : exploredNodes)
          where 
            -- | Function to return goal node path if goal node is generated
            -- | Returns Nothing if goal node is not generated
            -- | Returns Just b if (head b) is the goal node 
            isGoalGenerated :: [Branch] -> Maybe Branch
            isGoalGenerated [] = Nothing
            isGoalGenerated (generatedNodePath@(generatedNode:_) : restOfGeneratedNodes)
              | checkArrival destination generatedNode = Just generatedNodePath
              | otherwise = isGoalGenerated restOfGeneratedNodes

-- | Depth-Limited Search
-- The depthLimitedSearch function is similiar to the depthFirstSearch function,
-- except its search is limited to a pre-determined depth, d, in the search tree.
depthLimitedSearch :: Graph -> Node -> (Branch -> Graph -> [Branch])
  -> [Branch] -> Int -> [Node] -> Maybe Branch
depthLimitedSearch [] _ _ _ _ _ = Nothing       -- edge case, empty graph
depthLimitedSearch graph destination next frontier maxDepth _
                                = search frontier maxDepth
  where
    -- | Function to do the depth-limited search. 
    -- | Arguments are search frontier branches and max depth
    -- | Returns Nothing if all nodes are explored (within depth limit)
    -- | Returns Just b if (head b) is the goal node 
    search :: [Branch] -> Int -> Maybe Branch
    search [] _ = Nothing       -- base case, empty frontier
    search (currentNodePath@(currentNode:_) : restOfFrontierToBeSearch) maxDepth
      -- if current node is node we're searching for, return it
      | checkArrival destination currentNode = Just currentNodePath
      -- else if we're at a level less than maxDepth and current node hasn't
      -- been explored before, expand search frontier and continue searching
      | length currentNodePath <= maxDepth && (not (dlsExplored currentNodePath)) =
          search (next currentNodePath graph ++ restOfFrontierToBeSearch) maxDepth
      -- else current node has been explored before or we're past maxDepth
      | otherwise = search restOfFrontierToBeSearch maxDepth
      where 
        -- | Function to check if node has been explored before. This is different for DLS as the explored node
        -- | are stored in the path to the current node.
        -- | Argument is a branch in the search frontier 
        -- | Returns True if first node in branch is in the rest of the branch, else False
        dlsExplored :: Branch -> Bool
        dlsExplored (b:bs) = b `elem` bs


-- | Section 4: Informed search

-- | AStar Helper Functions

-- | The cost function calculates the current cost of a trace. The cost for a single transition is given in the adjacency matrix.
-- The cost of a whole trace is the sum of all relevant transition costs.
cost :: Graph -> Branch -> Int
cost [] _ = 0     -- edge case, empty graph
-- for each edge find cost in graph matrix and then sum cost of all edges
cost graph branch = sum $ map (\(a,b) -> graph !! ((numNodes * b) + a)) edges 
  where
    edges = zip branch (tail branch)
    numNodes = ceiling . sqrt . fromIntegral . length $ graph


-- | The getHr function reads the heuristic for a node from a given heuristic table.
-- The heuristic table gives the heuristic (in this case straight line distance) and has one entry per node. It is ordered by node (e.g. the heuristic for node 0 can be found at index 0 ..)  
getHr :: [Int] -> Node -> Int
getHr = (!!)

-- | A* Search
-- The aStarSearch function uses the checkArrival function to check whether a node is a destination position,
---- and a combination of the cost and heuristic functions to determine the order in which nodes are searched.
---- Nodes with a lower heuristic value should be searched before nodes with a higher heuristic value.
aStarSearch :: Graph -> Node -> (Branch -> Graph -> [Branch]) -> ([Int] -> Node -> Int) -> [Int] ->
  (Graph -> Branch -> Int) -> [Branch] -> [Node] -> Maybe Branch
aStarSearch [] _ _ _ _ _ _ _ = Nothing  -- edge case, empty graoh
aStarSearch graph destination next getHr hrTable cost frontier exploredNodes = search frontier exploredNodes
  where
    -- | Function to do the A* search. 
    -- | Arguments are search frontier branches and list of explored nodes
    -- | Returns Nothing if all nodes are explored (within depth limit)
    -- | Returns Just b if (head b) is the goal node 
    search :: [Branch] -> [Node] -> Maybe Branch
    search [] _ = Nothing
    search frontier@(currentNodePath@(currentNode:_) : restOfFrontierToBeSearched) exploredNodes
      -- if current node is node we're searching for, return it
      | checkArrival destination currentNode = Just currentNodePath
      -- else if current frontier node has already been explored, continue searching
      | explored' currentNodePath exploredNodes = search restOfFrontierToBeSearched exploredNodes
      -- else create a new frontier (sorted by costs), add current node to explored nodes and continue searching
      | otherwise = search (generateNewFrontier frontier) (currentNode : exploredNodes)
    
    -- Since generateNewFrontier generates successor nodes to the curret node and adds them to the new frontier without 
    -- checking if the generated successor node was already in the frontier, we need modify the explored function to 
    -- check for this by checking if the first two nodes in a branch are equal.
    -- Arguments: frontier branch and list of explored nodes
    -- Returns True if first and second element of branch with two or more nodes are equal, or if first node in branch is
    -- in explored nodes
    explored' :: Branch -> [Node] -> Bool
    explored' (currentNode:previousNode:_) exploredNodes = (currentNode == previousNode) || explored currentNode exploredNodes
    explored' (b:bs) exploredNodes = explored b exploredNodes

    -- generateNewFrontier generates successor nodes to the current node and adds these nodes to the existing frontier,
    -- sorted according to the totalCostComparison function.
    -- Arguments: The previous frontier (list of Branch)
    -- Returns: Previous frontier w/ generated successor nodes, sorted according to the totalCostComparison function
    generateNewFrontier :: [Branch] -> [Branch]
    generateNewFrontier (currentFrontierBranch : restOfFrontierToBeSearched) 
                = sortBy totalCostComparison (restOfFrontierToBeSearched ++ (next currentFrontierBranch graph))

    -- Function to compare two branches on their total cost
    -- Arguements: Two branches to compare
    -- Returns Ordering based on getTotalCost
    totalCostComparison :: Branch -> Branch -> Ordering
    totalCostComparison = compare `on` getTotalCost

    -- Function that returns total cost (heuristic cost plus actual cost) of a node
    -- Arguments: Node in the form of the branch from root node to it
    -- Returns: A cost as an Int
    getTotalCost :: Branch -> Int
    getTotalCost branch = getHr hrTable (head branch) + cost graph branch


-- | Section 5: Games
-- See ConnectFour.hs for more detail on functions that might be helpful for your implementation.

-- | Section 5.1 Connect Four with a Twist

-- The function determines the score of a terminal state, assigning it a value of +1, -1 or 0:
eval :: Game -> Int
eval game
  | checkWin game humanPlayer = 1
  | checkWin game compPlayer = -1
  | otherwise = 0

-- | The alphabeta function should return the minimax value using alphabeta pruning.
-- The eval function should be used to get the value of a terminal state. 

type Bounds = (Int, Int)

-- | Min-Max bounds -- overridden on the first step of alphabeta,
-- but could be useful if later we'd like to extend the eval function
-- for example to count how quickly a state can win
bounds :: Bounds
bounds = (-1, 1)

-- alphabeta:: Role -> Game -> Int
-- alphabeta = maxValue bounds

-- maxValue :: Bounds -> Role -> Game -> Int
-- maxValue (bMin, bMax) player game
--   | terminal game = eval game
--   | otherwise = snd . foldl' (forLoopMax nextPlayer) (bounds, -1) $ movesAndTurns game player
--   where nextPlayer = switch player

-- forLoopMax :: Role -> (Bounds, Int) -> Game -> (Bounds, Int)
-- forLoopMax nextPlayer (ab@(!a,!b), !oldV) !result = if v >= b then (ab, v) else ((max a v, b), v)
--   where
--     v = max oldV (minValue ab nextPlayer result)

-- minValue :: Bounds -> Role -> Game -> Int
-- minValue (bMin, bMax) player game
--   | terminal game = eval game
--   | otherwise = snd . foldl' (forLoopMin nextPlayer) (bounds, 1) $ movesAndTurns game player
--   where nextPlayer = switch player

-- forLoopMin :: Role -> (Bounds, Int) -> Game -> (Bounds, Int)
-- forLoopMin nextPlayer (ab@(!a,!b), !oldV) !result = if v <= a then (ab, v) else ((a, min b v), v)
--   where
--     v = min oldV (maxValue ab nextPlayer result)


-- Function to perform alphabeta pruning. Alpha and beta values are initiated to -1 and 1 respectively.
alphabeta:: Role -> Game -> Int
alphabeta player game =  maxValue (-1, 1) game player 

-- Arguments: Alpha and Beta values, Game, and Player Role
maxValue :: Bounds -> Game -> Role -> Int 
maxValue ab game player 
    -- if game over, evaluate game
    | terminal game = eval game
    -- else, evaluate possible opponent moves for maxplayer with initial v of -1
    | otherwise = maxEval player  (ab, -1) (movesAndTurns game nextPlayer)
    where
      nextPlayer = switch player  

-- Function to evaluate possible opponent moves for maxplayer
maxEval :: Role -> (Bounds, Int) -> [Game] -> Int  
maxEval _ (_, v) [] = v          -- when all moves explored, return current v  
maxEval player ((alpha, beta), v) (x:xs)
    | v' >= beta = v'         -- return value v if bigger or equal to beta (pruning)
    | otherwise = maxEval player (((max alpha v'), beta), v') xs -- update alpha and recall maxEval with v' on remaining moves
    where 
      v' = max v (minValue (alpha, beta) x nextPlayer)  -- new v' is maximum gamevalue from exploring each possible opponent move
      nextPlayer = switch player  
         
minValue :: Bounds -> Game -> Role -> Int
minValue ab game player 
    | terminal game = eval game
    | otherwise = minEval player (1) ab (movesAndTurns game nextPlayer) -- call maxEval on possible opponent moves in game, initialise v as 2
    where
      nextPlayer = switch player 

-- Function to evaluate possible opponent moves for minplayer
minEval :: Role -> Int -> Bounds -> [Game] -> Int 
minEval _ v _ [] = v           -- when all moves explored, return current v 
minEval player v ab@(alpha, beta) (x:xs)
    | v' <= alpha = v'         -- return value v if smaller or equal to alpha (pruning)
    | otherwise = minEval player v' (alpha, (min beta v')) xs  -- update beta and recall minEval with v' on remaining moves
    where v' = min v (maxValue (alpha,beta) x nextPlayer)  -- new v' is minimum gamevalue from exploring each possible opponent move
          nextPlayer = switch player  










-- | OPTIONAL!
-- You can try implementing this as a test for yourself or if you find alphabeta pruning too hard.
-- If you implement minimax instead of alphabeta, the maximum points you can get is 10% instead of 15%.
-- Note, we will only grade this function IF YOUR ALPHABETA FUNCTION IS EMPTY.
-- The minimax function should return the minimax value of the state (without alphabeta pruning).
-- The eval function should be used to get the value of a terminal state.
minimax:: Role -> Game -> Int
minimax player game = undefined
{- Auxiliary Functions
-- Include any auxiliary functions you need for your algorithms below.
-- For each function, state its purpose and comment adequately.
-- Functions which increase the complexity of the algorithm will not get additional scores
-}
