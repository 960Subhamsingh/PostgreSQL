CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER,
   "Delivery_date"	DATE
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id", "Delivery_date")
VALUES
  ('A', '2021-01-01', '1','2021-01-04'),
  ('A', '2021-01-01', '2','2021-01-04'),
  ('A', '2021-01-07', '2','2021-01-15'),
  ('A', '2021-01-10', '3','2021-01-15'),
  ('A', '2021-01-11', '3','2021-01-15'),
  ('A', '2021-01-11', '3','2021-01-15'),
  ('B', '2021-01-01', '2','2021-01-15'),
  ('B', '2021-01-02', '2','2021-01-15'),
  ('B', '2021-01-04', '1','2021-01-15'),
  ('B', '2021-01-11', '1','2021-01-15'),
  ('B', '2021-01-16', '3','2021-01-15'),
  ('B', '2021-02-01', '3','2021-01-15'),
  ('C', '2021-01-01', '3','2021-01-15'),
  ('C', '2021-01-01', '3','2021-01-15'),
  ('C', '2021-01-07', '3','2021-01-15');


CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);


INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  (1,'Rice', 12),
  (2,'Sugar', 15),
   (3, 'Brd', 12),
   (4, 'Curry', 12),
	(5, 'Trea', 16),
	(6, 'Bengo', 19),
	(7, 'Kurke', 18),
  (8, 'a', 12);


CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
	('B', '2021-01-09'),
	('C', '2021-01-17'),
	('D', '2021-02-27'),
	('E', '2021-02-07'),
	('F', '2021-03-07'),
	('G', '2021-03-07'),
  ('H', '2021-04-09');