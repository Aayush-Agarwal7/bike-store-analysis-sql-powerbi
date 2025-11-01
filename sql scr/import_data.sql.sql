--Create Database
CREATE DATABASE Bike_Stores;

USE Bike_Stores;

-- Create Schemas

CREATE SCHEMA production;
CREATE SCHEMA sales;

--Use Production Schema

CREATE TABLE production.categories(
category_id INT PRIMARY KEY,
category_name VARCHAR(100) NOT NULL);

CREATE TABLE production.brands(
brand_id INT PRIMARY KEY,
brand_name VARCHAR(100) NOT NULL);

CREATE TABLE production.products(
product_id INT PRIMARY KEY,
product_name VARCHAR(100) NOT NULL,
brand_id INT FOREIGN KEY REFERENCES production.brands(brand_id),
category_id INT FOREIGN KEY REFERENCES production.categories(category_id),
model_year INT NOT NULL,
list_price FLOAT NOT NULL);

CREATE TABLE production.stocks(
store_id INT NOT NULL,
product_id INT FOREIGN KEY REFERENCES production.products(product_id),
quantity INT NOT NULL);
-- store_id is FK, which will be added after the creation of the store table


--Use sales schema 

CREATE TABLE sales.customers(
customer_id INT PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
phone INT NULL,
email VARCHAR(100) NOT NULL,
street VARCHAR(100) NOT NULL,
city VARCHAR(100) NOT NULL,
state_ VARCHAR(100) NOT NULL,
zip_code INT NOT NULL);

CREATE TABLE sales.order_items(
order_id INT NOT NULL,
item_id INT PRIMARY KEY,
product_id INT FOREIGN KEY REFERENCES production.products(product_id),
quantity INT NOT NULL,
list_price FLOAT NOT NULL,
discount FLOAT );
	
--order_id is FK, which will be added after the creation of the orders table

CREATE TABLE sales.staffs(
staff_id INT PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100),
email VARCHAR(100),
phone INT,
active INT,
store_id INT NOT NULL,
manager_id INT NOT NULL);

--store_id and manager_id are FK, which will be added after the creation of the stores table

CREATE TABLE sales.stores(
store_id INT PRIMARY KEY,
store_name VARCHAR(100) NOT NULL,
phone VARCHAR (50),
email VARCHAR(100),
street VARCHAR(100),
city VARCHAR(100),
state_ VARCHAR(100),
zip_code VARCHAR(100)
);

CREATE TABLE sales.orders(
order_id INT PRIMARY KEY,
customer_id INT FOREIGN KEY REFERENCES sales.customers(customer_id),
order_status INT NOT NULL,
order_date DATE NOT NULL,
required_date DATE,
shipped_date date,
store_id INT FOREIGN KEY REFERENCES	sales.stores(store_id),
staff_id INT FOREIGN KEY REFERENCES sales.staffs(staff_id)
);

--Add FK 


ALTER TABLE production.stocks 
ADD FOREIGN KEY (store_id)
REFERENCES sales.stores(store_id);

ALTER TABLE sales.customers
ALTER COLUMN phone VARCHAR(50);

ALTER TABLE sales.customers
ALTER COLUMN zip_code VARCHAR(50);

ALTER TABLE sales.order_items
ADD FOREIGN KEY (order_id) REFERENCES sales.orders(order_id);

ALTER TABLE sales.staffs
ALTER COLUMN phone VARCHAR(50);

ALTER TABLE sales.staffs
ALTER COLUMN manager_id INT NULL;


ALTER TABLE sales.staffs
ADD FOREIGN KEY (manager_id)
REFERENCES sales.staffs(staff_id);

ALTER TABLE sales.order_items
ADD PRIMARY KEY (order_id,item_id) 

ALTER TABLE production.stocks
ADD PRIMARY KEY (store_id,product_id)

ALTER TABLE production.stocks
ALTER COLUMN product_id INT NOT NULl



--create Index 

CREATE INDEX idx_orders_orderdate	
ON sales.orders(order_date);

CREATE INDEX idx_order_items_orderid
ON sales.order_items(order_id);

CREATE INDEX idx_order_items_productid
ON sales.order_items(product_id);

--Data Insert

BULK INSERT production.brands FROM 'E:\Project\Bike Stores Data\brands.csv'
WITH (FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');

BULK INSERT production.categories FROM 'E:\Project\Bike Stores Data\categories.csv'
WITH (FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');

BULK INSERT production.products FROM 'E:\Project\Bike Stores Data\products.csv'
WITH (FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');

BULK INSERT production.stocks FROM 'E:\Project\Bike Stores Data\stocks.csv'
WITH (FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');

BULK INSERT sales.customers FROM 'E:\Project\Bike Stores Data\customers.csv'
WITH (FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');

BULK INSERT sales.stores FROM 'E:\Project\Bike Stores Data\stores.csv'
WITH (FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');

BULK INSERT sales.staffs FROM 'E:\Project\Bike Stores Data\staffs.csv'
WITH (FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');

ALTER TABLE sales.order_items
DROP CONSTRAINT PK__order_it__52020FDD63F190B6

BULK INSERT sales.order_items FROM 'E:\Project\Bike Stores Data\order_items.csv'
WITH (FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');

BULK INSERT sales.orders FROM 'E:\Project\Bike Stores Data\orders.csv'
WITH (FIRSTROW = 2,FIELDTERMINATOR = ',',ROWTERMINATOR = '\n');




