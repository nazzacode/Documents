"""
Given a 32-bit signed integer, reverse digets of an integer.

Example
Input
-123
Output
-321
"""

class Solution(object):
    def reverse(self,x):
        """
        :type x: int
        :rtype: int
        """
        if(abs(x) > (2 ** 31 - 1)):
            return 0
        neg = False
        if x < 0:
            neg = True
            x = x * -1

        s = str(x)[::-1]
        n = int(s)
        if neg:
            n = n*-1

        return n
