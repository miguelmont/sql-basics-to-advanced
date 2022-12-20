----------------------- JOINS -----------------------------
-- Combine information from multiple tables in one query
-- INNER JOIN:Only rows appear in both tables
/*
SELECT * FROM TableA
INNER JOIN TableB
ON TableA.employee = TableB.employee

SELECT A.employee (Both tables), sales (Only one table) FROM TableA AS A
INNER JOIN TableB AS B
ON A.employee = B.employee

Always need acommon column reference
Order of the tables does not matter
Repeated values in either table will also be repeated
*/

SELECT first_name, last_name FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id

SELECT * FROM seats
SELECT * FROM boarding_passes

SELECT fare_conditions, COUNT(*) FROM seats as S
INNER JOIN boarding_passes as BA
ON S.seat_no = BA.seat_no
GROUP BY fare_conditions

--FULL OUTER JOIN: All rows on both tables
/*SELECT * FROM TableA
FULL OUTER JOIN TableB
ON TableA.employee = TableB.employee */

SELECT t.ticket_no FROM boarding_passes AS b
FULL OUTER JOIN tickets AS t
ON b.ticket_no = t.ticket_no
WHERE b.ticket_no is null

--LEFT OUTER JOIN: Rows on left table and overlaped results in both tables
/*SELECT * FROM TableA
LEFT OUTER JOIN TableB
ON TableA.employee = TableB.employee
Order matters*/

SELECT * FROM aircrafts_data as a
LEFT JOIN flights as f
ON a.aircraft_code = f.aircraft_code
WHERE f.flight_id is null

SELECT COUNT(*) as total, b.seat_no FROM seats as s
LEFT JOIN boarding_passes as b
ON s.seat_no = b.seat_no
--WHERE b.seat_no is null
GROUP BY b.seat_no ORDER BY total DESC

SELECT COUNT(*) as total, RIGHT(b.seat_no, 1) AS line FROM seats as s
LEFT JOIN boarding_passes as b
ON s.seat_no = b.seat_no
GROUP BY line ORDER BY total DESC


SELECT first_name, last_name, phone, a.district FROM customer as c
LEFT JOIN address as a
ON c.address_id = a.address_id
WHERE a.district LIKE '%Texas%'

------- Joins on multiple conditions ----------
/*
SELECT * FROM TableA a
INNER JOIN TableB b
ON a.first_name = b.first_name
AND a.last_name = 'Jones' THIS IS MORE PERFORMANT THAN WHERE CLAUSE

SELECT * FROM TableA a
INNER JOIN TableB b
ON a.first_name = b.first_name
WHERE a.last_name = 'Jones'
*/

SELECT seat_no, ROUND(AVG(amount),2) as avg FROM boarding_passes as b
LEFT JOIN ticket_flights as t
ON b.ticket_no = t.ticket_no
AND b.flight_id = t.flight_id
GROUP BY seat_no
ORDER BY avg DESC

-------- JOIN MULTIPLE TABLES -------------	

SELECT first_name, last_name, email, country FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city as ci
ON ci.city_id = a.city_id
INNER JOIN country as co
ON co.country_id = ci.country_id
AND co.country = 'Brazil'
