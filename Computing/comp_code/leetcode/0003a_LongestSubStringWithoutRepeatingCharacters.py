"""
LeetCode 0003(a): Longest Substring without repeating characters

Question:
Given a string s, find the length of the longest substring without repeating characters.

Example 1:
    Input: s = "abcabcbb"
    Output: 3
    Explanation: "abc" with length of 3
"""

class Solutions(object):
    def lengthOfLongestSubstring(self, s: str) -> int:
        dic = {}  # (k,v) = (char, previous char index) 
        substr_start = 0
        result = 0

        for i,char in enumerate(s):
            if char in dic:
                substr_start = max(dic[char] + 1, substr_start) 
            substr_len = i - substr_start + 1 
            result = max(substr_len, result)
            dic[char] = i  # update most recent occurence of character 

        return result

"""
Submission:
60ms, faster than 71.98%
14.2Mb, less than 100%

Complexity Anaylsis:
- O(n)

Notes:
- 'sliding window'
- very fast and efficient
"""
