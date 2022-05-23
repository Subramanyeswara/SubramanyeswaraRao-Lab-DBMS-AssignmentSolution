create database ecommerce;
use ecommerce;

create table if not exists supplier (
SUPP_ID int unsigned not null primary key auto_increment, 
SUPP_NAME varchar(50) not null, 
SUPP_CITY varchar(50) not null, 
SUPP_PHONE varchar(10) not null);

create table if not exists customer (
CUS_ID int unsigned not null primary key auto_increment, 
CUS_NAME varchar(20) not null, 
CUS_PHONE varchar(10) not null, 
CUS_CITY varchar(30) not null, 
CUS_GENDER enum('M','F'));

create table if not exists category (
CAT_ID int unsigned not null primary key auto_increment, 
CAT_NAME varchar(20) not null);

Alter table  category add column PARENT_CAT_ID int, add foreign key (PARENT_CAT_ID) REFERENCES category(CAT_ID);

-- copy queries from show create table response
-- show create table category;
-- CREATE TABLE `category` (
--   `CAT_ID` int NOT NULL,
--   `CAT_NAME` varchar(20) NOT NULL,
--   PRIMARY KEY (`CAT_ID`)
-- );
-- copy queries from show create table response

create table if not exists product(
PRO_ID int unsigned not null primary key auto_increment, 
PRO_NAME varchar(20) not null default('dummy'), 
PRO_DESC varchar(60), 
CAT_ID int unsigned not null, 
constraint FK_CAT_ID foreign key (CAT_ID) references category(CAT_ID));

create table if not exists supplier_pricing(
PRICING_ID int unsigned not null primary key auto_increment, 
PRO_ID int, 
SUPP_ID int, 
SUPP_PRICE int default(0), 
constraint FK_PRO_ID foreign key (PRO_ID) references product(PRO_ID), 
constraint FK_SUPP_ID foreign key (SUPP_ID) references supplier(SUPP_ID));

create table if not exists `order` (
ORD_ID int unsigned not null primary key auto_increment, 
ORD_AMOUNT int not null, 
ORD_DATE date not null, 
CUS_ID int, 
PRICING_ID int, constraint FK_CUS_ID foreign key (CUS_ID) 
references customer(CUS_ID), 
constraint FK_PRICING_ID foreign key (PRICING_ID) 
references supplier_pricing(PRICING_ID)) auto_increment=101;

-- alter table `order` auto_increment=101;
create table if not exists rating (
RAT_ID int unsigned not null primary key auto_increment, 
ORD_ID int unsigned not null, 
RAT_RATSTARS int unsigned not null, 
constraint FK_ORD_ID foreign key (ORD_ID) references `order`(ORD_ID));



insert into supplier (SUPP_NAME, SUPP_CITY, SUPP_PHONE) values 
("Rajesh Retails", "Delhi", "1234567890"),
("Appario Ltd.", "Mumbai", "2589631470"),
("Knome products", "Banglore", "9785462315"),
("Bansal Retails", "Kochi", "8975463285"),
("Mittal Ltd.", "Lucknow", "7898456532");


insert into customer (CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) values
("AAKASH", "9999999999", "DELHI",   "M"),
("AMAN",	  "9785463215", "NOIDA",   "M"),
("NEHA",   "9999999999", "MUMBAI",  "F"),
("MEGHA",  "9994562399", "KOLKATA", "F"),
("PULKIT", "7895999999", "LUCKNOW", "M");

insert into category (CAT_NAME) values
("BOOKS"),
("GAMES"),
("GROCERIES"),
("ELECTRONICS"),
("CLOTHES");

insert into product (PRO_NAME, PRO_DESC, CAT_ID) values
("GTA V" 					,"Windows 7 and above with i5 processor and 8GB RAM"	 		,2),
("TSHIRT" 					,"SIZE-L with Black, Blue and White variations" 				,5),
("ROG LAPTOP" 				,"Windows 10 with 15inch screen, i7 processor, 1TB SSD" 		,4),
("OATS" 						,"Highly Nutritious from Nestle" 								,3),
("HARRY POTTER" 				,"Best Collection of all time by J.K Rowling" 					,1),
("MILK" 						,"1L Toned MIlk" 												,3),
("Boat Earphones" 			,"1.5Meter long Dolby Atmos" 									,4),
("Jeans" 					,"Stretchable Denim Jeans with various sizes and color" 		,5),
("Project IGI" 				,"compatible with windows 7 and above" 							,2),
("Hoodie" 					,"Black GUCCI for 13 yrs and above" 							,5),
("Rich Dad Poor Dad"	 	,"Written by RObert Kiyosaki" 									,1),
("Train Your Brain" 		,"By Shireen Stephen" 											,1);


