"""
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
"""

class Solution:
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

"""
Submission:
36ms, faster than 99.93%
14.3Mb, less than 51.39%

Complexity Anaylsis:
- O(n)
"""

