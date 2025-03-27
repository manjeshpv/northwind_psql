CREATE EXTENSION IF NOT EXISTS mysql_fdw;

CREATE SERVER mysql_student_db
FOREIGN DATA WRAPPER mysql_fdw
OPTIONS (host 'student', port '3306');


CREATE ROLE reporting_user WITH LOGIN PASSWORD 'rootpassword';


CREATE USER MAPPING FOR reporting_user
SERVER mysql_student_db
OPTIONS (username 'root', password 'rootpassword');

-- Todo: import mysql db
CREATE FOREIGN TABLE order_details (
    OrderDetailID INTEGER,
    OrderID INTEGER,
    ProductID INTEGER,
    Quantity INTEGER
) SERVER mysql_student_db
OPTIONS (dbname 'my_database', table_name 'OrderDetails');

drop FOREIGN TABLE order_details;

SELECT * FROM order_details;


-- ### Root user
GRANT USAGE ON FOREIGN SERVER mysql_student_db TO reporting_user;

grant all on table order_details to reporting_user;

GRANT USAGE ON FOREIGN DATA WRAPPER mysql_fdw TO reporting_user;
