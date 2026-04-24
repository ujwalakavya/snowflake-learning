-- Set the Roles, Warehouses and Databases
USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

USE SCHEMA MYDB.MYSCHEMA;

-- ===== Standard Stream =====

-- Create a source table
CREATE OR REPLACE TABLE source_table1 (
    id INT,
    name VARCHAR,
    created_date DATE
);

-- Insert some records on the source table
INSERT INTO source_table1 VALUES
(1, 'Chaos', '2023-12-11'),
(2, 'Genius', '2023-12-11');

-- Create a standard stream on the table
CREATE OR REPLACE STREAM standard_stream ON TABLE source_table1;

-- Select data from the table
SELECT * FROM source_table1;

-- Select data from the standard stream
SELECT * FROM standard_stream;

-- Insert new record
INSERT INTO source_table1 VALUES
(3, 'Johnny', '2023-12-11');

-- Select data from the table
SELECT * FROM source_table1;

-- Select data from the standard stream
SELECT * FROM standard_stream;

-- Delete some records
DELETE FROM source_table1
WHERE id = 2;

-- Select data from the table
SELECT * FROM source_table1;

-- Select data from the standard stream
SELECT * FROM standard_stream;

-- Update the source table
UPDATE source_table1
SET name = 'Elon'
WHERE id = 1;

-- Select data from the table
SELECT * FROM source_table1;

-- Select data from the standard stream
SELECT * FROM standard_stream;


-- ===== Append Only Stream =====

-- Create a source table
CREATE OR REPLACE TABLE source_table2 (
    id INT,
    name VARCHAR,
    created_date DATE
);

-- Insert some records on the source table
INSERT INTO source_table2 VALUES
(1, 'Chaos', '2023-12-11'),
(2, 'Genius', '2023-12-11');

-- Create an append only stream on the table
CREATE OR REPLACE STREAM append_only_stream
ON TABLE source_table2
APPEND_ONLY = TRUE;

-- Select data from the append only stream
SELECT * FROM append_only_stream;

-- Insert new record
INSERT INTO source_table2 VALUES
(3, 'Johnny', '2023-12-11');

-- Select data from the table
SELECT * FROM source_table2;

-- Select data from the append only stream
SELECT * FROM append_only_stream;

-- Update source table
UPDATE source_table2
SET name = 'Elon'
WHERE id = 1;

-- Select data from the table
SELECT * FROM source_table2;

-- Select data from the append only stream
SELECT * FROM append_only_stream;

-- == How do we use the stream in ETL process ==

CREATE OR REPLACE TABLE TARGET_TABLE2 (
    id INT,
    name VARCHAR,
    created_date DATE
);

-- Select data from the append only stream
SELECT * FROM append_only_stream;

-- Insert into target table
INSERT INTO TARGET_TABLE2
SELECT id, name, created_date
FROM append_only_stream;

-- Select data from the append only stream
SELECT * FROM append_only_stream;

-- Select data from target table
SELECT * FROM TARGET_TABLE2;

-- Insert into source table
INSERT INTO source_table2 VALUES
(4, 'Rock', '2023-12-11');

-- Select data from the table
SELECT * FROM source_table2;

-- Select data from the append only stream
SELECT * FROM append_only_stream;


-- Insert into target table
INSERT INTO TARGET_TABLE2
SELECT id, name, created_date
FROM append_only_stream;

-- Select data from the append only stream
SELECT * FROM append_only_stream;

-- Select data from target table
SELECT * FROM TARGET_TABLE2;

-- === Insert only stream ===

CREATE EXTERNAL TABLE ext_table
LOCATION = @MY_AWS_STAGE
FILE_FORMAT = my_format;

CREATE STREAM my_ext_stream
ON EXTERNAL TABLE ext_table
INSERT_ONLY = TRUE;
