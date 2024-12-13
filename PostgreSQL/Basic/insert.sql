insert into  region values 
(1, 'Asia'),
(2,'Europe');
 (3,'Americas'),
 (4,'Asia'),
 (5,'Africa');

insert into sales_reps values
	(1,'Shivam',1);
insert into sales_reps values
	(3,'Robert',3),
	(4,'johan' , 2),
	(5,'Mohan',2),
	(6,'Johan kumar',4),
	(7,'Rita',2),
	(8,'sonia',2),
	(9,'SriRam',1),
	(10,'Joseph',5),
	(11,'David',4),
    (12,'Michael',2);

insert into accounts values
(10,'subham kumar','subm.com',122.0,122.788,'kumar',1),
(112,'subham kumar','subm.com',122.0,122.78,'kumar',4),
(102,'subham kumar','sham.com',122.0,122.78,'kumar',1),
(103,'subham kumar','subm.com',122.0,122.78,'kumar',1),
(104,'subham kumar','su.com',122.0,122.768,'kumar',1),
(105,'subham kumar','sham.com',122.0,122.784,'kumar',1),
(106,'subham kumar','sbm.com',122.0,122.785,'kumar',1),
(111,'subham kumar','sam.com',122.0,122.782,'kumar',5),
(110,'subham kumar','sbam.com',122.0,122.787,'kumar',3),
(109,'subham kumar','suam.com',122.0,122.768,'kumar',5),
(108,'subham kumar','suam.com',122.0,122.718,'kumar',2),
(113,'subham kumar','subm.com',122.0,122.798,'kumar',1),
(114,'subham kumar','am.com',122.0,122.781,'kumar',2),
(115,'subham kumar','sum.com',122.0,122.712,'kumar',1);

insert into orders (id,account_id, occurred_at,standard_qty,gloss_qty,poster_qty, total ) values
(12,102,'2012-03-01',1200,23,34,782);


insert into web_events values
  (12, 102,now(),'starsub');
insert into web_events values
(13, 103,'2012-12-06','starsub1'),
(14, 104, '2012-11-06','starsb1'),
(15, 105,'2012-12-06','strsub1'),
(16, 108,'2011-10-03','starb1');

commit;

