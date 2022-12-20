SELECT 
first_name,
last_name,
email
FROM customer
ORDER BY last_name DESC, first_name DESC
/* Order by the number of the colummn ORDER BY 2, 3 DESC*/ 
/*ASC default value*/ */

/*-------------------------------------*/
/*SELECT DISTINCT address_id FROM customer*/
/*SELECT rental_date FROM rental ORDER BY rental_date DESC LIMIT 1*/
/*SELECT COUNT(*) FROM film */
--SELECT COUNT(DISTINCT last_name) FROM customer 

----------------BASIC FILTERING---------------------

SELECT COUNT(*) FROM rental WHERE return_date is null

SELECT payment_id, amount FROM payment WHERE amount <= 2

SELECT * FROM payment WHERE customer_id IN (322, 346, 354) AND (amount < 2 OR amount > 10 )
ORDER BY customer_id, amount DESC

SELECT COUNT(*) FROM payment WHERE (amount BETWEEN 1.99 AND 3.99) 
AND (payment_date BETWEEN '2020-01-26' AND '2020-01-27:23:59')

SELECT * FROM payment WHERE customer_id IN (12,25,67,93,124,234) 
AND amount IN (4.99,7.99,9.99)
AND payment_date BETWEEN '2020-01-01' AND '2020-02-01'

/* LIKE: Used to filter by matching against a pattern 
Use wildcards _ any single character % any sequence of characters 
ILIKE is not case sensitive*/

SELECT COUNT(*) FROM film WHERE description LIKE '%Documentary%'

SELECT COUNT(*) AS total_customers FROM customer WHERE first_name LIKE '___' 
AND (first_name LIKE '%Y' OR first_name LIKE '%X')

SELECT COUNT(*) AS saga_movies FROM film
WHERE description LIKE '%Saga%' AND (title LIKE 'A%' or title LIKE '%R')

SELECT * FROM customer WHERE (first_name LIKE '_A%' AND first_name LIKE '%ER%')
ORDER BY last_name DESC

SELECT COUNT(*) FROM payment 
WHERE (amount = 0 OR amount BETWEEN 3.99 AND 7.99)
AND payment_date BETWEEN '2020-05-01' AND '2020-05-02'

---------------- BASIC GROUPING -----------------
/*Aggregation functions
SUM()
AVG()
MIN()
MAX()
ROUND()
COUNT()
You cannot add other columns unless grouping */ 
SELECT 
MIN(replacement_cost),
MAX(replacement_cost),
ROUND(AVG(replacement_cost),2),
SUM(replacement_cost)
FROM film
-- GROUP BY: Used to GROUP aggrergations BY specific columnns
SELECT staff_id, SUM(amount), COUNT(amount) FROM payment 
WHERE amount != 0 GROUP BY staff_id ORDER BY 2 ASC

SELECT DATE(payment_date) AS pay_date, staff_id, SUM(amount), COUNT(amount)  
FROM payment WHERE amount != 0 
GROUP BY staff_id, pay_date ORDER BY SUM(amount) DESC, COUNT(amount) DESC
--HAVING: Used to FILTER Groupings BY aggregations
SELECT customer_id, DATE(payment_date), ROUND(AVG(amount),2) AS avg_amount, COUNT(*)
FROM payment WHERE DATE(payment_date) BETWEEN '2020-04-28' AND '2020-05-01'
GROUP BY customer_id, DATE(payment_date)
HAVING COUNT(*) > 1
ORDER BY avg_amount DESC



