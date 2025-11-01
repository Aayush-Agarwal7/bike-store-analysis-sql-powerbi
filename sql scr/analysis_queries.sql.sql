--What is the total sales revenue, total orders, and average order value across all stores?
--Gives overall business health summary.

WITH order_table AS (
SELECT o.order_id, SUM(oi.quantity*oi.list_price*(1-oi.discount)) AS total_order
FROM sales.orders AS o
JOIN sales.order_items AS oi ON 
o.order_id = oi.order_id
GROUP BY o.order_id)
SELECT ROUND(SUM(total_order),2) AS total_revenue, COUNT(*) AS total_orders,
ROUND(AVG(total_order),2) AS average_order_value
FROM order_table;

--OR

SELECT ROUND(SUM(quantity*list_price*(1-discount)),2) AS total_revenue,
COUNT(DISTINCT order_id) AS total_order,
ROUND(AVG(quantity*list_price*(1-discount)),2) AS average_order_value
FROM sales.order_items;

SELECT ROUND(SUM(quantity*list_price*(1-discount)),2) AS total_revenue,
COUNT(DISTINCT order_id) AS total_order,
ROUND(SUM(quantity*list_price*(1-discount))/ COUNT (DISTINCT order_id),2) AS average_order_value
FROM sales.order_items;


--Which top 5 cities generated the highest sales revenue?
--Reveals strongest regional markets.

SELECT TOP 5 c.city, ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount)),2) AS revenue
FROM sales.order_items AS oi
JOIN sales.orders AS o ON
oi.order_id = o.order_id
JOIN sales.customers AS c ON
o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY revenue DESC

--Which product categories sell the most units and contribute the highest revenue?
--Identifies high-performing product segments.

SELECT c.category_name ,SUM(oi.quantity) AS unit_sold ,
ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount)),2) AS revenue
FROM sales.order_items AS oi
JOIN production.products AS p ON
oi.product_id = p.product_id
JOIN production.categories AS c ON
p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC


--Who are the top 10 customers by lifetime purchase value?
--Shows loyal / high-value customers.

SELECT TOP 10 c.customer_id,CONCAT(c.first_name,' ',c.last_name) AS full_name,
ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount)),2) AS purchase_value,
COUNT(DISTINCT(o.order_id)) AS order_count
FROM sales.customers AS C
JOIN sales.orders AS o ON
c.customer_id = o.customer_id
JOIN sales.order_items AS oi ON
o.order_id = oi.order_id
GROUP BY c.customer_id,CONCAT(c.first_name,' ',c.last_name)
ORDER BY purchase_value DESC


--Which store has the highest sales per customer ratio?
--Identifies most efficient store performance.

SELECT TOP 1 s.store_name,
COUNT(DISTINCT(o.customer_id)) AS unique_customer ,
ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount)),2) AS revenue,
ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount))/ COUNT(DISTINCT o.customer_id),2) AS revenur_per_customer
FROM sales.order_items AS oi 
JOIN sales.orders AS o ON
o.order_id = oi.order_id
JOIN sales.customers AS c ON
o.customer_id = c.customer_id
JOIN sales.stores AS s ON
o.store_id = s.store_id
GROUP BY s.store_name
ORDER BY revenur_per_customer DESC


--What are the most profitable brands based on revenue and quantity sold?
--Highlights which brand partnerships are most valuable.

SELECT  b.brand_name,SUM(oi.quantity) AS unit_sold ,
ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount)),2) AS revenue
FROM sales.order_items AS oi
JOIN production.products AS p ON
oi.product_id = p.product_id
JOIN production.brands AS b ON 
p.brand_id = b.brand_id
GROUP BY b.brand_name
ORDER BY revenue DESC

--Which months are the peak and lowest sales periods?
--Useful for planning marketing & stock inventory.


--TOP 3 sales month

SELECT TOP 3 FORMAT(o.order_date,'yyyy-MMM') AS sales_month,
ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount)),2) AS revenue
FROM sales.order_items AS oi 
JOIN sales.orders AS o ON
o.order_id = oi.order_id
GROUP BY FORMAT(o.order_date,'yyyy-MMM')
ORDER BY revenue DESC

