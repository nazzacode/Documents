# codeforces round 103 div 2
# b. meeting

import math

xa,ya,xb,yb = map(int,input().split())

generals = []

for i in range(min(xa,xb), max(xa,xb)+1):
    generals.extend([(i,ya), (i,yb)])

for j in range(min(ya,yb)+1, max(ya,yb)):
    generals.extend([(xa,j), (xb,j)])

for heater in range(int(input())):
    xh,yh,rh = map(int,input().split())
    generals = [(xg,yg) for (xg,yg) in generals \
                    if not math.sqrt((xg-xh)**2 + (yg-yh)**2) <= rh]

print(len(generals))
