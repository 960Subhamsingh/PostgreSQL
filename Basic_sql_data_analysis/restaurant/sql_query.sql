-- display all the existing records
select * from sales 
select * from  menu

update menu set product_name = 'bread'  where product_id =3

--1. What is the total amount each customer spent at the restaurant?

SELECT 	customer_id  ,sum(price) AS TOTAL FROM SALES 
JOIN MENU ON menu.product_id = sales.product_id
GROUP BY customer_id;

-- 2. How many days has each customer visited the restaurant?

select customer_id,  count(order_date) as days from sales  group by customer_id

-- 3. What was the first item from the menu purchased by each customer?
	
WITH cte_first_item AS
(select customer_id, product_name, 
	Row_number() over(partition by sales.customer_id order by
	(sales.order_date , sales.product_id )) as RN
	from sales join menu on sales.product_id = menu.product_id	 
	) select customer_id, product_name from cte_first_item where RN = 1
	
-- 4. What is the most purchased item on the menu and how many times was it
	purchased by all customers?

select product_name ,  count(menu.product_id) from menu join sales
	on sales.product_id = menu.product_id 
	group by product_name limit 1;

-- 5. Which item was the most popular for each customer?

WITH CTE_MOST_POPULAR AS
(select customer_id , product_name ,
	Rank() over(partition by customer_id order by count(menu.product_id)) as rk
	from sales join menu on sales.product_id = menu.product_id
	group by customer_id , product_name 
	)
select * from CTE_MOST_POPULAR where rk = 1


-- 6. Which item was purchased first by the customer after they became a member?


-- find prices of all products on 2024-09-10. Assume the price of all products before any change is 10. 

select a.product_id , a.change_date, b.new_price
from base a left join Productpri b on a.product_id b.product._id
and a.change_date = b.change_date;



