--1
psql (14.11 (Ubuntu 14.11-0ubuntu0.22.04.1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

day00=# BEGIN;
BEGIN
day00=*# UPDATE pizzeria SET rating = 5 WHERE name = 'Pizza Hut';
UPDATE 1
day00=*# SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
 id |   name    | rating 
----+-----------+--------
  1 | Pizza Hut |      5
(1 row)

day00=*# COMMIT;
COMMIT

--2
psql (14.11 (Ubuntu 14.11-0ubuntu0.22.04.1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

day00=# SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
 id |   name    | rating 
----+-----------+--------
  1 | Pizza Hut |    4.6
(1 row)

day00=# SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
 id |   name    | rating 
----+-----------+--------
  1 | Pizza Hut |      5
(1 row)

day00=# 