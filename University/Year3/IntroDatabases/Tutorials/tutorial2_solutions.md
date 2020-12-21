# Introduction to Databases: Tutorial 2
Nathan Sharp | s1869292 | 11.10.2020

## Problem 1
_Consider the following Schema--_
_Customer : ID, Name, City_
_Account : Number, Branch, ID, Balance_

_Write the following questions in relational calculus_

(1) _ID and name of customers who own an account in a branch in their City_
  $$\{i,na \,|\, \exists c \, Customer(i,na,c) \land \exists nu,c,i,ba \, Account(nu,c,i,ba) \}$$

(2) _ID and name of customers who do not own any account_
  $$\{i,na \,|\, \exists c \, Customer(i,n,c) \land \neg \exists nu,br,i,ba \, Account(nu,br,i,ba) \}$$ 
  $$\{i,na \,|\, \exists c \, Customer(i,n,c) \land \forall nu,br,i',ba \, Account(nu,br,i',ba) \land i \neq i' \}$$ 

(3) _ID and name of customers who own an account with a balance which is no less than the balance of any other account._
  $$
  \begin{aligned}
  \{i,&na \,|\, \exists c \, Customer(i,n,c) \land \\
  & \forall nu,br,i',ba \, Account(nu,br,i',ba) \rightarrow \exists nu',br',i,ba' \,Account(nu',br',i,ba') \land \\
  &ba' >= ba \}
  \end{aligned}
  $$

## Problem 2
_Given a schema consisting of a binary relation $R$ and a ternary relation $S$, write a relation calculus query that computes the active domain_

## Problem 3
_Consider the schema of Problem 1. Express the following relational algebra query in relational calculus._
$$Customer \bowtie (\pi_{ID,City}(Customer) \cap \rho_{CustID \rightarrow ID,Branch \rightarrow City}(\pi_{Branch,CustID}(Account)))$$

$$
\begin{aligned}
&C(x_{Id},x_{Name},x_{City}) \land \\
&(\exists x_{Name} \, C(x_{Id},x_{Name},x_{City}) \land \\
&(\neg \exists x_{name} \, C(x_{Id},x_{Name},x_{City}) \land \exists x_{Number},x_{Balance} \, A(x_{Number},x_{City},x_{Id},x_{Balance})))
\end{aligned}
$$
