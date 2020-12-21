module CL2 where
import Test.QuickCheck.Modifiers -- such as Positive and NonNegative
import Test.QuickCheck

type Next state symbol =         -- transition function for a DFA
  state -> symbol -> state
type DFA state symbol = (        -- names as in tex Mathematical Methods for Linguistics
    [state]            -- k 
  , [symbol]           -- sigma 
  ,  state             -- q0 
  , Next state symbol  -- delta 
  , state -> Bool      -- f (accepting?)
  )
final :: DFA st sy ->  st -> [sy] -> st -- given dfa initial state and inputs
final dfa                 s  []    = s  -- where do we end up
final dfa@(_,_,_,delta,_) s (x:xs) = final dfa (delta s x) xs

accept :: DFA state symbol -> [symbol] -> Bool -- starting from start state do
accept dfa@(_, _, q0, _, f) xs = f (final dfa q0 xs) -- we reach an accepting state

basebmodm :: Int -> Int        -- modulus m and base b
  -> DFA Int Int               -- accepts strings base b encoding 
basebmodm m b = (              -- a multiple of m
    [0..(m-1)]  -- states
  , [0..(b-1)]  -- symbols 
  , 0           -- start at 0 
  , delta       -- see below 
  , (==0)       -- accepts 0
  ) where
  delta st sy = 
    (b*st + sy) `mod` m

prodDFA :: Eq sy => DFA st sy -> DFA st' sy -> DFA (st, st') sy
prodDFA (k,  sigma,  q0,  delta,  f)      -- the product of two DFA
        (k', sigma', q0', delta', f') =   -- recognises strings accepted
  if sigma /= sigma' then undefined else  -- by both of them
    (
      [(x,x') | x <- k, x' <- k']
    , sigma
    , (q0, q0')
    , delta''
    , f''
    )where
      delta'' (x, x') s = (delta x s, delta' x' s)
      f'' (q, q') = (f q) && (f' q')

