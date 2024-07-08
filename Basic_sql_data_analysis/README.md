## Questions

### 1. What is the total amount each customer spent at the restaurant?


### 2. How many days has each customer visited the restaurant?


#### 3. What was the first item from the menu purchased by each customer?

1. Create a CTE and join the sales and menu tables.
2. Use the row_number window function to give a unique row number to every item purchased by the customer.
3. Order the items by the order_date
4.  Select customer_id and product_name for every item where the row_number is '1'

#### 4. What is the most purchased item on the menu and how many times was it purchased by all customers?


#### 5. Which item was the most popular for each customer?

1. Create a CTE and join the sales and menu tables.
2. Use the rank window function to rank every item purchased by the customer.
3. Order the items by the numbers or times purchase  in descending order (highest to lowest).
4.  Select 'everything' for every item where the rank is '1'.



**Note** customer_id: **B** had a tie with all three items on the menu.

#### 6. Which item was purchased first by the customer after they became a member?

1. Create a CTE and join the sales and menu tables to the members table.
2. Use the rank window function to rank every item purchased by the customer.
3. Order the items by the numbers or times purchase in ascending order (lowest to highest).
4. Filter the results to orders made after the join date.
5. Select customer and product where rank = '1'.



#### 7. Which item was purchased just before the customer became a member?

1. Create a CTE and join the sales and menu tables to the members table.
2. Use the rank window function to rank every item purchased by the customer.
3. Order the items by the numbers or times purchase in descending order (highest to lowest).
4. Filter the results to orders made before the join date.
5. Select customer and product where rank = '1'.


#### 8. What is the total items and amount spent for each member before they became a member?

1. Create a CTE and join the sales and menu tables to the members table.
2. Get the customer_id, total number of items and the total amount spent.
3. Filter the results to orders made before the join date.
4. Group by the customer id.


#### 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

1. Create a CTE and join the sales and menu tables to the members table.
2. Use a case statement inside of the sum function to calculate total points including 2x multiplier.
3. Filter the results to orders made before the join date.
4. Group by the customer id.


#### 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

1. Create a CTE and join the sales and menu tables to the members table.
2. Use a case statement inside of the sum function to calculate total points including 2x multiplier.
3. If the order is after membship or within the 6 days after membership then use the 2x multiplier on all items. Else, only on sushi.
4. Filter the results to orders made in Jan 2021.
5. Group by the customer id.

