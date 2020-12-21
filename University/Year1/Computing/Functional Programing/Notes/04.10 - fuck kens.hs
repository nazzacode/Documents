enumFrom :: Int -> [Int]
enumFrom ::
INCOMPLETE

# Zipfunction pairs up elements of lits and turns them into pairs

zip :: [a] -> [b] -> [(a,b)]
zip [] ys           = []
zip xs []           = []
zip (x:xs)  (y:ys)  = (x,y)INCOMPLETE

zip "abc" [0,1,2]


# Dot Product
# given two lists of numer it returns a number

dot :: Num a => [a] -> INCOMPLETE

# search
# fins all the places a certain thing appears in a list
