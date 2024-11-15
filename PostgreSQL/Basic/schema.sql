CREATE TABLE region (
    id integer primary key NOT NULL ,
    name character(50)
);


CREATE TABLE sales_reps (
    id integer primary key not null,
    name character(50),
    region_id integer,
   constraints sales_const foreign key(region_id) references region(id) on delete cascade
);


create table accounts(
id int primary key not null,
name char(50),
website char(50),
lat numeric,
long numeric,
primary_poc char(50),
sales_rep_id int,
constraint fk_account foreign key(sales_rep_id) references sales_reps(id) on delete cascade
);


CREATE TABLE orders (
    id integer primary key not null,
    account_id int,
    occurred_at timestamp without time zone,
    standard_qty int,
    gloss_qty int,
    poster_qty int,
    total integer,
    standard_amt_usd numeric,
    gloss_amt_usd numeric,
    poster_amt_usd numeric,
    total_amt_usd numeric,
    constraint fk_orders foreign key(account_id) references accounts(id) on delete cascade
);


CREATE TABLE web_events (
    id int primary key not null,
    account_id integer,
    occurred_at timestamp without time zone,
    channel char(50),
    constraint fk_web foreign key(account_id) references accounts(id) on delete cascade
);




