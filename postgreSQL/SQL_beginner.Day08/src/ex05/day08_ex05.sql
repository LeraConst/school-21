--1
day00=# BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN
day00=*# SELECT SUM(rating) FROM pizzeria;
 sum  
------
 21.9
(1 row)

day00=*# SELECT SUM(rating) FROM pizzeria;
 sum  
------
 19.9
(1 row)

day00=*# COMMIT;
COMMIT
day00=# SELECT SUM(rating) FROM pizzeria;
 sum  
------
 19.9
(1 row)

--2
day00=# BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN
day00=*# UPDATE pizzeria SET rating = 1.0 WHERE name = 'Pizza Hut';
UPDATE 1
day00=*# COMMIT;
COMMIT
day00=# SELECT SUM(rating) FROM pizzeria;
 sum  
------
 19.9
(1 row)