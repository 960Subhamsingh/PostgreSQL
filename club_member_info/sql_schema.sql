-- Create table to import SQL data into and use for data cleaning.

DROP TABLE IF EXISTS club_member_info;
CREATE TABLE club_member_info (
	member_id serial,
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

COPY club_member_info (
	full_name,
	age,
	maritial_status,
	email,
	phone,
	full_address,
	job_title,
	membership_date)
from 'D:\Project\PostgreSQL\club_member_info\csv\club_member_info.csv'
delimiter ',' csv header;