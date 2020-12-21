"""IADS LAB 2"""

def GCD(m,n):
    if n == 0:
        return m
    else:
        return GCD(n, m%n)

# Ex1
# 1.1 Calculates a^n%m
def expmod1(a, n, m):
    return (a**n)%m

#1.3
def expmod3(a, n, m):
    if n == 0:
        return 1
    else:
        r = expmod3(a, n//2, m)
        if n%2==0:
            return (r**2)%m
        else:
            return (r*r*a)%m

# Ex2
# 2.1
def insert_sort(arr):       # use A instead of arrr
    for i in range(1, len(arr)):
        key=arr[i]  # use k instead of key
        h=i-1
        while h>=0 and key < arr[h]:
            arr[h+1] = arr[h]
            h -= 1
        arr[h+1]=key
    return arr

#2.2
def merge(A,B):


def mergesort():
    return 1

def main():
    A = [2,3,8,17,33]
    B = [3,7,14,20,25]
    print(A[0])
    print(merge(A,B))

if __name__ == '__main__':
    main()
