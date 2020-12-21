# Introduction to Databases: Tutorial 3
Nathan Sharp | s1869292 | 18.10.2020

## Problem 1

1. 
```SQL
SELECT Customer.Id, Customer.Name
FROM Customer, Account
WHERE Customer.Id = Account.CustId
  AND Customer.City = 'London' 
  AND Account.Branch != 'Edinburgh'
```
