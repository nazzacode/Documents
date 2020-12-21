"""
Dee's Dynamic Square

Question
For a nxm rectangle, how many paths are there between 2 opposing
diagonals (you can only move up/down, left/right between squares)

Input
single line "n m" input containing the dimentions of the rectangle.

Output
the number of possilbe shortest paths

Examples

input
2 2
output
2

input
4 5
output
35
"""

n,m = map(int, input().split())

def paths(n,m):
    if (n==1 or m==1):
        return 1
    else:
        return paths(n-1,m) + paths(n, m-1)

print(paths(n,m))
