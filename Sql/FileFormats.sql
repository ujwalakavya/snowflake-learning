USE SCHEMA MYDB.MYSCHEMA;

-- Create an Employee table
CREATE OR REPLACE TABLE STUDENT (
    id INTEGER,
    name VARCHAR(50),
    age INTEGER,
    marks INTEGER
);

-- Create a named stage
CREATE OR REPLACE STAGE STUDENT_STAGE;

-- Access the named internal stage
LIST @STUDENT_STAGE;

-- Load data to the customer table without a file format
COPY INTO STUDENT
FROM @STUDENT_STAGE
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);

-- Select data from the table
SELECT * FROM STUDENT;

-- Truncate the table
TRUNCATE TABLE STUDENT;

-- Create a CSV File format
CREATE OR REPLACE FILE FORMAT CSV_FORMAT
TYPE = 'CSV'
FIELD_DELIMITER = ','
RECORD_DELIMITER = '\n'
SKIP_HEADER = 1;

-- Load data to customer table with file format
COPY INTO STUDENT
FROM @STUDENT_STAGE
FILE_FORMAT = (FORMAT_NAME = CSV_FORMAT);

-- Select data from the table
SELECT * FROM STUDENT;

-- Create a JSON File format
CREATE FILE FORMAT JSON_FORMAT
TYPE = 'JSON';

SHOW FILE FORMATS;