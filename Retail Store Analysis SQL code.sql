USE retail_store;
SELECT *
FROM tr_orderdetails;

#1. Maximum quantity sold in a transaction
SELECT MAX(Quantity) AS max_quantity, COUNT(*) as total_number_of_transactions
FROM tr_orderdetails;

#2. Unique products in all the transactions
SELECT DISTINCT(ProductName)
FROM tr_orderdetails
LEFT JOIN tr_products
ON tr_orderdetails.ProductID = tr_products.ProductID
ORDER BY ProductName;

#3. Total quanity sold of each product
SELECT tr_products.ProductID ,tr_products.ProductName, SUM(Quantity) AS Total_Quantity
FROM tr_orderdetails
LEFT JOIN tr_products
ON tr_orderdetails.ProductID = tr_products.ProductID
GROUP BY ProductID
ORDER BY Total_Quantity asc;


#4 Maximum quanity sold of each product
SELECT DISTINCT
tr_products.ProductID ,tr_products.ProductName, Quantity
FROM tr_orderdetails
LEFT JOIN tr_products
ON tr_orderdetails.ProductID = tr_products.ProductID
WHERE quantity=3
ORDER BY  tr_products.ProductID, Quantity asc;

#5. Unique properties
SELECT DISTINCT
PropertyID
FROM tr_orderdetails
ORDER BY PropertyID;

#6.Product category with maximum products
SELECT ProductCategory, COUNT(*) AS total_number_of_products
FROM tr_products
GROUP BY ProductCategory
ORDER BY total_number_of_products DESC;

#7.State where most stores are present
SELECT
PropertyState, 
COUNT(*) AS total_number_of_stores
FROM tr_propertyinfo
GROUP BY PropertyState
ORDER BY total_number_of_stores DESC;

#8 Top 5 products by quantity
SELECT tr_products.ProductID ,tr_products.ProductName, SUM(Quantity) AS Total_Quantity
FROM tr_orderdetails
LEFT JOIN tr_products
ON tr_orderdetails.ProductID = tr_products.ProductID
GROUP BY ProductID
ORDER BY Total_Quantity desc
LIMIT 5;

#9 Top 5 properties that sold highest quantities
SELECT
tr_orderdetails.PropertyID,
tr_propertyinfo.PropertyCity,
tr_propertyinfo.PropertyState,
SUM(tr_orderdetails.Quantity) AS total_quantity
FROM tr_orderdetails
LEFT JOIN tr_propertyinfo
on tr_orderdetails.PropertyID=tr_propertyinfo.`Prop ID`
GROUP BY tr_orderdetails.PropertyID
ORDER BY 4 DESC
LIMIT 5 ;

#10 Top 5 products by currency sales
SELECT tr_products.ProductID ,tr_products.ProductName, SUM(tr_orderdetails.Quantity*tr_products.Price) AS Total_Sales
FROM tr_orderdetails
LEFT JOIN tr_products
ON tr_orderdetails.ProductID = tr_products.ProductID
GROUP BY ProductID
ORDER BY Total_Sales desc
LIMIT 5;

#10 Top 5 cities that had maximum currency sales
SELECT
tr_propertyinfo.PropertyCity,
SUM(tr_orderdetails.Quantity * tr_products.Price) AS Total_Sales
FROM tr_orderdetails
LEFT JOIN tr_products
ON tr_orderdetails.ProductID=tr_products.ProductID
LEFT JOIN tr_propertyinfo
ON tr_orderdetails.PropertyID=tr_propertyinfo.`Prop ID`
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

#11 Top 5 products by sales in each city
SELECT
tr_propertyinfo.PropertyCity,
tr_products.ProductName,
SUM(tr_orderdetails.Quantity * tr_products.Price) AS Total_Sales
FROM tr_orderdetails
LEFT JOIN tr_products
ON tr_orderdetails.ProductID=tr_products.ProductID
LEFT JOIN tr_propertyinfo
ON tr_orderdetails.PropertyID=tr_propertyinfo.`Prop ID`
GROUP BY 1,2
ORDER BY 1,3 DESC;
