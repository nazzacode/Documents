# Introduction to Databases

# Tutorial 4 Notes

Nathan Sharp | S1869292


Link to database: https://ifile.inf.ed.ac.uk/?path=/afs/inf.ed.ac.uk/group/teaching/dbs/2020/coursework/sql-test/data/db1.sql

## Data Model

| __Customer__ |                      |
| ---          | ---                  |
| id (key)           | integer              |
| name         | string               |
| country      | string (ISO alpha-3) |

| __Products__ | | 
| --- | --- |
| code (key) | integer |
| name | string | 
| description | string |
| price | numeric(5,2) |

| __Orders__ ||
| --- | --- |
| id (key) | integer |
| date | datetime? | 
| reference (references Customer.id) | integer | 

| 
