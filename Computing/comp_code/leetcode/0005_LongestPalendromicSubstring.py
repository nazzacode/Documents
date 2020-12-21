"""
Leetocode 0005: Longest Palindromic Substring 
Given a string s, find the longest palindromic substring in s.

Example:
Input: "babad"
Output: "bab"
Note, "aba" is alo a valid answer
"""

class Solution:
    def longestPalindrome(self, s: str) -> str:
        substr = ""
        i = j = 0
        while j <= len(s):
            if Solution.is_palindrome(s[i:j]):
                substr = s[i:j]
            elif Solution.is_palindrome(s[i-1:j]) and i >=1:    
                substr = s[i-1:j]
                i -= 1
            else:
                i += 1
            j +=1

        return substr


    def is_palindrome(s: str) -> bool:
        return s == s[::-1]

"""
Submission:
100ms, faster than 97.43%
14.2Mb, less than 9.77%

Complexity Anaylsis:
- O(n^2)
- can be done in O(n) with manachers algorithm
Notes:
"""

