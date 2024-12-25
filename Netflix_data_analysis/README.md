# Netflix Movies and TV Shows Data Analysis using SQL

<img src="./Netflix_Symbol_RGB.png"
    style="width:180px; float: right; margin: 0 400px 400px 400px;"></img> 

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```

## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```
netflix=# select count(*) , type from netflix group by type;
 count |  type
-------+---------
  6131 | Movie
  2676 | TV Show
(2 rows)
```

**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows

```
netflix=# select type , rating from(select type,rating, count(*), rank() over(partition by type order by count(*))as RK from netflix group by type ,rating) as tv where RK=1;
  type   |  rating
---------+----------
 Movie   | 84 min
 Movie   | 66 min
 Movie   | 74 min
 TV Show | TV-Y7-FV
(4 rows)


WITH RatingCounts AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix
    GROUP BY type, rating
),
RankedRatings AS (
    SELECT 
        type,
        rating,
        rating_count,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rank
    FROM RatingCounts
)
SELECT 
    type,
    rating AS most_frequent_rating
FROM RankedRatings
WHERE rank = 1;
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List All Movies Released in a Specific Year (e.g., 2020)

```
select * from netflix where type='Movie' and release_year = 2020;

show_id	type	title	director	casts	country	date_added	release_year	rating	duration	listed_in	description
s1	Movie	Dick Johnson Is Dead	Kirsten Johnson	NULL	United States	25-Sep-21	2020	PG-13	90 min	Documentaries	As her father nears the end of his life, filmmaker Kirsten Johnson stages his death in inventive and comical ways to help them both face the inevitable.

s17	Movie	Europe's Most Dangerous Man: Otto Skorzeny in Spain	Pedro de Echave GarcÃ­a, Pablo AzorÃ­n Williams	NULL	NULL	22-Sep-21	2020	TV-MA	67 min	Documentaries, International Movies	Declassified documents reveal the post-WWII life of Otto Skorzeny, a close Hitler ally who escaped to Spain and became an adviser to world presidents.

s79	Movie	Tughlaq Durbar	Delhiprasad Deenadayalan	Vijay Sethupathi, Parthiban, Raashi Khanna	NULL	11-Sep-21	2020	TV-14	145 min	Comedies, Dramas, International Movies	A budding politician has devious plans to rise in the ranks â€” until an unexpected new presence begins to interfere with his every crooked move.

s85	Movie	Omo Ghetto: the Saga	JJC Skillz, Funke Akindele	Funke Akindele, Ayo Makun, Chioma Chukwuka Akpotha, Yemi Eberechi Alade, Blossom Chukwujekwu, Deyemi Okanlawon, Alexx Ekubo, Zubby Michael, Tina Mba, Femi Jacobs	Nigeria	10-Sep-21	2020	TV-MA	147 min	Action & Adventure, Comedies, Dramas	Twins are reunited as a good-hearted female gangster and her uptight rich sister take on family, crime, cops and all of the trouble that follows them.

s104	Movie	Shadow Parties	Yemi Amodu	Jide Kosoko, Omotola Jalade-Ekeinde, Yemi Blaq, Sola Sobowale, Ken Erics, Toyin Aimakhu, Segun Arinze, Jibola Dabo, Rotimi Salami, Pa Jimi Solanke, Rachael Okonkwo, Bassey Okon, Lucien Morgan, Magdalena Korpas	NULL	06-Sep-21	

2020	TV-MA	117 min	Dramas, International Movies, Thrillers	A family faces destruction in a long-running conflict between communities that pits relatives against each other amid attacks and reprisals.

s120	Movie	Here and There	JP Habac	Janine Gutierrez, JC Santos, Victor Anastacio, Yesh Burce, Lotlot De Leon	NULL	02-Sep-21	

2020	TV-MA	99 min	Dramas, International Movies, Romantic Movies	After meeting through a heated exchange on social media, two people with different backgrounds begin an online romance in the midst of a pandemic.


```

**Objective:** Retrieve all movies released in a specific year.

### 4. Find the Top 5 Countries with the Most Content on Netflix

```
netflix=# select unnest(string_to_array(country , ',' )) as country,
netflix-# count(show_id) as total_content
netflix-# from netflix group by 1 order by 2 desc limit 5;
    country     | total_content
----------------+---------------
 United States  |          3211
 India          |          1008
 United Kingdom |           628
  United States |           479
 Canada         |           271
(5 rows)
```

**Objective:** Identify the top 5 countries with the highest number of content items.

### 5. Identify the Longest Movie

```
select  * from netflix
	WHERE type = 'Movie' and duration=(
	select max(duration) from netflix
	);
```

**Objective:** Find the movie with the longest duration.

### 6. Find Content Added in the Last 5 Years

```
SELECT  * FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'

```

**Objective:** Retrieve content added to Netflix in the last 5 years.

### 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

```
netflix=# select  director from netflix where director = 'Rajiv Chilaka';
   director
---------------
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
 Rajiv Chilaka
(19 rows)

```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List All TV Shows with More Than 5 Seasons

```
SELECT * FROM netflix
WHERE type = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::numeric > 5;
```

**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the Number of Content Items in Each Genre

```
SELECT  UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre ,
	count(*) as content FROM netflix group by 1; 
```

**Objective:** Count the number of content items in each genre.

### 10.Find each year and the average numbers of content release in India on netflix. return top 5 year with highest avg content release!

```
select country,  count(*) as content_release,
	extract( year from to_date(date_added , 'Month DD , yyyy')) as year,
	 round(count(*):: numeric/(SELECT COUNT(*) FROM netflix WHERE country = 'India') *100,2) as Avg_content_relaes
	from netflix WHERE country = 'India' group by country,year;

```

**Objective:** Calculate and rank years by the average number of content releases by India.

### 11. List All Movies that are Documentaries

```sql
SELECT * 
FROM netflix
WHERE listed_in LIKE '%Documentaries';
```

**Objective:** Retrieve all movies classified as documentaries.

### 12. Find All Content Without a Director

```sql
SELECT * 
FROM netflix
WHERE director IS NULL;
```

**Objective:** List content that does not have a director.

### 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

```
SELECT  * FROM netflix 
	WHERE casts LIKE '%Salman Khan%' and
	release_year>= EXTRACT(YEAR FROM CURRENT_DATE)-10
```

**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.

### 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

``` 
SELECT 
	unnest(string_to_array(casts,',')) as actors,
	count(*) as highest_No_of_movies FROM netflix 
	where country = 'India' group by 1 order by 2 desc limit 10
	
```

**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.

### 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

```
with  cont as(
	SELECT 	*,
	CASE 
	WHEN description ILIKE '%kill%' 
	OR description ILIKE '%violence%'
	THEN 'Bad'
    ELSE 'Good'
	END  category
    FROM netflix
	)
	SELECT category,
    COUNT(*) AS total_content
	from cont group by 1
```

**Objective:** Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.

## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.



## Author - Zero Analyst

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:


- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/ksubham)


 