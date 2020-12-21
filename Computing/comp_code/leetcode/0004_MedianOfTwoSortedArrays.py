"""
Leetcode 0004. Meadian of Two Sorted Arrays

Question:
There are two sorted arrays `nums1` and `nums2` of size `m` and `n` respectivly, return the median of the two sorted arrays. (You may assume the arrays cannot both be empty.)
Aim: 
Overall runtime complexity should be O(log(m+n)).
"""

import math

class Solution(object):
    def findMedianSortedArrays(self, nums1: List[int], nums2: List[int]) -> float:

        def merge(a, b):
            """merges two already sorted arrays"""
            a.append(math.inf)
            b.append(math.inf)
            c = []

            for i in range(len(a)+len(b)-2):
                if a[0] <= b[0]:
                    c.append(a.pop(0))
                else:
                    c.append(b.pop(0))
            return c

        nums3 = merge(nums1, nums2)

        if len(nums3) % 2 == 0:
            return ((nums3[int(len(nums3)/2)-1] + nums3[int(len(nums3)/2)])/2)
        else:
            return nums3[math.floor(len(nums3)/2.0)]

"""
Submission:
88ms, faster than 80.44%
14.2Mb, less than 13%

Complexity Anaylsis:
- O(n)

Notes:
- can be done faster, namely O(log(min(m,n)))
"""

