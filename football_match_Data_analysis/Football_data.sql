--create the table football

CREATE TABLE Football(
Date_out date,
home_Team VARCHAR(30),
Away_Team VARCHAR(30),
Home_Score INT,
Away_Score INT,
Tournament VARCHAR(20),
City VARCHAR(30),
Country VARCHAR(30),
Neutral VARCHAR(30));

upload  Football.csv  data in postgresql 

\copy  football from 'C:\Users\hp\Desktop\football_match_Data_analysis\Football.csv' with csv header

\COPY football(Date_out,home_Team,Away_Team,Home_Score,Away_Score,Tournament,City,Country,Neutral)
FROM 'C:/Users/hp/Desktop/football_match_Data_analysis/Football.csv'
DELIMITER ','
CSV HEADER;

-- Alter query - add - modifiy 

ALTER TABLE football alter column tournament TYPE varchar(50);
alter table football  alter column Home_Team type varchar(50);
alter table football alter column Away_team type varchar(50);
 
commit;

--SELECT query - Filtering - Conditions

select count(*) from football;

-- Select all  column  name  
select Date_out , Home_Team, Away_Team, Home_Score, Away_Score, Tournament, City, Country, Neutral FROM Football;

-- find how many player play in Home_team with in England

select count(*) from football where Home_Team = 'England'

-- find how many football  Tournament paly with friendly

select count(*) from  football where Tournament <> 'Friendly'

--  find how many football  Tournament paly with friendly in one time 

select distinct Tournament  from football;

--   find how many tournament in these country ('Scotland','England','Wales')

select * from football WHERE COUNTRY IN ('Scotland','England','Wales')

--   find how many tournament are not here these  country ('Scotland','England','Wales')

select * from football WHERE COUNTRY NOT IN ('Scotland','England','Wales')

-- find the name to start with UEFA

SELECT * FROM Football  WHERE Tournament LIKE '%UEFA%'

-- find the name of fisrt word to  start  with 'UEFA%'

SELECT * FROM Football WHERE Tournament LIKE 'UEFA%' 

-- find the name of those word are not  start  with 'UEFA%'

SELECT * FROM Football  WHERE Tournament NOT LIKE '%UEFA%' 

-- find how many football player are score to greater then 10

SELECT * FROM Football WHERE Home_Score > 10

-- find how many football player are score less  then 10
SELECT * FROM Football WHERE Home_Score < 10

-- find how many football player are score  between 20 and  30

SELECT * FROM Football  WHERE Home_Score BETWEEN 20 AND 30

-- find how many football player are score to greater then 10  and less then or greater then 'Friendly'

SELECT * FROM Football WHERE Home_Score > 10 AND Tournament <> 'Friendly'

-- find how many football player are Home_score to greater then 10  or Away_Score > 10
SELECT * FROM Football  WHERE Home_Score > 10 OR Away_Score > 10

-- find how many football player are Home_score to greater then 10  or Away_Score > 10 and Tournament <> 'Friendly'
SELECT * FROM Football WHERE (Home_Score > 10 OR Away_Score > 10) AND Tournament <> 'Friendly'
