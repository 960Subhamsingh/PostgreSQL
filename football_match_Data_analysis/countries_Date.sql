
-- create Countries_Data table 

CREATE TABLE Countries_Data(
Country VARCHAR(50),
Region VARCHAR(50),
Population INT,
Area_sq_mi FLOAT,
Pop_Density FLOAT,
Coastline_coast FLOAT,
Net_migration FLOAT,
Infant_mortality FLOAT,
GDP_$_per_capita INT,
Literacy_Perc FLOAT,
Phones_per_1000 FLOAT,
Arable_Perc FLOAT,
Crops_Perc FLOAT,
Other_Perc FLOAT,
Climate FLOAT,
Birthrate FLOAT,
Deathrate FLOAT,
Agriculture FLOAT,
Industry FLOAT,
Service FLOAT);

upload countries.csv  data in postgresql 

\copy Countries_Data from 'C:\Users\hp\Desktop\football_match_Data_analysis\countries.csv' with csv header


--  using  SELECT  statement - Filtering - Conditions

-- see the existing data  of  Countries_Data table 

select * from Countries_Data;

-- find how many match in Europe Region  of there country

--search how many country have  match in Europe  Region   in Football table

SELECT * FROM Football WHERE Country IN (SELECT DISTINCT Country FROM Countries_Data WHERE Region LIKE '%Europe%')

--search how many country have  greater then 10000000 population   in football match 
SELECT * FROM Football WHERE Country IN (SELECT DISTINCT Country FROM Countries_Data WHERE Population > 10000000)

--Select all games that happened in max date
SELECT * FROM Football WHERE Date_out = (SELECT MAX(Date_out) FROM Football);

--Select all countries that ever participated in UEFA games)

SELECT * FROM Football  WHERE Home_Team IN (SELECT DISTINCT Home_Team FROM Football WHERE Tournament LIKE '%UEFA%');