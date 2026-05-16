-- Set the Roles, Warehouses and Databases
USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

USE SCHEMA MYDB.MYSCHEMA;

-- Create an Employee table
CREATE OR REPLACE TABLE USER (
    id INTEGER,
    name VARCHAR(50),
    location VARCHAR(50),
    email VARCHAR(50)
);

-- Create a storage integration with S3 and IAM role
CREATE OR REPLACE STORAGE INTEGRATION s3_int
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = 'S3'
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::943193395377:role/snowflake_role'
STORAGE_ALLOWED_LOCATIONS = ('s3://uj-snowflake-learning/');

-- Describe the storage integration
DESC INTEGRATION s3_int;

-- Create a file format
CREATE OR REPLACE FILE FORMAT my_csv_format
TYPE = 'CSV'
FIELD_DELIMITER = ','
RECORD_DELIMITER = '\n'
SKIP_HEADER = 1;

-- Create an external S3 stage
CREATE OR REPLACE STAGE my_s3_stage
STORAGE_INTEGRATION = s3_int
URL = 's3://uj-snowflake-learning/'
FILE_FORMAT = my_csv_format;

-- Access the external stage
LIST @my_s3_stage;

-- Load data into USER table
COPY INTO USER
FROM @my_s3_stage
FILE_FORMAT = (FORMAT_NAME = my_csv_format);

-- Select data from USER table
SELECT * FROM USER;


------

SNOWPIPE!!

-- Set the Roles, Warehouses and Databases

USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

USE SCHEMA MYDB.MYSCHEMA;

-- Create an Employee table
CREATE OR REPLACE TABLE EVENT (
    EVENT VARIANT
);

-- Create a storage integration with S3 and IAM role
CREATE OR REPLACE STORAGE INTEGRATION s3_snowpipe_int
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = 'S3'
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::943193395377:role/snowpipe_role'
STORAGE_ALLOWED_LOCATIONS = ('s3://uj-snowflake-learning/event/');

-- Describe the storage integration
DESC INTEGRATION s3_snowpipe_int;

-- Create a file format
CREATE OR REPLACE FILE FORMAT my_json_format
TYPE = 'JSON';

-- Create an external s3 stage
CREATE OR REPLACE STAGE my_s3_snowpipe_stage
STORAGE_INTEGRATION = s3_snowpipe_int
URL = 's3://uj-snowflake-learning/event/'
FILE_FORMAT = my_json_format;

-- Access the external stage
LIST @my_s3_snowpipe_stage;

-- Create a snowpipe to load the event data from s3
CREATE OR REPLACE PIPE s3_pipe
AUTO_INGEST = TRUE AS
COPY INTO event
FROM @my_s3_snowpipe_stage
FILE_FORMAT = (FORMAT_NAME = my_json_format);

-- Select the status of the pipe
SELECT SYSTEM$PIPE_STATUS('s3_pipe');

-- Get the notification channel
SHOW PIPES;

select * from event;