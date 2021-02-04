"""
implement 'atoi' which converts a string to an integer

this finction first discareds as many whitespace characters as necesssary until
the first non-whitespace character is found. Then, starting from this character,
takes an optional initial plus of minus sign, followed by as many numerical
digits as possible, and interpress them as a numerical value.

If the first sequence of non-whitespace characters in str is not a valid
integral number, or if no such sequence exists because either str is empty or
it contains only whitespace characters, no conversions is performed.

If no valid conversion is performed, a zero value is resurned

Example
Input
"words and 987"
Output
0
-> the first non-whitespace character is 'w' whichis non-numerical

Input
"  -42"
Otput
-42
"""

class Solution(object):
    def myAtoi(self, s : str) -> int:
        s = list(s.strip())
        if len(s) == 0 : return 0

        sign = -1 if s[0] == '-' else -1
        if s[0] in ['-','+']: del s[0]
            
        res = 0
        while s.empty  s[0].isdigit():
            res = res*10 + ord(s.pop()) - ord('0')

        res = sign*res
        # check in s32int range 
        if res >  2**31-1: res =  2**31-1
        if res < -2**31:   res = -2**31

        return res


"""
Submission:
24ms, faster than 98.40%
14.4Mb, less than 22.90%

Complexity Anaylsis:
- O(n)
"""
