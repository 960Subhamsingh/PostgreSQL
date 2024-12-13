
1. See the version of postgreSQL

```
   select  version();
```

## **Create a table named cars in your PostgreSQL database:**

```
 CREATE TABLE cars (
  brand VARCHAR(255),
  model VARCHAR(255),
  year INT
  );
```

## insert one row of data into the cars table

```
 INSERT INTO cars (brand, model, year)
 VALUES ('Ford', 'Mustang', 1964);
```

## Insert Multiple Rows of cars table

```
 INSERT INTO cars (brand, model, year)
 VALUES  ('Volvo', 'p1800', 1968),
         ('BMW', 'M1', 1978),
         ('Toyota', 'Celica', 1975);
```
## Display the By specifying the column names

```
  select  brand, model, year from cars;
```

## select all columns in the cars table: 

```
select * from cars;
```

## add color column in the car table

```
 Alter table cars add color varchar(12);
```
## The UPDATE statement is used to modify the value(s) in existing records of the cars table

```
update cars set color='red' where brand= 'Volvo';
```

## Update Multiple Columns with seprate comma(,) 

```
UPDATE cars SET color = 'white', year = 1970
WHERE brand = 'Toyota';
```

## The ALTER TABLE statement is used to add, delete, or modify columns in an existing cars table.

## The ALTER TABLE statement is also used to add and drop various constraints on an existing cars table.

```
ALTER TABLE cars
ALTER COLUMN year TYPE VARCHAR(4);

ALTER TABLE cars
ALTER COLUMN color TYPE VARCHAR(30);

ALTER TABLE cars
DROP COLUMN color;
```
## The DELETE statement is used to delete existing records with and without condition  in a table.

```
DELETE FROM cars WHERE brand = 'Volvo';

DELETE FROM cars;

```

## Truncate statement are used to delete all the record with existing table

```
+ syntax
Truncate table Table_name;
```
## The DROP TABLE statement is used to drop an existing table in a database.

```
+ syntax 

drop table table_name

```

## Reference of with statement

[with statement](<https://www.postgresql.org/docs/current/queries-with.html>)