
--  1) create Database ecommerece and tables for supplier,customer,category,product,supplier_pricing,order,rating
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE IF NOT EXISTS supplier(
SUPP_ID INT AUTO_INCREMENT,
SUPP_NAME VARCHAR(50) NOT NULL,
SUPP_CITY VARCHAR(50) NOT NULL,
SUPP_PHONE VARCHAR(50) NOT NULL,
PRIMARY KEY(SUPP_ID));

CREATE TABLE IF NOT EXISTS customer(
CUS_ID INT AUTO_INCREMENT,
CUS_NAME VARCHAR(20) NOT NULL,
CUS_PHONE VARCHAR(10) NOT NULL,
CUS_CITY VARCHAR(30) NOT NULL,
CUS_GENDER ENUM('M', 'F', 'O'),
PRIMARY KEY(CUS_ID) );

CREATE TABLE IF NOT EXISTS category(
CAT_ID INT AUTO_INCREMENT,
CAT_NAME VARCHAR(20) NOT NULL,
PRIMARY KEY(CAT_ID) );

CREATE TABLE IF NOT EXISTS product(
PRO_ID INT AUTO_INCREMENT,
PRO_NAME VARCHAR(20) NOT NULL DEFAULT ('Dummy'),
PRO_DESC VARCHAR(60),
CAT_ID INT NOT NULL,
PRIMARY KEY(PRO_ID),
CONSTRAINT `FK_CAT_ID` FOREIGN KEY (CAT_ID) REFERENCES category(CAT_ID));

CREATE TABLE IF NOT EXISTS supplier_pricing(
PRICING_ID INT AUTO_INCREMENT,
PRO_ID INT NOT NULL,
SUPP_ID INT NOT NULL,
SUPP_PRICE INT DEFAULT (0),
PRIMARY KEY(PRICING_ID),
CONSTRAINT `FK_PRO_ID` FOREIGN KEY (PRO_ID) REFERENCES product(PRO_ID), 
CONSTRAINT `FK_SUPP_ID` FOREIGN KEY (SUPP_ID) REFERENCES supplier(SUPP_ID));

CREATE table IF NOT EXISTS `order` (
ORD_ID INT AUTO_INCREMENT, 
ORD_AMOUNT INT NOT NULL, 
ORD_DATE DATE NOT NULL, 
CUS_ID INT NOT NULL, 
PRICING_ID INT NOT NULL,
PRIMARY KEY(ORD_ID),
CONSTRAINT `FK_PRICING_ID` FOREIGN KEY (PRICING_ID) REFERENCES supplier_pricing(PRICING_ID),
CONSTRAINT `FK_CUS_ID` FOREIGN KEY (CUS_ID) REFERENCES customer(CUS_ID)) auto_increment=101;
 
CREATE table IF NOT EXISTS rating (
RAT_ID INT AUTO_INCREMENT,
ORD_ID INT 
NOT NULL,
RAT_RATSTARS INT NOT NULL,
PRIMARY KEY(RAT_ID),
CONSTRAINT `FK_ORD_ID` FOREIGN KEY (ORD_ID) REFERENCES `order`(ORD_ID) );


-- 2) Insert the following data in the table created above 
 
INSERT INTO supplier (SUPP_NAME, SUPP_CITY, SUPP_PHONE) VALUES 
("Rajesh Retails", "Delhi", "1234567890"),
("Appario Ltd.", "Mumbai", "2589631470"),
("Knome products", "Banglore", "9785462315"),
("Bansal Retails", "Kochi", "8975463285"),
("Mittal Ltd.", "Lucknow", "7898456532");

INSERT INTO customer (CUS_NAME, CUS_PHONE, CUS_CITY, CUS_GENDER) VALUES 
("AAKASH","9999999999","DELHI","M"),
("AMAN","9785463215","NOIDA","M"),
("NEHA","9999999999","MUMBAI","F"),
("MEGHA","9994562399","KOLKATA","F"),
("PULKIT","7895999999","LUCKNOW","M");

INSERT INTO category (CAT_NAME) VALUES
("BOOKS"),
("GAMES"),
("GROCERIES"),
("ELECTRONICS"),
("CLOTHES");

INSERT INTO product (PRO_NAME, PRO_DESC, CAT_ID) VALUES
("GTA V","Windows 7 and above with i5 processor and 8GB RAM","2"),
("TSHIRT","SIZE-L with Black, Blue and White variations","5"),
("ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD","4"),
("OATS","Highly Nutritious from Nestle","3"),
("HARRY POTTER","Best Collection of all time by J.K Rowling","1"),
("MILK","1L Toned MIlk","3"),
("Boat Earphones","1.5Meter long Dolby Atmos","4"),
("Jeans","Stretchable Denim Jeans with various sizes and color","5"),
("Project","IGI compatible with windows 7 and above","2"),
("Hoodie","Black GUCCI for 13 yrs and above","5"),
("Rich Dad Poor Dad","Written by RObert Kiyosaki","1"),
("Train Your Brain","By Shireen Stephen","1");

INSERT INTO supplier_pricing (PRO_ID, SUPP_ID, SUPP_PRICE) VALUES
(1, 2, 1500),
(3, 5, 30000),
(5, 1, 3000),
(2, 3, 2500),
(4, 1, 1000);

