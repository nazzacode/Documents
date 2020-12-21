---
title: Algorithms and Data Structures 2020 Exam-- Question 1
author: Nathan Sharp | s1869292 | B130263
date: 15-12-2020 
...


# Question 1

(a). 

Asymptotic upper and lower bounds for $T(n) =T(n-2) + \log(n)$.

Lets Substitute $n=n-1$,


$T(n-1)=T(n-3)+\log(n-1)$

$T(n-2)=T(n-4)+\log(n-2)$

$T(n-3)=T(n-5)+\log(n-3)$

$T(n-4)=T(n-6)+\log(n-4)$

Substituting this pattern to the limit in the original equation:

$T(n)=log n+log(n-1)+log(n-2)+log(n-3)+ \cdots + log(3)+0+0$

Using $\log(m)+\log(n) = \log(mn)$:

$T(n)=log[n(n-1)(n-2)(n-3)...3+0+0]$

Hence, 
$$\underline{T(n) = \Theta(\log(n!))} (= \Theta(n \log(n)))$$


(b).

i. 

The statement is false. Proof by counter example. 

Consider the graph ABCD with weights AB=4,AD=2,AC=3,BC=4,CD=2

In the example (A,B,C,A) is a cycle with minimum weight AC = 3. Using prims algorithm from B we get MST {BC,CD,AD}.


ii.

Ignoring the edge case where the largest edge weight is not the exclusive largest edge weight. Proof by contradiction. 

Assume that the largest weight ($v_{i}$,$v_{i+1}$) is in the MST.

There must be an vertex connecting the edges of the max-vertex to the rest of the MST as an MST is connected. 

Hence if we cut the vertex, a maximum of 1 edge can be estranged from the MST. 

We know we only need to make 1 connection to return it to the MST.

We know this connection exists by virtue of it being in a cycle. 

And we know this reconnection is of lower weight by virtue of the problem. 

Hence we have a contradiction a la minimum weight.

(c).

$n \sum_{i=0}^{n-1} a_i^2 = \sum_{i=0}^{n-1} |b_i|^2$

Expanding the LHS with the equation given in Lecture 5:

$\sum_{i=0}^{n-1} |b_i|^2 = n \sum_{i=0}^{n-1} \sum_{k=0}^{n-1} (a_k \cdot \omega_n^{ik}) \sum_{j=0}^{n-1} (a_j \cdot \omega_n^{ij})$

$\sum_{i=1}^{n-1} |b_i|^2 = \sum_{i,j,k}(a_k \cdot a_j \cdot \omega_n^{i(k-j)})$

... incomplete




