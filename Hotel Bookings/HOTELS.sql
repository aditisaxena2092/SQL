CREATE DATABASE Hotels;
USE Hotels;
CREATE TABLE hotel_details(
                    booking_id integer not null,
                    customer_id bigint,
                    status text,
                    check_in text,
                    check_out text,
                    no_of_rooms integer,
                    hotel_id integer,
                    amount float,
                    discount float,
                    date_of_booking text);
UPDATE hotel_details SET check_in= str_to_date(check_in,"%d-%m-%Y");
UPDATE hotel_details SET check_out= str_to_date(check_out,"%d-%m-%Y");
UPDATE hotel_details SET date_of_booking= str_to_date(date_of_booking,"%d-%m-%Y");
SHOW TABLES;
CREATE TABLE city_details(
                          Hotel_id integer,
                          City text);

#1. Number of Hotels in the dataset
SELECT COUNT(distinct hotel_id) AS number_of_hotels
FROM hotel_details;

#2. Number of Hotels in different cities
SELECT city_details.City, COUNT(DISTINCT hotel_details.Hotel_id) AS Number_of_Hotels
FROM hotel_details
LEFT JOIN city_details
ON hotel_details.hotel_id=city_details.Hotel_id
GROUP BY 1
ORDER BY 2 DESC;

#3. Average room rate by cities
/*adding a column with total cost of booking*/
ALTER TABLE hotel_details ADD COLUMN Total_Price float;
UPDATE hotel_details SET Total_Price = amount + discount;
SELECT *
FROM hotel_details;
/*adding a column with number of nights per booking*/
ALTER TABLE hotel_details ADD COLUMN Number_of_nights_stayed integer;
UPDATE hotel_details SET Number_of_nights_stayed = datediff(check_out,check_in);
/*adding a column with rate*/
ALTER TABLE hotel_details ADD COLUMN Rate float;
UPDATE hotel_details SET Rate=round((Total_Price/(no_of_rooms*Number_of_nights_stayed)),2);
SELECT *
FROM hotel_details;
SELECT city_details.City, round(avg(Rate),0) AS Avg_Room_Rate
FROM hotel_details
LEFT JOIN city_details
ON hotel_details.hotel_id=city_details.Hotel_id
GROUP BY 1
ORDER BY 2 DESC;

#4. Cancellation Rate
ALTER TABLE hotel_details ADD COLUMN Cancelled_bookings integer;
UPDATE hotel_details SET Cancelled_bookings= (CASE WHEN hotel_details.status='Cancelled' THEN 1 ELSE 0 END);
SELECT * FROM hotel_details;
SELECT 
city_details.City,
COUNT(booking_id) AS Total_bookings,
SUM(Cancelled_bookings) AS Cancelled_bookings,
(SUM(Cancelled_bookings)/COUNT(booking_id)*100) AS Cancellation_Rate
FROM hotel_details
LEFT JOIN city_details
ON hotel_details.hotel_id=city_details.Hotel_id
GROUP BY 1
ORDER BY 4 DESC;

#5. Bookings by month
ALTER TABLE hotel_details ADD COLUMN MONTHS text;
UPDATE hotel_details SET MONTHS = month(check_in);
ALTER TABLE hotel_details ADD COLUMN Month_Name text;
UPDATE hotel_details SET Month_Name = (CASE WHEN MONTHS=1 THEN 'Jan' WHEN MONTHS=2 THEN 'Feb' WHEN MONTHS=3 THEN 'March' ELSE NULL END);
SELECT 
city_details.City,
SUM(CASE WHEN Month_Name='Jan' THEN no_of_rooms ELSE NULL END) AS Bookings_in_Jan,
SUM(CASE WHEN Month_Name='Feb' THEN no_of_rooms ELSE NULL END) AS Bookings_in_Feb,
SUM(CASE WHEN Month_Name='March' THEN no_of_rooms ELSE NULL END) AS Bookings_in_Mar
FROM hotel_details
LEFT JOIN city_details
ON hotel_details.hotel_id=city_details.Hotel_id
GROUP BY 1;

