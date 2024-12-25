## Fotball_Match Data Analysis With SQL


## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Football Dataset](./Football_results%201872-2020.csv)

## Schema

- 1: Create the table

```
IF OBJECT_ID('Football_Data_2020') IS NOT NULL DROP TABLE Football_Data_2020

CREATE TABLE Football_Data_2020
([Date] NVARCHAR(200),
Home_Team NVARCHAR(200),
Away_Team NVARCHAR(200),
Home_Score INT,
Away_Score INT,
Tournament NVARCHAR(200),
City NVARCHAR(200),
Country NVARCHAR(200),
Neutral NVARCHAR(200)
)
```


- 2: Import the csv Data

```
BULK INSERT Football_Data_2020
FROM 'G:\FROM Football_Data_Analysis\results 1872-2020.csv'
WITH ( FORMAT='CSV');
```

## Data Analysis

 - Filtering - Conditions 

 