USE extras;
UPDATE journey SET date = str_to_date(date,"%d-%m-%Y");
select * from journey;


-- Show the id of each journey, its date and the number of journeys that took place on that date.
SELECT id,j.date,
COUNT(*) OVER(PARTITION BY j.date) AS total_journeys
FROM JOURNEY j
ORDER BY j.date;

-- Show the id of each journey, the date on which it took place, the model of the train that was used, the max_speed of that 
-- train and the highest max_speed from all the trains that ever went on the same route on the same day.
SELECT
j.id,
j.date,
j.route_id,
t.model,
t.max_speed,
MAX(t.max_speed) OVER(PARTITION BY j.date , j.route_id) AS Max_speed_on_day
FROM journey j, trains t
WHERE j.train_id=t.id;


-- For each ticket, show its id, price and, the column named ratio. The ratio is the ticket price to the sum of all tickets
-- purchased on the same journey.
SELECT *,
(price/(sum(price) over(partition by journey_id)))*100 AS Ratio
FROM ticket t1;