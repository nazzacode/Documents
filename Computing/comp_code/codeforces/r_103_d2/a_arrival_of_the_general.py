# Codeforces Round 103 Div 2
# A. Arrival of the General

n = int(input())

l = list(map(int, input().split()))

swaps = l.index(max(l)) + l[::-1].index(min(l))

print(swaps-(swaps>=n))
