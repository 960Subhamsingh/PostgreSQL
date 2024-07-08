-- display all the existing records
select * from sales 
select * from  menu

--1. What is the total amount each customer spent at the restaurant?

SELECT 	customer_id  ,sum(price) AS TOTAL FROM SALES 
JOIN MENU ON menu.product_id = sales.product_id
GROUP BY customer_id;

-- 2. How many days has each customer visited the restaurant?

select customer_id,  count(order_date) as days from sales  group by customer_id

-- 3. What was the first item from the menu purchased by each customer?

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?


