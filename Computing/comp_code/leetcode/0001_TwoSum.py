"""
LeetCode 0001: Two Sum 

Question:
Given an array of integers, return indices of the two numbers such that they
add up to a specific target

You may assume that each input hs exactly one solution, and you may not use
the same element twice.
 
Example 1:
input: numbers = [2,7,11,15], target = 9
output: [0,1]
"""


class Solution:
    def toSum(self, nums: List[int], target: int) -> List[int]:
        dic = {}
        result = []
        for i in range(len(nums)):
            num_to_find = target - nums[i]
            if num_to_find in dic.keys():
                result = [i, dic[num_to_find]]
                break

            dic[nums[i]] = i

        return result 

        
"""
Submission:
52ms, faster than 68%
15.6Mb, less than 13.46%

Complexity Anaylsis:
- Brute force would be O(n^2) as requires double loop 
- Single pass hash table implementation O(n)
   - single loop + amortized hash lookup
"""
