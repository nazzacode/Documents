# Codeforces round 104 div 2
# A. Lucky Ticket
import math

n = int(input())
p = math.floor(n/2)
t = [int(d) for d in str(input())]

if (sum(t[:p]) == sum(t[p:])):
    for i in t:
        if not((i == 4) or (i == 7)):
            print("NO")
            break
    print("YES")
else:
    print("NO")






