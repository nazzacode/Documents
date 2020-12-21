# Introduction to Databases

# Tutorial 5 Solutions

Nathan Sharp | S1869292

## Problem 1

### (a) 
_Note:_ the four given FDs are refered to by their number

  (1) $D \Rightarrow AC$ does not hold with witness rows=(1,2), D=(3,3), AC=((1,2),(2,2)).

  (2) $AB \Rightarrow DE$ holds.

  (3) $FD \Rightarrow E$ does not hold with witness rows=(1,2), F/D=(4,3), E=(0,1).

  (4) $C \Rightarrow F$ holds. 

### (b) and (c)
$AC \Rightarrow E$ 

$BD \Rightarrow EF$ 

$EF \Rightarrow BC$

$BC \Rightarrow BF$ 

$AD \Rightarrow CF$ implied by,

  (5) $D \Rightarrow C$ by decomposition of (1)
  (6) $D \Rightarrow CF$ by union of (1) and (5)
  (7) $AD \Rightarrow ACF$ by augmentation of (6)
  (8) $AD \Rightarrow CF$ by decomposition of (7)

$ABC \Rightarrow DF$ implied by,

  (9)  $D \Rightarrow F$ by transitivity of (5) & (4)
  (10) $AB \Rightarrow D$ by decomposition of (2)
  (11) $AB \Rightarrow DF$ by union of (9) & (10) 
  (12) $ABC \Rightarrow DFC$ but augmentation of (11)
  (13) $ABC \Rightarrow DF$ by decomposition of (12)

$DEF \Rightarrow AB$ 

$DF \Rightarrow AE$

$CD \Rightarrow DE$ 

$BE \Rightarrow AC$ 

$CD \Rightarrow ED$

$DE \Rightarrow AF$


## Problem 2