--Top 3 lowest sales month 
SELECT TOP 3 FORMAT(o.order_date,'yyyy-MMM') AS sales_month,
ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount)),2) AS revenue
FROM sales.order_items AS oi 
JOIN sales.orders AS o ON
o.order_id = oi.order_id
GROUP BY FORMAT(o.order_date,'yyyy-MMM')
ORDER BY revenue 

WITH monthly_sales AS (SELECT FORMAT(o.order_date,'yyyy-MMM') AS sales_month,
ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount)),2) AS revenue,
ROW_NUMBER() OVER (ORDER BY SUM(oi.quantity*oi.list_price*(1-oi.discount)) DESC) revenue_desc,
ROW_NUMBER() OVER (ORDER BY SUM(oi.quantity*oi.list_price*(1-oi.discount)) ASC) revenue_asc
FROM sales.order_items AS oi 
JOIN sales.orders AS o ON
o.order_id = oi.order_id
GROUP BY FORMAT(o.order_date,'yyyy-MMM')
)
SELECT sales_month,revenue,CASE
WHEN revenue_desc = 1 THEN 'Peak Month'
WHEN revenue_asc = 1 THEN 'Lowest Month'
ELSE NULL
END AS sales_flag
FROM monthly_sales
WHERE revenue_desc = 1 OR revenue_asc = 1



--What is the month-over-month revenue growth rate for the last two years?
--Reveals business growth trend.

WITH last_two_year_revenue AS (
SELECT YEAR(o.order_date) AS sales_year,
FORMAT(o.order_date,'MMM') AS sales_month,
DATEPART(MONTH,o.order_date) AS month_number,
ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount)),2) AS revenue
FROM sales.order_items AS oi 
JOIN sales.orders AS o ON
o.order_id = oi.order_id
WHERE YEAR(o.order_date) IN (2017,2018)
GROUP BY YEAR(o.order_date),
FORMAT(o.order_date,'MMM'),DATEPART(MONTH,o.order_date)
)
SELECT sales_year,sales_month,revenue,
LAG(revenue) OVER (ORDER BY sales_year,month_number) AS pre_month_rev,
CASE 
WHEN LAG(revenue) OVER (ORDER BY sales_year,month_number) IS NULL THEN NULL
ELSE 
CONCAT(ROUND(((revenue - LAG(revenue) OVER (ORDER BY sales_year,month_number))/
LAG(revenue) OVER (ORDER BY sales_year,month_number))*100,2),'%')
END AS MOM_revenue_growth
FROM last_two_year_revenue



--Which products are often out of stock (low quantity in stock vs. sales volume)?
--Highlights potential supply chain gaps.

WITH sold AS (
SELECT oi.product_id,SUM(oi.quantity) AS total_sold_quantity
FROM sales.order_items AS oi
GROUP BY oi.product_id
),
stock AS (
SELECT s.product_id, SUM(s.quantity) AS total_stock_quantity
FROM production.stocks AS S 
GROUP BY s.product_id
),
final_quary AS (
SELECT p.product_id,p.product_name,
COALESCE(sold.total_sold_quantity,0) AS sold_quantity,
COALESCE(stock.total_stock_quantity,0) AS stock_quantity,
CASE
WHEN COALESCE(stock.total_stock_quantity,0) = 0 THEN 'Out of Stock'
WHEN COALESCE(sold.total_sold_quantity,0) > 0 AND 
COALESCE(stock.total_stock_quantity,0) <(sold.total_sold_quantity/10.0) THEN 'Low Quantity'
ELSE 'Okay'
END AS stock_status
--10% of the total units sold (historically)
--If a product has sold a lot in the past, and its current stock is less than 10% of that, it might run out soon.
FROM production.products AS P
LEFT JOIN sold ON 
p.product_id = sold.product_id
LEFT JOIN stock ON
p.product_id = stock.product_id
)
SELECT * FROM final_quary
ORDER BY 
CASE
WHEN stock_status = 'Out of Stock' THEN 1
WHEN stock_status = 'Low Quantity' THEN 2
ELSE 3
END


