# codeforces educational round 80: A. Deadline

import math

no_testcase = int(input())

output = "NO"

for i in range(no_testcase):
    n,d = map(int,input().split())

    if n >= d:
        output = "YES"
        print(output)
    else:
        bestcase = d
        for x in range(1,n-1):
            runtime = x + math.ceil(d/(x+1))
            if runtime <= n:
                output = "YES"
                print(output)
                break
            elif runtime >= bestcase:
                output = "NO"
                print(output)
                break
            elif x == (n-1):
                output = "NO"
                print(output)
            else:
                bestcase = runtime

