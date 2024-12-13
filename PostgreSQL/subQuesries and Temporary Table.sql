/*
Find the average number of events for each day for each channel.
*/

SELECT channel, 
	AVG(num_events) avg_num_events
FROM (
	SELECT channel, 
		DATE_TRUNC('day', occurred_at),
    	COUNT(*) num_events
	FROM web_events
	GROUP BY 1, 2
  ) sub_table
GROUP BY channel;





/*
Use DATE_TRUNC to pull "month" level information about the first order
ever placed in the orders table. Use this result to find only the orders 
that took place in the same month-year combo as the first order and then 
pull the average for each type of paper 'qty' in this month and the total
amount spent on all orders.
*/

SELECT AVG(standard_qty) standard,
	AVG(gloss_qty) gloss,
    AVG(poster_qty) poster,
    SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
	(SELECT MIN(DATE_TRUNC('month', occurred_at))
	FROM orders)





/*
Provide the name of the sales_rep in each region with the largest amount 
of total_amt_usd sales.
*/

SELECT sub2.region,
	sub1.sales_rep, 
	sub2.total_amt_usd 
FROM (
	SELECT r.name region,
		s.name sales_rep,
    	SUM(o.total_amt_usd) total_amt_usd
	FROM orders o
	JOIN accounts a
	ON a.id = o.account_id
	JOIN sales_reps s
	ON s.id = a.sales_rep_id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY 1, 2
	) sub1
JOIN (
	SELECT region,
		MAX(total_amt_usd) total_amt_usd
	FROM (
		SELECT r.name region,
			s.name sales_rep,
		    SUM(o.total_amt_usd) total_amt_usd
		FROM orders o
		JOIN accounts a
		ON a.id = o.account_id
		JOIN sales_reps s
		ON s.id = a.sales_rep_id
		JOIN region r
		ON r.id = s.region_id
		GROUP BY 1, 2
		) sub
	GROUP BY 1
	) sub2
ON sub1.region = sub2.region
	AND sub1.total_amt_usd = sub2.total_amt_usd
ORDER BY 3;





/*
For the region with the largest (sum) of sales total_amt_usd, how many 
total (count) orders were placed? 
*/

SELECT r.name region,
    SUM(o.total_amt_usd) total_amt_usd,
    COUNT(*)
FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;





/*
For the name of the account that purchased the most (in total over their 
lifetime as a customer) standard_qty paper, how many accounts still had 
more in total purchases?
*/

SELECT COUNT(*)
FROM (
	SELECT a.name, SUM(o.total)
	FROM accounts a
	JOIN orders o
	ON o.account_id = a.id
	GROUP BY a.name
	HAVING SUM(o.total) > (
      	SELECT total
      	FROM (
			SELECT SUM(o.standard_qty) standard_qty,
      			SUM(o.total) total 
			FROM orders o
			GROUP BY account_id
			ORDER BY 1 DESC
			LIMIT 1
			)sub1
      	)
	)sub;





/*
For the customer that spent the most (in total over their lifetime as a 
customer) total_amt_usd, how many web_events did they have for each 
channel?
*/

SELECT channel,
	w.account_id,
	COUNT(*)
FROM web_events w
JOIN (
	SELECT o.account_id, SUM(o.total_amt_usd)
	FROM orders o
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1
	) sub
ON sub.account_id = w.account_id
GROUP BY 1, 2
ORDER BY 3 DESC;





/*
What is the lifetime average amount spent in terms of total_amt_usd for 
the top 10 total spending accounts?
*/

SELECT AVG(total)
FROM (
	SELECT account_id, 
		SUM(total_amt_usd) total
	FROM orders
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10
	) sub;





/*
What is the lifetime average amount spent in terms of total_amt_usd for 
only the companies that spent more than the average of all orders.
*/

SELECT AVG(total_amt_usd)
FROM (
	SELECT account_id,
		AVG(total_amt_usd) total_amt_usd
	FROM orders
	GROUP BY account_id
	) sub
WHERE total_amt_usd > 
	(SELECT AVG(total_amt_usd) total_amt_usd
	FROM orders)





/*
Provide the name of the sales_rep in each region with the largest amount 
of total_amt_usd sales.
*/

WITH 
	sub1 AS (
		SELECT r.name region,
			s.name sales_rep,
	    	SUM(o.total_amt_usd) total_amt_usd
		FROM orders o
		JOIN accounts a
		ON a.id = o.account_id
		JOIN sales_reps s
		ON s.id = a.sales_rep_id
		JOIN region r
		ON r.id = s.region_id
		GROUP BY 1, 2
		),

	sub2 AS (
		SELECT region,
			MAX(total_amt_usd) total_amt_usd
		FROM sub1
		GROUP BY 1
		)

SELECT sub2.region,
	sub1.sales_rep, 
	sub2.total_amt_usd
FROM sub1
JOIN sub2
ON sub1.region = sub2.region
	AND sub1.total_amt_usd = sub2.total_amt_usd
