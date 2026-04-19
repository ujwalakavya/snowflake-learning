use role accountadmin;

use warehouse compute_wh;

create or replace database MYDB;

create or replace schema MYDB.MYSCHEMA;

----
use schema MYDB.MYSCHEMA;
//Default Table type -> Permanent
//Default Retention Period -> 1 DAY

//permanent table
Create or replace table permanent_table
(
ID int,
Name String
);
Alter table permanent_table set data_retention_time_in_days = 3;

//Transient table
Create or replace transient table transient_table
(
Id int,
Name String
);
Alter table transient_table set data_retention_time_in_days = 3;

//Temporary table
Create or replace temporary table temporary_table
(
Id int,
Name String
);
Alter table temporary_table set data_retention_time_in_days = 3;

----

Show tables;

drop table TEMPORARY_TABLE;

-------

create or replace table employees(
id integer,
name varchar(50),
department varchar(50),
salary integer
);

----

//Insert data into the table
INSERT INTO employees (id, name, department, salary)
VALUES (1, 'Pat Fay', 'HR', 50000),
       (2, 'Donald Oconnell', 'IT', 75000),
       (3, 'Steven King', 'Sales', 60000),
       (4, 'Susan Mavris', 'IT', 80000),
       (5, 'Jennifer Whalen', 'Marketing', 55000);

//Select data from the table
SELECT * FROM employees;

-- drop table employee;