INSERT INTO `order`(ORD_AMOUNT, ORD_DATE, CUS_ID, PRICING_ID) VALUES
(1500 	,"2021/10/06", 2, 1),
(1000 	,"2021/10/12", 3, 5),
(30000	,"2021/09/16", 5, 2),
(1500 	,"2021/10/05", 1, 1),
(3000 	,"2021/08/16", 4, 3),
(1450 	,"2021/08/18", 1, 3),
(789 	,"2021/09/01", 3, 2),
(780 	,"2021/09/07", 5, 5),
(3000 	,"2021/01/10", 5, 3),
(2500 	,"2021/09/10", 2, 4),
(1000 	,"2021/09/15", 4, 5),
(789 	,"2021/09/16", 4, 1),
(31000	,"2021/09/16", 1, 2),
(1000 	,"2021/09/16", 3, 5),
(3000 	,"2021/09/16", 5, 3),
(99 	,"2021/09/17", 2, 4);

INSERT INTO rating(ORD_ID, RAT_RATSTARS) VALUES
(101,4),
(102,3),
(103,1),
(104,2),
(105,4),
(106,3),
(107,4),
(108,4),
(109,3),
(110,5),
(111,3),
(112,4),
(113,2),
(114,1),
(115,1),
(116,0);



-- 3) Display the total number of customers based on gender who have placed orders of worth at least Rs.3000

SELECT C.CUS_GENDER, COUNT(DISTINCT C.CUS_ID) AS 'CUSTOMER COUNT'
FROM customer AS C 
INNER JOIN `order` AS O 
ON C.CUS_ID = O.CUS_ID
AND O.ORD_AMOUNT >= 3000
GROUP BY C.CUS_GENDER;



-- 4  Display all the orders along with product name ordered by a customer having Customer_Id=2

SELECT C.CUS_NAME, O.ORD_ID, P.PRO_NAME, S.SUPP_NAME
FROM `order` as O 
INNER JOIN customer as C ON O.CUS_ID = C.CUS_ID
INNER JOIN supplier_pricing as SP ON O.PRICING_ID = SP.PRICING_ID
INNER JOIN supplier as S ON S.SUPP_ID = SP.SUPP_ID
INNER JOIN product as P ON SP.PRICING_ID = P.PRO_ID
WHERE C.CUS_ID = 2;

-- 5) Display the Supplier details who can supply more than one product.

SELECT S.SUPP_ID, S.SUPP_NAME, S.SUPP_CITY, SUPP_PHONE, COUNT(SP.PRO_ID) as PRODUCT_COUNT
FROM supplier S
INNER JOIN supplier_pricing SP ON S.SUPP_ID = SP.SUPP_ID
GROUP BY S.SUPP_ID, S.SUPP_NAME, S.SUPP_CITY, SUPP_PHONE having count(SP.PRO_ID)>1;

-- 6) Find the least expensive product from each category and print the table with category id, name, product name and price of the product

SELECT C.CAT_ID, C.CAT_NAME, P.PRO_NAME, SP.SUPP_PRICE 
FROM category C
INNER JOIN product P ON C.CAT_ID = P.CAT_ID
INNER JOIN supplier_pricing SP ON SP.PRO_ID = P.PRO_ID
GROUP BY C.CAT_NAME HAVING MIN(SP.SUPP_PRICE); 

-- 7) Display the Id and Name of the Product ordered after “2021-10-05”.

SELECT P.PRO_ID, P.PRO_NAME, O.ORD_DATE 
FROM `order` O 
INNER JOIN supplier_pricing SP ON O.PRICING_ID = SP.PRICING_ID
INNER JOIN product P ON P.PRO_ID = SP.PRO_ID
and O.ORD_DATE > "2021-10-05";

-- 8) Display customer name and gender whose names start or end with character 'A'.

SELECT CUS_NAME, CUS_GENDER
FROM customer
WHERE CUS_NAME LIKE 'A%'
OR CUS_NAME LIKE '%A';

-- 9) Create a stored procedure to display supplier id, name, rating and Type_of_Service. 
--    For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, 
--    If rating >2 print “Average Service” else print “Poor Service”.


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `supplier_ratings`()
BEGIN
	SELECT S.SUPP_ID, S. SUPP_NAME, avg(R.RAT_RATSTARS) as Rating,
	CASE
		WHEN avg(R.RAT_RATSTARS) = 5 THEN 'Excellent Service'
		WHEN avg(R.RAT_RATSTARS) > 4 THEN 'Good Service'
		WHEN avg(R.RAT_RATSTARS) > 2 THEN 'Average Service' 
		ELSE "Poor Service"
	END as Rating_Seervice
	FROM supplier S
	INNER JOIN supplier_pricing SP ON S.SUPP_ID = SP.SUPP_ID
	INNER JOIN `order` O ON SP.PRICING_ID = O.PRICING_ID
	INNER JOIN rating R ON O.ORD_ID = R.ORD_ID
	GROUP BY S.SUPP_ID, S.SUPP_NAME ORDER BY S.SUPP_ID;
END$$
DELIMITER ;

--  Execute the Procedure
call supplier_ratings();

