"""
implement 'atoi' which converts a string to an integer

this finction first discareds as many whitespace characters as necesssary until
the first non-whitespace character is found. Then, starting from this character,
takes an optional initial plus of minus sign, followed by as many numerical
digits as possible, and interprets them as a numerical value.

If the first sequence of non-whitespace characters in str is not a valid
integral number, or if no such sequence exists because either str is empty or
it contains only whitespace characters, no conversions is performed.

If no valid conversion is performed, a zero value is returned

Example
Input
"words and 987"
Output
0
-> the first non-whitespace character is 'w' whichis non-numerical

Input
"  -42"
Output
-42
"""

class Solution(object):
    def myAtoi(self, s):
        """
        :type s: str
        :rtype: int
        """
        ls = list(s.strip())
        if len(ls) == 0 : return 0

        sign = -1 if ls[0] == '-' else 1
        if ls[0] in ['-','+'] : del ls[0]
        ret, i = 0,0
        while i < len(ls) and ls[i].isdigit():
            ret = ret*10 + ord(ls[i]) - ord('0')
            i += 1
        return sign*ret