ORDER BY 3;





/*
For the region with the largest (sum) of sales total_amt_usd, how many 
total (count) orders were placed? 
*/

SELECT r.name region,
    SUM(o.total_amt_usd) total_amt_usd,
    COUNT(*)
FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;





/*
For the name of the account that purchased the most (in total over their 
lifetime as a customer) standard_qty paper, how many accounts still had 
more in total purchases?
*/

WITH
	sub1 AS (
		SELECT SUM(o.standard_qty) standard_qty,
  			SUM(o.total) total 
		FROM orders o
		GROUP BY account_id
		ORDER BY 1 DESC
		LIMIT 1
		),

	sub2 AS (
		SELECT a.name, SUM(o.total)
		FROM accounts a
		JOIN orders o
		ON o.account_id = a.id
		GROUP BY a.name
		HAVING SUM(o.total) > (SELECT total FROM sub1)
		)

SELECT COUNT(*)
FROM sub2;





/*
For the customer that spent the most (in total over their lifetime as a 
customer) total_amt_usd, how many web_events did they have for each 
channel?
*/

WITH 
	sub AS (
		SELECT o.account_id, SUM(o.total_amt_usd)
		FROM orders o
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 1
		)

SELECT channel,
	w.account_id,
	COUNT(*)
FROM web_events w
JOIN sub
ON sub.account_id = w.account_id
GROUP BY 1, 2
ORDER BY 3 DESC;





/*
What is the lifetime average amount spent in terms of total_amt_usd 
for the top 10 total spending accounts?
*/

WITH 
	sub AS (
		SELECT account_id, 
			SUM(total_amt_usd) total
		FROM orders
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 10
		)

SELECT AVG(total)
FROM sub;





/*
What is the lifetime average amount spent in terms of total_amt_usd 
for only the companies that spent more than the average of all orders.
*/

WITH
	sub AS (
		SELECT account_id,
			AVG(total_amt_usd) total_amt_usd
		FROM orders
		GROUP BY account_id
		)

SELECT AVG(total_amt_usd)
FROM sub
WHERE total_amt_usd > 
	(SELECT AVG(total_amt_usd) total_amt_usd
	FROM orders)



/*
Write a query with FULL OUTER JOIN to see:
- each account who has a sales rep and each sales rep that 
has an account (all of the columns in these returned rows 
will be full)
- but also each account that does not have a sales rep and 
each sales rep that does not have an account (some of the 
columns in these returned rows will be empty)
*/

SELECT a.*,
	s.id AS s_id,
    s.name AS s_name,
    s.region_id AS r_id
FROM accounts a
FULL OUTER JOIN sales_reps s 
ON a.sales_rep_id = s.id;





/*
Write a query that left joins the accounts table and the 
sales_reps tables on each sale rep's ID number and joins it 
using the < comparison operator on accounts.primary_poc and 
sales_reps.name, like so:
	`accounts.primary_poc < sales_reps.name`
The query results should be a table with three columns: the 
account name (e.g. Johnson Controls), the primary contact 
name (e.g. Cammy Sosnowski), and the sales representative's 
name (e.g. Samuel Racine). 
*/

SELECT a.name,
	a.primary_poc,
    s.name AS sales_rep
FROM accounts a
LEFT JOIN sales_reps s
ON a.sales_rep_id = s.id
	AND a.primary_poc < s.name;





/*
Use SELF JOIN to find we events that occur one after another
within 1 day for each account.
*/

SELECT w1.channel w1_channel,
	w1.id w1_id,
    w1.account_id w1_aid,
	w1.occurred_at w1_time,
	w2.channel w2_channel,
    w2.id w2_id,
    w2.account_id w2_aid,
	w2.occurred_at w2_time
FROM web_events w1
LEFT JOIN web_events w2
ON w1.account_id = w2.account_id
	AND w1.occurred_at < w2.occurred_at
    AND w1.occurred_at + INTERVAL '1 day' >= w2.occurred_at
ORDER BY 1, 2;





/*
Write a query that uses UNION ALL on two instances (and selecting
all columns) of the accounts table. 
*/

SELECT *
FROM accounts

UNION ALL

SELECT *
FROM accounts;





/*
Add a WHERE clause to each of the tables that you unioned in the 
query above, filtering the first table where name equals Walmart 
and filtering the second table where name equals Disney.
*/

SELECT *
FROM accounts
WHERE name = 'Walmart'

UNION ALL

SELECT *
FROM accounts
WHERE name = 'Disney';





/*
Perform the union in your first query (under the Appending Data via 
UNION header) in a common table expression and name it double_accounts. 
Then do a COUNT the number of times a name appears in the 
double_accounts table. If you do this correctly, your query results 
should have a count of 2 for each name.
*/

WITH double_accounts AS ( 
  	SELECT *
	FROM accounts
	
	UNION ALL

	SELECT *	
	FROM accounts
)
  
SELECT name, COUNT(*)
FROM double_accounts
GROUP BY name;