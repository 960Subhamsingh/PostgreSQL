-- create MySql Databases;

-- create club_member databases 

create database club_member;

use club_member;

-- Create table to import SQL data into and use for data cleaning.

DROP TABLE IF EXISTS club_member_info;
CREATE TABLE club_member_info (
	full_name varchar(100),
	age int,
	maritial_status varchar(50),
	email varchar(150),
	phone varchar(20),
	full_address varchar(150),
	job_title varchar(100),
	membership_date date,
	PRIMARY KEY (member_id)
);


LOAD DATA INFILE 'D:/Project/PostgreSQL/club_member_info/csv/club_member_info.csv'
INTO TABLE club_member_info
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(full_name,age,maritial_status,email,phone,full_address,job_title,membership_date)
SET membership_date = STR_TO_DATE(@membership_date, '%m/%d/%Y');

LOAD DATA INFILE 'D:/Project/PostgreSQL/club_member_info/csv/club_member_info.csv'
INTO TABLE club_member_info
FIELDS TERMINATED BY ','  -- Specifies the delimiter used in your CSV (e.g., a comma).
ENCLOSED BY '"'           -- Specifies the character used to enclose fields, e.g., double quotes.
LINES TERMINATED BY '\n'  -- Specifies the line terminator (new line).
IGNORE 1 LINES;          -- Skips the header row in the CSV.


 your file inside of the folder specified in secure-file-priv

SHOW VARIABLES LIKE "secure_file_priv";