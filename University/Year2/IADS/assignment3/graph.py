import math
import random
import sys


def euclid(p,q):
    x = p[0]-q[0]
    y = p[1]-q[1]
    return math.sqrt(x*x+y*y)

class Graph:
    # Complete as described in the specification, taking care of two cases:
    # the -1 case, where we read points in the Euclidean plane, and
    # the n>0 case, where we read a general graph in a different format.
    # self.perm, self.dists, self.n are the key variables to be set up.
    def __init__(self, n, filename):

        file = open(filename,"r")

        # case n=-1: Euclidian distances
        if n == -1:
            self.n, nodes = 0, []
            for line in file:
                line = line.strip()
                if line != "":
                    self.n += 1
                    node = tuple(map(float, line.split()))
                    nodes.append(node)
                else:
                    file.close()
                    break

            # initialise empty nxn matrix to store distances between nodes
            self.dists = [[0]*self.n for x in range(self.n)]
            # fill matrix (symetric along diagonal)
            for i in range(self.n):
                for j in range(i):
                    self.dists[j][i] = self.dists[i][j] = euclid(nodes[i],nodes[j])

        # case n>-1: Non-euclidian distances
        elif n > 0:
            self.n = n

            # initialise empty n x n matrix to store distances between nodes
            self.dists = [[0]*self.n for x in range(self.n)]
            for line in file:
                line = line.strip()
                if line != '':
                    i, j, dist = map(int, line.split())
                    self.dists[j][i] = self.dists[i][j] = dist
                else:
                    file.close()
                    break

        else:
            raise ValueError("number of nodes n, must be -1 or a positive integer")

        # initialise chronological permutation perm[i] = i
        self.perm =  [x for x in range(self.n)]


    # Complete as described in the spec, to calculate the cost of the
    # current tour (as represented by self.perm).
    def tourValue(self):
        tour_sum = 0
        for i in range(self.n):
            tour_sum += self.dists[self.perm[i]][self.perm[(i+1) % self.n]]

        return tour_sum


    # Attempt the swap of cities i and i+1 in self.perm and commit
    # commit to the swap if it improves the cost of the tour.
    # Return True/False depending on success.
    def trySwap(self, i):
        # nodes are ordered lexicographically
        swap = False
        h_node = self.perm[(i-1) % self.n]
        i_node = self.perm[i]
        j_node = self.perm[(i+1) % self.n]
        k_node = self.perm[(i+2) % self.n]

        curr_cost = self.dists[h_node][i_node] + self.dists[j_node][k_node]
        swap_cost = self.dists[h_node][j_node] + self.dists[i_node][k_node]

        if swap_cost < curr_cost:
            j = (i+1) % self.n
            self.perm[i], self.perm[j] = j_node, i_node
            swap =  True

        return swap


    # Consider the effect of reversing the segment between
    # self.perm[i] and self.perm[j], and commit to the reversal
    # if it improves the tour value.
    # Return True/False depending on success.
    def tryReverse(self,i,j):
        reverse = False
        h_node = self.perm[(i-1) % self.n]
        i_node = self.perm[i]
        j_node = self.perm[j]
        k_node = self.perm[(j+1) % self.n]

        # only changes cost at edges
        curr_cost = self.dists[h_node][i_node]  + self.dists[j_node][k_node]
        rev_cost = self.dists[h_node][j_node] + self.dists[i_node][k_node]

        if rev_cost < curr_cost:
            # do reverse as reverse improves the cost of the tour
            self.perm[i:j+1] = self.perm[i:j+1][::-1]
            reverse = True

        return reverse


    def swapHeuristic(self):
        better = True
        while better:
            better = False
            for i in range(self.n):
                if self.trySwap(i):
                    better = True


    def TwoOptHeuristic(self):
        better = True
        while better:
            better = False
            for j in range(self.n-1):
                for i in range(j):
                    if self.tryReverse(i,j):
                        better = True


    # Implement the Greedy heuristic which builds a tour starting
    # from node 0, taking the closest (unused) node as 'next'
    # each time.
    def Greedy(self):
        self.perm[0] = 0
        start_idx = 0
        next_idx = start_idx
        visited = {start_idx}

        for i in range(1,self.n):
            neighbours = [(weight,idx) for (idx,weight) in
                            enumerate(self.dists[next_idx]) if
                                idx not in visited]
            _ , next_idx = min(neighbours)
            self.perm[i] = next_idx
            visited.add(next_idx)

