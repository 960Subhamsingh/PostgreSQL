CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(10, 2)
);

-- INSERT DATA WITH PROCEDURE 

CREATE OR REPLACE PROCEDURE add_employee(
	p_id int,
    p_name VARCHAR(100),
    p_position VARCHAR(100),
    p_salary DECIMAL(10, 2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert the new employee record into the table
    INSERT INTO employees ( id, name, position, salary)
    VALUES (p_id, p_name, p_position, p_salary);
    
    -- Optionally, you can raise a notice (optional logging/feedback)
    RAISE NOTICE 'Employee added successfully: %, %, %', p_name, p_position, p_salary;
END;
$$;


CALL add_employee(12,'John Doe', 'Software Engineer', 75000);
CALL add_employee(15,'RAM', 'Engineer', 55000);


SELECT * FROM employees;

create or replace procedure sel_employee(E_salary float)
language plpgsql
as $$
declare
E_name varchar(120);
E_salary float;
begin 
	 FOR emp IN
	select name , salary into E_name , E_salary from employees where salary = E_salary;
 
end;
$$;

call sel_employee(5500)





CREATE OR REPLACE PROCEDURE get_employees_by_position(p_position VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    -- SELECT statement to fetch employees with the specified position
    FOR emp IN
        SELECT id, name, position
        FROM employees
        WHERE position = p_position
    LOOP
        -- You can perform operations inside the loop (e.g., print data or process it)
        RAISE NOTICE 'Employee ID: %, Name: %, Position: %', emp.id, emp.name, emp.position;
    END LOOP;
END;
$$;

 