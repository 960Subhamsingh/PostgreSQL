
-- Count the number of Movies vs TV Shows

select count(*), type from netflix group by type ;

-- Find the most common rating for movies and TV shows

select type , rating from(
	select type,rating, count(*), rank() over(partition by type order by count(*))
	as RK from netflix group by type ,rating) as tv where RK=1;

-- List all movies released in a specific year (e.g., 2020)

select * from netflix where type='Movie' and release_year = 2020;

-- Find the top 5 country with the most content on Netflix

select unnest(string_to_array(country , ',' )) as country, 
	count(show_id) as total_content
	from netflix group by 1 order by 2 desc limit 5;


-- Identify the longest movie

select  * from netflix
	WHERE type = 'Movie' and duration=(
	select max(duration) from netflix
	);

-- Find content added in the last 5 years

SELECT  * FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'
 

-- Find all the movies/TV shows by director 'Rajiv Chilaka'!
select  director from netflix where director = 'Rajiv Chilaka';
	
-- List all TV shows with more than 5 seasons

SELECT * FROM netflix
WHERE type = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::numeric > 5;
	
-- Count the number of content items in each genre

SELECT 
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre ,
	count(*) as content FROM netflix group by 1; 
	 
-- Find each year and the average numbers of content release in India on netflix.
-- return top 5 year with highest avg content release!

select country,  count(*) as content_release,
	extract( year from to_date(date_added , 'Month DD , yyyy')) as year,
	 round(count(*):: numeric/(SELECT COUNT(*) FROM netflix WHERE country = 'India') *100,2) as Avg_content_relaes
	from netflix WHERE country = 'India' group by country,year;


SELECT 
    country,
    release_year,
    COUNT(show_id) AS total_release,
    ROUND(
        COUNT(show_id)::numeric /
        (SELECT COUNT(show_id) FROM netflix WHERE country = 'India')::numeric * 100, 2
    ) AS avg_release
FROM netflix
WHERE country = 'India'
GROUP BY country, release_year
ORDER BY avg_release DESC
LIMIT 5;	
-- List all movies that are documentaries

select * from netflix where listed_in like '%Documentaries';

-- Find all content without a director

select * from netflix where  director is null;

-- Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT  * FROM netflix 
	WHERE casts LIKE '%Salman Khan%' and
	release_year>= EXTRACT(YEAR FROM CURRENT_DATE)-10

-- Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT 
	unnest(string_to_array(casts,',')) as actors,
	count(*) as highest_No_of_movies FROM netflix 
	where country = 'India' group by 1 order by 2 desc limit 10
	
--Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content containing these keywords as 'Bad' and all other
   content as 'Good'. Count how many items fall into each category.
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
	
SELECT     
    COUNT(*) AS content_count
FROM  netflix  where description Ilike '%kill%' 
or description Ilike '%violence%'