--Which cities have the highest customer order frequency?
--Helps decide where to open new stores or run ads.

SELECT TOP 5 c.city,COUNT(o.order_id) AS total_order, COUNT(DISTINCT(o.customer_id)) AS unique_customer,
CAST(ROUND(COUNT(o.order_id)*1.0 / COUNT(DISTINCT(o.customer_id)),2) AS FLOAT) AS avg_order_per_cust
FROM sales.customers AS C
JOIN sales.orders AS o ON
c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY Total_order DESC



--How do discounts impact total revenue 
--Understands discounting strategy works.

SELECT (oi.discount*100) AS [discount%],
ROUND(SUM(oi.quantity*oi.list_price),2) AS gross_revenue,
ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount)),2) AS net_revenue,
COUNT(DISTINCT(oi.order_id)) as total_order,
ROUND(SUM(oi.quantity*oi.list_price*oi.discount),2) AS discount_value
FROM sales.order_items AS oi
GROUP BY (oi.discount*100)


--What is the repeat purchase rate (customers with >1 order)?
--Measures customer loyalty & satisfaction.

WITH customer_order AS (SELECT DISTINCT(o.customer_id),COUNT(o.order_id) AS no_of_orders
FROM sales.orders AS O
GROUP BY (o.customer_id)
--HAVING COUNT(o.order_id) >1
), RPR AS(
SELECT COUNT(*) AS total_customer,
COUNT(CASE WHEN no_of_orders >1 THEN 1
END) AS repet_customer
FROM customer_order
)
SELECT *,CONCAT(ROUND((CAST(repet_customer AS FLOAT)/total_customer)*100,2),'%') AS repeat_purchase_rate
FROM RPR




--Which product combinations are most frequently bought together?
--Supports cross-selling or combo offers.

SELECT p1.product_name,p2.product_name,COUNT(*) AS times_bought_together
FROM sales.order_items AS oi1
JOIN sales.order_items AS oi2 ON
oi1.order_id = oi2.order_id
AND oi1.product_id < oi2.product_id --avoid duplicates and self pairs
JOIN production.products AS p1
ON oi1.product_id = p1.product_id
JOIN production.products AS p2
ON oi2.product_id = p2.product_id
GROUP BY p1.product_name,p2.product_name
ORDER BY times_bought_together DESC

--Which products have declining sales trends year-over-year?
--Identifies products to discontinue or relaunch

WITH yoy_revenue AS (SELECT p.product_id, p.product_name,
YEAR(o.order_date) AS sale_year,
ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount)),2) AS sales_value
FROM sales.orders AS o
JOIN sales.order_items AS oi ON
o.order_id = oi.order_id
JOIN production.products AS p ON
oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name,YEAR(o.order_date)
), pre_year_sale AS
(
SELECT *,COALESCE(LAG(sales_value) OVER(PARTITION BY product_id ORDER BY sale_year),0) AS prv_year_sale
FROM yoy_revenue
), yoy_trend AS (
SELECT *,ROUND((sales_value - prv_year_sale)/NULLIF(prv_year_sale,0),2)*100 AS [yoy_trend%]
FROM pre_year_sale
)
SELECT * FROM yoy_trend
WHERE [yoy_trend%] <0


--What is the seasonal category demand pattern (by month)?
--Forecasts inventory and staffing needs.

WITH mom_pattern AS (SELECT c.category_id,c.category_name,
DATENAME(MONTH,o.order_date) AS sales_month,
SUM(oi.quantity) AS total_quantity_sold,
ROUND(SUM(oi.quantity*oi.list_price*(1-oi.discount)),2) AS sales_value
FROM production.products AS p
JOIN sales.order_items AS oi ON
p.product_id = oi.product_id
JOIN sales.orders AS o ON 
oi.order_id = o.order_id
JOIN production.categories AS c ON
p.category_id = c.category_id
GROUP BY c.category_id,c.category_name,DATENAME(MONTH,o.order_date)
)
SELECT *,
ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY total_quantity_sold DESC) AS rank_base_on_quantity_month
FROM mom_pattern



				
