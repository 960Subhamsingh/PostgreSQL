create or replace procedure update_product(
	N_brand char(15),
	p_category char(12)
	)
language plpgsql
as $$
begin
update product set brand=N_brand where product_category=p_category;
end;
$$;

call update_product('Dell','Laptop');

create or replace procedure add_product(
	N_brand char(15),
	p_category char(12)
	)
language plpgsql
as $$
begin
 insert into product (product_category, brand) values (N_brand, p_category);
end;
$$;

call add_product('Dell','Laptop');

select * from product;


