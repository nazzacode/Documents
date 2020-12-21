module CL3 where
import Test.QuickCheck

f::Bool->Bool->Bool->Bool -> Bool
f p q r s = (p||q) && not(r||s)
-- test this with quickCheck
notf p q r s = not (f p q r s)

ff a b c d e v w x y z =
  or [a,b,c,d,e] || or (map not [v,w,x,y,z])
-- test this with quickCheck

-- try more tests
-- quickCheck (withMaxSuccess 1000 ff)

gg a b c d e f g h i j k l m n o p q r s t u v w x y z =
  or [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]
-- you should be able to find a counterexample
-- but quickCheck is unlikely to help you!

taut1 f = f True && f False                  -- for functions with one argument
taut2 f = taut1 (f True) && taut1 (f False)  -- for functions with two arguments
taut3 f = taut2 (f True) && taut2 (f False)  -- for functions with three arguments
taut4 f = taut3 (f True) && taut3 (f False)  -- for functions with four arguments

-- we cannot define the function attempted below because the types of taut1 ... taut4 are incompatible
-- taut 1 f = taut1 f
-- taut n f = taut (n-1) f False && taut (n-1) f True

-- use km and or taut4 to check the Boolean algebra equations
-- the first example has been implemented for you.
associative  a g r b  = (a || (g || r)) == ((a || g) || r)
                        &&
                        (a && (g && r)) == ((a && g) && r)
distributive a g r b = undefined
commutative a g r b  = undefined
identity a g r b     = undefined
annihilation a g r b = undefined
idempotent a g r b   = undefined
complements a g r b  = undefined
absorbtion a g r b   = undefined
deMorgan a g r b     = undefined
negation a g r b     = undefined

-- code below here draws a Karnaugh map
km :: (Bool -> Bool -> Bool -> Bool -> Bool) -> IO ()
km bf =
  let
    g2 = grey 2
    f [a,g,r,b] = fort(bf a g r b)
    header = "  " : "|" : map (concatMap show) g2
    codes = map (\x -> (concatMap show x) :"|" : (map (f.map(1==).(++x)) g2)) g2
    table = header : map dash header :codes
  in
   showTable table
  where

    grey :: Int -> [[Int]] -- grey n gives n-bit grey code        
    grey 0 = [[]]
    grey n = [ 0 : x | x <- xs] ++ [ 1 : x | x <- reverse xs]
      where xs = grey (n-1)

    -- centre a string in a field of a given width
    centre :: Int -> String -> String
    centre w s  =  replicate h ' ' ++ s ++ replicate (w-n-h) ' '
            where
            n = length s
            h = (w - n) `div` 2

    -- make a string of dashes as long as the given string
    dash :: String -> String
    dash s  =  replicate (length s) '-'

    -- convert boolean to 1 (True) or 0 (False)
    fort :: Bool -> String
    fort False  =  " 0"
    fort True   =  " 1"
    -- print a table with columns neatly centred
    -- assumes that strings in first row are longer than any others
    showTable :: [[String]] -> IO ()
    showTable tab  =  putStrLn (
      unlines [ unwords (zipWith centre widths row) | row <- tab ] )
      where
        widths  = map length (head tab)

