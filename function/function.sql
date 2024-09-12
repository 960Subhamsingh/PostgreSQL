create or replace function emp(emp_NO int) returns 
table (emp_id int, first_name varchar)
as $$
begin
return query
select emp_id , first_name from employees where emp_id =2;
end;
$$language plpgsql;

select sum(emp_id) over (order by last_name) from employee

select * from customer;

create or replace function mer_no()
returns trigger as $$
begin
if new.mer_id<0 then
new.mer_id=0;
end if;
return new;
end;
$$ language plpgsql;



