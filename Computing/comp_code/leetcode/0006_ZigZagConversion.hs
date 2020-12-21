{-
Leetocode 0006: The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

P   A   H   N
A P L S I I G
Y   I   R
And then read line by line: "PAHNAPLSIIGYIR"

Write the code that will take a string and make this conversion given a number of rows:


Example:
Input: s = "PAYPALISHIRING", numRows = 4
Output: "PINALSIGYAHRPI"
Explanation:
P     I    N
A   L S  I G
Y A   H R
P     I
-}

module LeetCode0006ZigZagConversion (zigZagConvert) where

import Test.QuickCheck

-- incomplete, return to later
zigZagConvert :: [Char] -> Int -> [Char]
zigZagConvert xs numRows = map snd 
     $ take len 
     $ filter (\(y,z) -> ((y `mod` cycleLen) + (offset * y `div` len) == 0))
     $ cycle 
     $ zip [0..] xs
  where 
    row = len `mod` y
    
    len = length xs
    cycleLen = 2 * numRows - 2
    offset = len `mod` cycleLen
    trueIndex = 


{- class Solution:
    def zigZagConvert(self, s: str, numRows : int) -> str:
        if numRows == 1: return s
        line = 0
        direction = 1  # 1 -> down, -1 -> up 
        output = [""] * numRows
        for char in s:
            output[line] += char
            line += direction
            if line == 0 or line == (numRows-1):
                direction *= -1  # bit flip

        flatOutput = ""
        flatOutput = flatOutput.join([st for st in output])

        return flatOutput
-}

{- 
Complexity Anaylsis:
- O(n)
-}