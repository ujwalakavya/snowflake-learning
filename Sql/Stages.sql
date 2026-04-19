USE SCHEMA MYDB.MYSCHEMA;

-- Create a customer table
CREATE OR REPLACE TABLE customer (
    id INTEGER,
    name VARCHAR(50),
    age INTEGER,
    state VARCHAR(50)
);

-- Access the table stage
LIST @%customer;

-- Access the user stage
LIST @~;

-- Create a named stage
CREATE OR REPLACE STAGE CUSTOMER_STAGE_SQL;

-- Access the named internal stage
LIST @CUSTOMER_STAGE;

-- Truncate the table
select * from customer;
TRUNCATE TABLE CUSTOMER;

-- Load data to the customer table
COPY INTO customer
FROM @CUSTOMER_STAGE
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);

Select * from customer;
-- Undrop schema myschema;
