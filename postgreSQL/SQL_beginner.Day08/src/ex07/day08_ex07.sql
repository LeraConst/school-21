--1
day00=# BEGIN;
BEGIN
day00=*# UPDATE pizzeria SET rating = 5.0 WHERE id = 1;
UPDATE 1
day00=*# UPDATE pizzeria SET rating = 4.1 WHERE id = 2;
UPDATE 1
day00=*# COMMIT;
COMMIT

--2
day00=# BEGIN;
BEGIN
day00=*# UPDATE pizzeria SET rating = 4.0 WHERE id = 2;
UPDATE 1
day00=*# UPDATE pizzeria SET rating = 4.9 WHERE id = 1;
ERROR:  deadlock detected
DETAIL:  Process 18191 waits for ShareLock on transaction 833; blocked by process 18169.
Process 18169 waits for ShareLock on transaction 834; blocked by process 18191.
HINT:  See server log for query details.
CONTEXT:  while updating tuple (0,18) in relation "pizzeria"
day00=!# COMMIT;
ROLLBACK