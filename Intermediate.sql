--------------------INTERMEDIATE FUNCTIONS -------------------------

SELECT LOWER(first_name), LOWER(last_name), LOWER(email) FROM customer 
WHERE LENGTH(first_name) > 10 OR LENGTH(last_name) > 10

SELECT LEFT(RIGHT(email, 4),1), email FROM customer

SELECT LEFT(first_name, 1) || '.' || LEFT(last_name, 1) AS initials, first_name, last_name
FROM customer

SELECT LEFT(email, 1) || '***' || RIGHT(email, 19) FROM customer

SELECT LEFT(email, POSITION('@' IN email)-1) FROM customer
SELECT left(email, POSITION(last_name IN email)-2) FROM customer
SELECT POSITION('.' in left(email, POSITION('@' IN email)-1)) FROM customer
SELECT last_name || '.' || LEFT(email, POSITION('.' IN email) -1) FROM customer

SELECT SUBSTRING(email from POSITION('.' IN email) + 1 for POSITION('@' IN email) - POSITION('.' IN email) -1)
FROM customer

SELECT LEFT(email, 1) || '***' || SUBSTRING(email FROM POSITION('.' IN email) FOR 2) 
|| '***' || SUBSTRING(email FROM POSITION('@' IN email))
FROM customer

SELECT '***' || RIGHT(SUBSTRING(email FROM 1 FOR POSITION('.' IN email)-1), 1) || '.'
|| SUBSTRING(email FROM POSITION('.' IN email) + 1FOR 1) 
|| '***'  || SUBSTRING(email FROM POSITION('@' IN email)) FROM customer

--EXTRACT: used to extract part of timestamp/date
/*Syntax EXTRACT(field from date/time/interval)
date: standard formaat without time
time: just time without date can include timezone
timestamp: Date and time
intervarls: defference between two dates
*/
SELECT DISTINCT EXTRACT(year from rental_date) FROM rental
SELECT * FROM rental WHERE EXTRACT(year from rental_date) = '2020'


SELECT TO_CHAR(payment_date, 'Month') as month, SUM(amount) FROM payment GROUP BY month 
ORDER BY SUM(amount) DESC

SELECT EXTRACT(dow from payment_date) as dow,
SUM(amount) as total FROM payment GROUP BY dow ORDER BY total DESC

SELECT customer_id, EXTRACT(week from payment_date) as week,
SUM(amount) as total FROM payment GROUP BY week, customer_id ORDER BY total DESC

SELECT TO_CHAR(payment_date, 'Dy, DD/MM/YYYY') as day, SUM(amount) as total FROM payment 
GROUP BY day ORDER by total DESC

SELECT TO_CHAR(payment_date, 'Mon, YYYY') as month_year, SUM(amount) as total FROM payment 
GROUP BY month_year ORDER by total DESC

SELECT TO_CHAR(payment_date, 'Dy, HH:MI') as day_time, SUM(amount) as total FROM payment 
GROUP BY day_time ORDER by total DESC

--INTERVALS: CURRENT_TIMESTAMP

SELECT CURRENT_TIMESTAMP, EXTRACT(hour from return_date-rental_date) FROM rental

SELECT return_date-rental_date, customer_id FROM rental WHERE customer_id = 35
SELECT AVG(return_date-rental_date)
as avg_rental_duration, customer_id FROM rental 
GROUP BY customer_id ORDER BY avg_rental_duration DESC

------------------ CONDITIONAL EXPRESSIONS --------------------------

SELECT ROUND((rental_rate/replacement_cost)* 100 , 2) as rental_rate_replacement_ratio, film_id
FROM film WHERE ROUND((rental_rate/replacement_cost)* 100 , 2) < 4 ORDER BY 1 ASC

-- CASE WHEN
/*
CASE
	WHEN condition1 THEN result1
	WHEN condition2 THEN result2
	WHEN condition3 THEN result3
	ELSE result (Optional)
END
*/

SELECT 
COUNT(*) as flights,
CASE
WHEN EXTRACT(month from scheduled_departure) IN (12,1,2) THEN 'Winter'
WHEN EXTRACT (month from scheduled_departure) IN (3,4,5) THEN 'Spring'
WHEN EXTRACT (month from scheduled_departure) IN (6,7,8) THEN 'Summer'
ELSE 'Fall' 
END as season
FROM flights
GROUP BY season


SELECT
title,
CASE
WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
WHEN description LIKE '%Drama%' AND length>90 THEN 'Long drama (tier 2)'
WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END as tier_list
FROM film
WHERE 
CASE
WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
WHEN description LIKE '%Drama%' AND length>90 THEN 'Long drama (tier 2)'
WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END is not null

SELECT 
SUM(CASE
WHEN rating = 'G' THEN 1
ELSE 0
END) AS "G",
SUM(CASE
WHEN rating = 'R' THEN 1
ELSE 0
END) AS "R",
SUM(CASE
WHEN rating = 'NC-17' THEN 1
ELSE 0
END) AS "NC-17",
SUM(CASE
WHEN rating = 'PG-13' THEN 1
ELSE 0
END) AS "PG-13",
SUM(CASE
WHEN rating = 'PG' THEN 1
ELSE 0
END) AS "PG"
FROM film

--COALESCE: Returns first value of a list of values which is not null, if is null it will be filled with the second value
--CAST: Changes de data type of a value CAST(value/column AS data type)

SELECT rental_date, COALESCE(CAST(return_date AS VARCHAR), 'No returned') FROM rental
ORDER BY rental_date DESC

--REPLACE: Replaces text from a string in a column with another text REPLACE(column, old text, new text)
SELECT CAST(REPLACE(passenger_id, ' ', '') AS BIGINT) as passenger_id FROM tickets
SELECT REPLACE(flight_no, 'PG', 'FL') FROM flights
