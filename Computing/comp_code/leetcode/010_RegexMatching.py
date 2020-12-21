"""
REGEX NOTES
- regex matches patterns
- kind of a language
- uppercase often negates search

\d      - diget (0-9)
\D      - not a diget
\w      - word char (a-z, A-Z, 0,9)
\W      - not a word
\s      - whitespace
\S      - not whitespace

ANCHORS: (match invisible positions between words)
\b      - word boundery
\B      - not word boundry
^       - beginning of string
$       - End of string

[]      - char set
[^]     - not in brackets
|       - either ir
()      - group

QUANTIFIERS:
*       - 0 or more
+       - 1 or more
?       - 0 or 1
{3}     - exact number
{3,4}   - range of numbers (min,max)
"""

"""
Questions
Given an input string (s) and a pattern (p) implement regular expression matching with support for '.' and '*', where;
'.' matches any single character
'*' matches zero or more of the preceding element

Example
Input
s = "aa"
p = "a*"
Output
True

Input
s = "aab"
p "c*a*b"
Output
True
"""
import string

class Solution(object):
    def isMatch(self, text, pattern):
        """
        :type s: str
        :type p: str
        :rtype bool
        """
        if not pattern:
            return not text

        first_char_match = bool(text) and pattern[0] in {text[0], "."}

        if len(pattern) >= 2 and pattern[1]=='*':
            return (self.isMatch(test, pattern[2:]) or
                    first_char_match and self.isMatch(test[1:], pattern))
        else:
            return first_char_match and self.isMatch(text[1:], pattern[1:])

