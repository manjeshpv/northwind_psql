CREATE EXTENSION IF NOT EXISTS postgres_fdw;


CREATE SERVER remote_pg_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'consent', dbname 'postgres', port '5432');


CREATE USER MAPPING FOR current_user
SERVER remote_pg_server
OPTIONS (user 'postgres', password 'postgres');


--        consent pg public.table1
IMPORT FOREIGN SCHEMA public
FROM SERVER remote_pg_server
INTO consent;

DROP SERVER IF EXISTS remote_pg_server CASCADE;
