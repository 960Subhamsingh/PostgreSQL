
-- Questions and Answers

create table with Query in the sql Command line


COPY WORDS FROM '** Path to your **/csv/words.csv'
DELIMITER ',';

-- ctreate table words 

ctreate table words (word varchar(50));

-- LOAD CSV FILE

\copy words from 'D:\Project\PostgreSQL\Basic\Pratice Qxample\csv\words.csv' with csv header


-- SQL Words Query 

-- How many words are in our table?
	SELECT
	COUNT(*) AS TOTAL_NO_OF_ROWS
FROM
	WORDS;

-- find the 'shaker' from words table?

SELECT
	WORD AS GREAT_WORD
FROM
	WORDS
WHERE
	WORD = 'shaker';

-- How many words contain 'shaker'?

SELECT
	COUNT(*) AS TOTAL_SHAKER
FROM
	WORDS
WHERE
	WORD = 'shaker';

--How many words start with the letter 'j'?

SELECT
	COUNT(*) AS NO_OF_WORDS
FROM
	WORDS where word like 'j%';

--How many words  letters long?

SELECT
	CHAR_LENGTH(WORD) AS WORD_LENGTH,
	COUNT(*) AS WORD_COUNT
FROM
	WORDS
WHERE
	CHAR_LENGTH(WORD) > 1
GROUP BY
	WORD_LENGTH;

-- How many words contain 'jaime'?

SELECT
	COUNT(*) AS TOTAL_NAME
FROM
	WORDS
WHERE
	WORD LIKE '%jaime%';

-- What is the longest word in this table and how many characters does it contain?
SELECT
	word as "longest word",
	length(word) as "word Length"
FROM
	WORDS
WHERE
	LENGTH(WORD) = (
		SELECT
			MAX(LENGTH(WORD))
		FROM
			WORDS
	);

-- the average length of a word?

SELECT
	AVG(LENGTH(WORD)) AVG_LENGTH
FROM
	WORDS;

-- What is the word count for every letter in the words table  and what is the percentage of the total? Sort by letter in ascending order.

SELECT 
	letter,
	word_count,
	round((word_count::float / (SELECT count(*) FROM words)*100)::NUMERIC, 2) AS total_percentage
from
	(SELECT
		SUBSTRING(LOWER(word), 1, 1) AS letter,
		COUNT(*) AS word_count
	FROM
		words
	GROUP BY
		letter) AS tmp
GROUP BY 
	letter,
	word_count
ORDER BY
	letter;

-- What row number is the word 'shaker' in?

SELECT
	ROW_NUM AS "Row Number",
	WORD AS "Cool Last Name"
FROM
	(
	SELECT
		WORDS.*,
			ROW_NUMBER() OVER() AS ROW_NUM
	FROM
		WORDS) AS ROW
WHERE
	WORD = 'shaker';


 -- Find the count of all the palindromes (Excluding single and two letter words)

SELECT
	COUNT(*) AS n_palindromes
FROM
	WORDS
WHERE
	WORD = REVERSE(WORD)
	AND LENGTH(WORD) >= 3;

-- Find the first 10 of all the palindromes that begin with the letter 'r' (Excluding single and two letter words)

SELECT
	WORD AS s_palindromes
FROM
	WORDS
WHERE
	WORD = REVERSE(WORD)
	AND LENGTH(WORD) >= 3
	AND word LIKE 'r%'
ORDER BY
	WORD
LIMIT 10;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            

-- Return the 15th palindrome (Excluding single and double letter words) of words that start with the letter 's'

SELECT
	WORD AS "15th_s_palindrome"
FROM
	WORDS
WHERE
	WORD = REVERSE(WORD)
	AND LENGTH(WORD) >= 3
	AND word LIKE 's%'
ORDER BY
	WORD
LIMIT 1 
OFFSET 14;


-- Find the row number for every month of the year and sort them in chronological order

SELECT
	ROW_NUM AS "Row Number",
	WORD AS "Month"
FROM
	(
	SELECT
		WORDS.*,
			ROW_NUMBER() OVER() AS ROW_NUM
	FROM
		WORDS) AS ROW
WHERE
	WORD IN (
	'january',
	'february',
	'march',
	'april',
	'may',
	'june',
	'july',
	'august',
	'september',
	'october',
	'november',
	'december')
ORDER BY
	TO_DATE(WORD, 'Month');


-- Convert words that contain 'shaker' to uppercase and concatnate their length (#)


SELECT
	upper(WORD) || ' (' || length(word) || ')' AS upper_case
FROM
	WORDS
WHERE
	WORD LIKE '%shaker%';