insert into supplier_pricing(PRO_ID, SUPP_ID, SUPP_PRICE) values
(1, 2, 1500),
(3, 5, 30000),
(5, 1, 3000),
(2, 3, 2500),
(4, 1, 1000);




-- insert into `order` (ORD_ID, ORD_AMOUNT, ORD_DATE, CUS_ID, PRICING_ID) values
-- (101, 1500 	,"2021/10/06", 2, 1),
-- (102, 1000 	,"2021/10/12", 3, 5),
-- (103, 30000	,"2021/09/16", 5, 2),
-- (104, 1500 	,"2021/10/05", 1, 1),
-- (105, 3000 	,"2021/08/16", 4, 3),
-- (106, 1450 	,"2021/08/18", 1, 9),
-- (107, 789 	,"2021/09/01", 3, 7),
-- (108, 780 	,"2021/09/07", 5, 6),
-- (109, 3000 	,"2021/00/10", 5, 3),
-- (110, 2500 	,"2021/09/10", 2, 4),
-- (111, 1000 	,"2021/09/15", 4, 5),
-- (112, 789 	,"2021/09/16", 4, 7),
-- (113, 31000	,"2021/09/16", 1, 8),
-- (114, 1000 	,"2021/09/16", 3, 5),
-- (115, 3000 	,"2021/09/16", 5, 3),
-- (116, 99 	,"2021/09/17", 2, 14);


-- the above query failed because of wrong PRICING_ID
-- so modified as below

insert into `order` (ORD_AMOUNT, ORD_DATE, CUS_ID, PRICING_ID) values
(1500 	,"2021/10/06", 2, 1),
(1000 	,"2021/10/12", 3, 5),
(30000	,"2021/09/16", 5, 2),
(1500 	,"2021/10/05", 1, 1),
(3000 	,"2021/08/16", 4, 3),
(1450 	,"2021/08/18", 1, 3),
(789 	,"2021/09/01", 3, 2),
(780 	,"2021/09/07", 5, 5),
(3000 	,"2021/00/10", 5, 3),
(2500 	,"2021/09/10", 2, 4),
(1000 	,"2021/09/15", 4, 5),
(789 	,"2021/09/16", 4, 1),
(31000	,"2021/09/16", 1, 2),
(1000 	,"2021/09/16", 3, 5),
(3000 	,"2021/09/16", 5, 3),
(99 	,"2021/09/17", 2, 4);



insert into rating (ORD_ID, RAT_RATSTARS) values
(101, 4),
(102, 3),
(103, 1),
(104, 2),
(105, 4),
(106, 3),
(107, 4),
(108, 4),
(109, 3),
(110, 5),
(111, 3),
(112, 4),
(113, 2),
(114, 1),
(115, 1),
(116, 0);


-- Queries

-- 3) Display the total number of customers based on gender who have placed orders of worth at least Rs.3000

-- select CUS_ID from `order` where ORD_AMOUNT>3000; -- 1,5
-- select CUS_GENDER from customer where CUS_ID=1; -- Male
-- select CUS_GENDER from customer where CUS_ID=5; -- Male
-- tried changing the order amount for a Female customer
-- update `order` set ORD_AMOUNT=10000 where ORD_ID=102;

-- Solution: tested for male and female both.
-- select CUS_GENDER, count(*) from customer where CUS_ID in (select CUS_ID from `order` where ORD_AMOUNT>=3000) group by CUS_GENDER;
-- look into this

select count(*), c.CUS_GENDER from customer as c inner join `order` as o on c.CUS_ID = o.CUS_ID where o.ORD_AMOUNT>=3000 group by c.CUS_GENDER;

-- 4) Display all the orders along with product name ordered by a customer having Customer_Id=2

-- select pricing ids for customer with id 2
-- select PRICING_ID from `order` where CUS_ID=2; -- find all PRICING_ID for customer 2
-- select orders for customer with id 2
-- select `order`.ORD_ID, customer.CUS_NAME from `order` inner join customer on `order`.CUS_ID=customer.CUS_ID where `order`.CUS_ID=2; -- find all ORD_ID for customer 2

