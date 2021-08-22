USE window_functions;

SELECT id, total_price,placed,
			SUM(total_price) OVER(ORDER BY placed ROWS UNBOUNDED PRECEDING) AS sum_
		FROM single_orders;

UPDATE single_orders SET placed=str_to_date(placed, '%d-%m-%Y');
SELECT *,
SUM(total_price) OVER(ORDER BY placed ROWS UNBOUNDED PRECEDING) AS running_total,
SUM(total_price) OVER(ORDER BY placed ROWS between 3 PRECEDING and 3 FOLLOWING) AS sum_3_before_after
FROM single_orders;

/* For each order, show its id, the placed date, and the third column which will count the number of orders up to the current 
order when sorted by the placed date. */
SELECT *,
count(*) over(order by placed ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Count_rows
FROM single_orders;

/*Warehouse workers always need to pick the products for orders by hand and one by one. For positions with order_id = 5, 
calculate the remaining sum of all the products to pick. For each position from that order, show its id, the id of the product, 
the quantity and the quantity of the remaining items (including the current row) when sorted by the id in the ascending order.*/
SELECT *,
sum(quantity) over(order by id ROWS BETWEEN CURRENT ROW and UNBOUNDED FOLLOWING)
FROM order_position
WHERE order_id=5;

/*Now, for each single_order, show its placed date, total_price, the average price calculated by taking 2 previous orders, 
the current order and 2 following orders (in terms of the placed date) and the ratio of the total_price to the average price 
calculated as before.*/
SELECT *,
AVG(total_price) OVER(order by placed ROWS BETWEEN 2 preceding AND 2 FOLLOWING) AS Avg_of_5, 
total_price/(AVG(total_price) OVER(order by placed ROWS BETWEEN 2 preceding AND 2 FOLLOWING)) AS comparison
FROM single_orders;

UPDATE stock_exchange SET changed = str_to_date(changed, '%d-%m-%Y');
/*Pick those stock changes which refer to product_id = 3. For each of them, show the id, changed date, quantity, 
and the running total, indicating the current stock status. Sort the rows by the changed date in the ascending order.*/
SELECT *,
SUM(quantity) OVER(ORDER BY 'changed' ROWS UNBOUNDED PRECEDING) AS running_total
FROM stock_exchange
WHERE product_id=3;

/*--For each single_order, show its placed date, total_price and the average price from the current single_order 
and three previous orders (in terms of the placed date).*/
SELECT *
FROM single_orders;
