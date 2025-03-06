BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
--1
day00=# BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN
day00=*# SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
 id |   name    | rating 
----+-----------+--------
  1 | Pizza Hut |    3.6
(1 row)

day00=*# SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
 id |   name    | rating 
----+-----------+--------
  1 | Pizza Hut |    3.6
(1 row)

day00=*# COMMIT;
COMMIT
day00=# SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
 id |   name    | rating 
----+-----------+--------
  1 | Pizza Hut |    3.0
(1 row)

--2
day00=# BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN
day00=*# UPDATE pizzeria SET rating = 3.0 WHERE name = 'Pizza Hut';
UPDATE 1
day00=*# COMMIT;
COMMIT
day00=# SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
 id |   name    | rating 
----+-----------+--------
  1 | Pizza Hut |    3.0
(1 row)