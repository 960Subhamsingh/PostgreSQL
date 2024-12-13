create table random_t ( id int , val decimal);

insert into random_t
select 1, random() from generate_series(1, 10000000);

insert into random_t
select 2, random() from generate_series(1, 100000);

select * from random_t;

select id , avg(val), count(*)  from random_t group by id;

create materialized view mv_random_t 
	as
	select id , avg(val), count(*)
	from random_t group by id;

select * from mv_random_t ;
	
delete from random_t  where id = 1;

refresh materialized view mv_random_t ;


create view vw_random_t 
	as
	select id , avg(val), count(*)
	from random_t group by id;

select * from vw_random_t 