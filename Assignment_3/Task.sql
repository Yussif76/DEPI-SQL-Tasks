--1. Count the total number of products in the database.
SELECT COUNT(product_id)
FROM production.products

--2. Find the average, minimum, and maximum price of all products.
SELECT AVG(list_price) AS AVERAGE,MAX(list_price) AS MAXIMUM,MIN(list_price) AS MINIMUM
FROM production.products

--3. Count how many products are in each category.
SELECT COUNT(*) AS products_in_category
FROM production.products P
JOIN production.categories C
ON P.category_id=C.category_id

--4. Find the total number of orders for each store.
SELECT s.store_name, COUNT(o.order_id) AS total_orders
FROM sales.orders o
JOIN sales.stores s ON o.store_id = s.store_id
GROUP BY s.store_name;

--5. Show customer first names in UPPERCASE and last names in lowercase for the first 10 customers.
SELECT  TOP 10 UPPER(first_name),LOWER(last_name)
FROM SALES.customers

--6. Get the length of each product name. Show product name and its length for the first 10 products.
SELECT TOP 10 product_name,LEN(product_name)
FROM production.products

--7. Format customer phone numbers to show only the area code (first 3 digits) for customers 1-15.
SELECT TOP 15 LEFT(phone,3)
FROM SALES.customers

--8. Show the current date and extract the year and month from order dates for orders 1-10.
SELECT GETDATE() 
SELECT TOP 10 YEAR([order_date]) AS YEAR,MONTH([order_date]) AS MONTH
FROM sales.orders

--9. Join products with their categories. Show product name and category name for first 10 products.
SELECT TOP 10 P.product_name,C.category_name
FROM [production].[categories] C
JOIN [production].[products] P
ON P.category_id=C.category_id

--10. Join customers with their orders. Show customer name and order date for first 10 orders.
SELECT TOP 10 C.first_name,O.order_date
FROM [sales].[orders] O
JOIN [sales].[customers] C
ON O.customer_id=C.customer_id

--11. Show all products with their brand names, even if some products don't have brands. Include product name, brand name 
SELECT P.product_name,B.brand_name
FROM [production].[brands] B
RIGHT JOIN [production].[products] P
ON P.brand_id= B.brand_id

--12. Find products that cost more than the average product price. Show product name and price.
SELECT product_name,list_price
FROM [production].[products]
WHERE list_price>(SELECT AVG(list_price)
FROM [production].[products]
)

--13. Find customers who have placed at least one order. Use a subquery with IN. Show customer_id and customer_name.
SELECT customer_id,first_name
FROM [sales].[customers]
WHERE customer_id IN (SELECT customer_id FROM [sales].[orders])

--14. For each customer, show their name and total number of orders using a subquery in the SELECT clause.
SELECT first_name+' '+last_name AS NAME
,(SELECT COUNT([order_id]) FROM [sales].[orders] O WHERE C.customer_id =O.customer_id )
FROM [sales].[customers] C

--15. Create a simple view called easy_product_list that shows product name, category name, and price. Then write a query to select all products from this view where price > 100.

CREATE VIEW easy_product_list AS
SELECT P.product_name,C.category_name,P.list_price
FROM [production].[products] P
JOIN [production].[categories] C 
ON P.list_price=C.category_id

SELECT * FROM easy_product_list
WHERE list_price>40

--16. Create a view called customer_info that shows customer ID, full name (first + last), email, and city and state combined. Then use this view to find all customers from California (CA).
CREATE VIEW customer_info AS
SELECT customer_id,CONCAT(first_name,' ',last_name) AS FULL_NAME,city,state
FROM [sales].[customers]

SELECT * FROM customer_info
WHERE state LIKE '%CA'

--17. Find all products that cost between $50 and $200. Show product name and price, ordered by price from lowest to highest.
SELECT product_name,list_price 
FROM [production].[products]
WHERE list_price BETWEEN 50 AND 100
ORDER BY list_price ASC

--18. Count how many customers live in each state. Show state and customer count, ordered by count from highest to lowest.
SELECT state,COUNT(customer_id) AS customer_count
FROM [sales].[customers]
GROUP BY state
ORDER BY customer_count DESC

--19. Find the most expensive product in each category. Show category name, product name, and price.
SELECT C.category_name,P.[product_name],P.[list_price]
FROM [production].[products] P
JOIN [production].[categories] C ON P.category_id=C.category_id
WHERE P.list_price = (
SELECT MAX(list_price)
FROM production.products
WHERE category_id=P.category_id
)

