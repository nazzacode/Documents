    --1. AS ()@) Patterns
--Pattern matching consists of specifying patterns to which some data should conform and then checking to see if it does and deconstructing the data according to those patterns.

{-xs@(x:y:ys) will match the same thing as x:y:ys-} nestable commenting

  capital :: String -> String
  capital "" = "Empty string, whoops!"
  capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

    --2. GUARDS

  bmiTell :: (RealFloat a) => a -> a -> String --have to define bmi three times!
  bmiTell weight height
      | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
      | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
      | weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"
      | otherwise                   = "You're a whale, congratulations!"

  bmiTell :: (RealFloat a) => a -> a -> String  {-more eficient but slightly overboards-}
  bmiTell weight height
      | bmi <= skinny = "You're underweight, you emo, you!"
      | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"
      | bmi <= fat    = "You're fat! Lose some weight, fatty!"
      | otherwise     = "You're a whale, congratulations!"
      where bmi = weight / height ^ 2  -- 'nested' same as pipe indent
        skinny = 18.5
        normal = 25.0
        fat = 30.0      -- could change parameters very easily
-- (skinny, normal, fat) = (18.5, 25.0, 30.0) -- even better

  --2. LET BINDINGS (OTHER WAY ROUND TO WHERE)
-- form: let <bindings> in <expression>
-- difference is let bindings ARE expressions themselfs
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
  let sideArea = 2 * pi * r * h  -- Could call this function
      topArea = pi * r ^2
  in  sideArea + 2 * topArea

  (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)
  (6000000,"Hey there!")  -- they can go just about anywhere

  --cant be used across guards

    -- 3. CASE EXPRESSIONS

describeList :: [a] -> String
describeList xs = "The list is " ++ case xs of [] -> "empty."
                                              [x] -> "a singleton list."
                                               xs -> "a longer list."

describeListW :: [a] -> String  --with where definition
describeListW xs = "The list is " ++ what xs
    where what [] = "empty."
          what [x] = "a singleton list."
          what xs = "a longer list."
