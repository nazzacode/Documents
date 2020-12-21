"""
Question 12. Integer to Roman

convert an integer number to roman numerals
"""
class Solution(object):
    def intToRoman(self,num):
        """
        :type num: int
        :rtype: str
        """

        roman = ""
        roman_dict = {1000:"M", 900: "CM", 500: "D", 400: "CD", 100: "C",
        90: "XC", 50: "L", 40: "XL", 10: "X", 9: "IX", 5: "V", 4: "IV", 1: "I"}

        for key in roman_dict:
            while num - key >= 0:
                num -= key
                roman = roman + roman_dict[key]
                if num == 0:
                    return roman
        return roman
