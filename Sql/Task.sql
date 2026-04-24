USE ROLE ACCOUNTADMIN;

USE WAREHOUSE COMPUTE_WH;

USE SCHEMA MYDB.MYSCHEMA;

-- ===== Without Task =====

-- Create a source table
CREATE OR REPLACE TABLE SOURCE_TABLE (
    id INT,
    name VARCHAR,
    created_date DATE
);

-- Insert some records on the source table
INSERT INTO SOURCE_TABLE VALUES
(1, 'Chaos', '2023-12-11'),
(2, 'Genius', '2024-07-04');

-- Select data from source table
SELECT * FROM SOURCE_TABLE;

-- Create a target table
CREATE OR REPLACE TABLE TARGET_TABLE (
    id INT,
    name VARCHAR,
    created_date DATE,
    created_day VARCHAR,
    created_month VARCHAR,
    created_year VARCHAR
);

-- Insert data into the target table
INSERT INTO TARGET_TABLE
SELECT
    a.id,
    a.name,
    a.created_date,
    DAY(a.created_date) AS created_day,
    MONTH(a.created_date) AS created_month,
    YEAR(a.created_date) AS created_year
FROM SOURCE_TABLE a
LEFT JOIN TARGET_TABLE b
    ON a.id = b.id
WHERE b.id IS NULL;

-- Select data from target table
SELECT * FROM TARGET_TABLE;

-- Select data from target table
SELECT * FROM TARGET_TABLE;

-- Insert some records on the source table
INSERT INTO SOURCE_TABLE VALUES
(3, 'Elan', '2022-02-24');

-- Create a source table
CREATE OR REPLACE TABLE SOURCE_TABLE (
    id INT,
    name VARCHAR,
    created_date DATE
);

-- Insert some records on the source table
INSERT INTO SOURCE_TABLE VALUES
(1, 'Chaos', '2023-12-11'),
(2, 'Genius', '2024-07-04');

-- Select data from source table
SELECT * FROM SOURCE_TABLE;

-- Create a target table
CREATE OR REPLACE TABLE TARGET_TABLE (
    id INT,
    name VARCHAR,
    created_date DATE,
    created_day VARCHAR,
    created_month VARCHAR,
    created_year VARCHAR
);

-- Insert data into the target table through task
CREATE OR REPLACE TASK my_task
WAREHOUSE = COMPUTE_WH
SCHEDULE = '1 MINUTE'
AS
INSERT INTO TARGET_TABLE
SELECT
    a.id,
    a.name,
    a.created_date,
    DAY(a.created_date) AS created_day,
    MONTH(a.created_date) AS created_month,
    YEAR(a.created_date) AS created_year
FROM SOURCE_TABLE a
LEFT JOIN TARGET_TABLE b
    ON a.id = b.id
WHERE b.id IS NULL;

-- Show tasks
SHOW TASKS;

-- Alter the task to execute
ALTER TASK my_task RESUME;

ALTER TASK my_task SUSPEND;

-- Check the task status
SELECT *
FROM TABLE(INFORMATION_SCHEMA.TASK_HISTORY(TASK_NAME => 'my_task'));

-- Select data from target table
SELECT * FROM TARGET_TABLE;


-- Insert some records on the source table
INSERT INTO SOURCE_TABLE VALUES
(3, 'Elan', '2022-02-24');


