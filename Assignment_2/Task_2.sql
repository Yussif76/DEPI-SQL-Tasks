USE StoreDB

SELECT * FROM production.products
WHERE list_price>1000

SELECT customer_id,state FROM sales.customers
WHERE state = 'CA' OR state = 'NY'

SELECT * FROM SALES.orders
WHERE order_date='2023'

SELECT * FROM sales.customers
WHERE email LIKE '%@gmail.com'

SELECT * FROM SALES.staffs
WHERE active=0

SELECT TOP 5 *  FROM  production.products
ORDER BY list_price DESC

select top 3 last_name
from sales.customers
order by last_name

select last_name,phone
from sales.customers
where phone is null

select *
from sales.staffs
where manager_id is not null

select category_id,count(*) as counte
from production.products
group by category_id


SELECT staff_id, COUNT(*) AS total_orders
FROM sales.orders
GROUP BY staff_id
ORDER BY total_orders DESC;

SELECT customer_id, COUNT(*) AS total_orders
FROM sales.orders
GROUP BY customer_id
HAVING COUNT(*) > 2;

select list_price
from production.products
where list_price between 500 and 1500


select customer_id,city
from sales.customers
where city like 's%'

select order_status
from sales.orders
where order_status=2 or order_status=4

select product_name,category_id
from production.products
where category_id in (1,2,3)

select * 
from sales.staffs
where store_id=1 or phone is null