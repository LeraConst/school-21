--1
day00=# BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN
day00=*# SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
 id |   name    | rating 
----+-----------+--------
  1 | Pizza Hut |    3.6
(1 row)

day00=*# UPDATE pizzeria SET rating = 4 WHERE name = 'Pizza Hut';
UPDATE 1
day00=*# COMMIT;
COMMIT
day00=# SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
 id |   name    | rating 
----+-----------+--------
  1 | Pizza Hut |      4
(1 row)

--2
day00=# BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN
day00=*# SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
 id |   name    | rating 
----+-----------+--------
  1 | Pizza Hut |    3.6
(1 row)

day00=*# UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';
ERROR:  could not serialize access due to concurrent update
day00=!# COMMIT;
ROLLBACK
day00=# SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
 id |   name    | rating 
----+-----------+--------
  1 | Pizza Hut |      4
(1 row)