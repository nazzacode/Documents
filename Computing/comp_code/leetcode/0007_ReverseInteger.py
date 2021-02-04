"""
Leetocode 0006: Given a 32-bit signed integer, reverse the digits of the integer 

Example:
Input: x = 123
Output: 321

Input: x = -123
Output: -321
"""

class Solution:
    def reverse(self, x : int) -> int:
        sign = 1 if x > 0 else -1
        result = 0
        while x != 0: 
            result = 10 * result + x % 10 
            x = int(x / 10)

        if result < -2**31 or result > 2**31-1:
            return 0

        return sign*result

"""
Submission:
36ms, faster than 22.79%
14.3Mb, less than 35.96%

Complexity Anaylsis:
- O(log(n))
    - roughly log_10 digits 
"""

