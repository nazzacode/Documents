"""
LeetCode 0003(b): Longest Substring without repeating characters

Question:
Given a string s, find the length of the longest substring without repeating characters.

Example 1:
    Input: s = "abcabcbb"
    Output: 3
    Explanation: "abc" with length of 3
"""

class Solution(object):

    def lengthOfLongestSubstring(self, s: str) -> int:
        longest_substr = 0
        substr = []

        for char in list(s):
            if char in substr:
                substr = substr[substr.index(char)+1:]
            substr.append(char)
            longest_substr = max(longest_substr, len(substr))

        return longest_substr

"""
Submission:
76ms, faster than 41.04%
14.3Mb, less than 100%

Complexity Anaylsis:
- O(n^3) ?

Notes:
- more elegent to write than 0003a 
- brute force 
- much slower?
"""
