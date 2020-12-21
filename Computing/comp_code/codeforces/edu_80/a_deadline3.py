# codeforces educational round 80
# A. Deadline

for _ in range(int(input())):
	n,d=map(int,input().split())
	D=1+n
	B=4*d
	if((D**2)>=B):
		print("YES")
	else:
		print("NO")