select supplier.SUPP_NAME, product.PRO_NAME, supplier_pricing.PRICING_ID, `order`.ORD_ID, customer.CUS_NAME from `order` 
inner join customer on `order`.CUS_ID=customer.CUS_ID 
inner join supplier_pricing on `order`.PRICING_ID=supplier_pricing.PRICING_ID
inner join supplier on supplier.SUPP_ID=supplier_pricing.SUPP_ID
inner join product on supplier_pricing.PRO_ID=product.PRO_ID
where `order`.CUS_ID=2;

-- select `order`.ORD_ID, supplier_pricing.PRICING_ID from `order` inner join supplier_pricing on `order`.CUS_ID=supplier_pricing.CUS_ID where `order`.CUS_ID=2; -- find all ORD_ID for customer 2
-- find product ids for the orders made by customer with id 2
-- select PRO_ID from supplier_pricing where PRICING_ID in (select PRICING_ID from `order` where CUS_ID=2);
-- find product name from product
-- select PRO_NAME from product where PRO_ID in (select PRO_ID from supplier_pricing where PRICING_ID in (select PRICING_ID from `order` where CUS_ID=2));


-- 5) Display the Supplier details who can supply more than one product.
-- select SUPP_ID from supplier_pricing group by SUPP_ID having count(SUPP_ID)>1; -- gives suppliers who can supply more than one item
-- solution
-- select * from supplier where SUPP_ID in (select SUPP_ID from supplier_pricing group by SUPP_ID having count(SUPP_ID)>1);

select s.SUPP_NAME, count(p.PRO_NAME) as product_count from supplier as s inner join supplier_pricing as sp on s.SUPP_ID=sp.SUPP_ID
inner join product as p on p.PRO_ID=sp.PRO_ID group by s.SUPP_NAME having count(p.PRO_NAME)>1;

-- 6) Find the least expensive product from each category and print the table with 
--   category id, name, product name and price of the product

-- display category id, category name, product name and price of the product

select p.PRO_NAME, min(sp.SUPP_PRICE), sp.SUPP_ID from product as p inner join supplier_pricing as sp on p.PRO_ID=sp.PRO_ID
group by p.PRO_ID;

select * from supplier where SUPP_ID=5;
select PRO_ID, min(SUPP_PRICE) from supplier_pricing group by PRO_ID, SUPP_ID;

select cat.CAT_ID, cat.CAT_NAME, p.PRO_NAME, sp.SUPP_PRICE from category as cat
inner join product as p on cat.CAT_ID=p.CAT_ID
inner join supplier_pricing as sp on sp.PRO_ID=p.PRO_ID
group by cat.CAT_NAME having min(sp.SUPP_PRICE);


-- 7) Display the Id and Name of the Product ordered after “2021-10-05”.
select PRICING_ID from `order` where ORD_DATE > '2021-10-05';
select PRO_ID from supplier_pricing where PRICING_ID in (select PRICING_ID from `order` where ORD_DATE > '2021-10-05');
select PRO_ID, PRO_NAME from product where PRO_ID in (select PRO_ID from supplier_pricing where PRICING_ID in (select PRICING_ID from `order` where ORD_DATE > '2021-10-05'));




-- 8) Display customer name and gender whose names start or end with character 'A'.
select CUS_NAME, CUS_GENDER from customer where CUS_NAME like "A%" or CUS_NAME like "%A";

-- 9) Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent
-- Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.

-- inner join order and rating
-- select `order`.ORD_ID, `order`.PRICING_ID, rating.RAT_RATSTARS from `order` inner join rating where `order`.ORD_ID=rating.ORD_ID;
select `order`.PRICING_ID, avg(rating.RAT_RATSTARS) as rating, case 
when avg(rating.RAT_RATSTARS)=5 then 'Excellent Service'
when avg(rating.RAT_RATSTARS)>4 then 'Good Service'
when avg(rating.RAT_RATSTARS)>2 then 'Average Service'
else 'Poor Service' end as Type_of_Service from `order` 
inner join rating where `order`.ORD_ID=rating.ORD_ID group by `order`.PRICING_ID;


-- supplier_pricing has PRICING_ID as PK, SUPP_ID as fk
-- supplier has SUPP_ID as PK

-- find average rating for each order based on PRICING_ID




