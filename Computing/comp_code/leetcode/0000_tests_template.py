import unittest
from my_problem import Solution

class MyTests(unittest.TestCase):
    def Test1(self):
        inpt1 = ""
        self.assertEqual(Solution().problem(), "ans")

if __name__ == "__main__":
    inpt1 = ""
    print(Solution().problem())
    unittest.main()
