--1. List all customers with their address who live in Texas (use JOINs)

SELECT * FROM customer;

SELECT first_name, last_name, a.address, a.district 
FROM customer c 
JOIN address a 
ON c.address_id = a.address_id 
WHERE district = 'Texas'; 


--2. List all payments of more than $7.00 with the customer’s first and last name

SELECT * FROM customer;

SELECT first_name, last_name, p.amount
FROM customer c
JOIN payment p 
ON c.customer_id = p.customer_id 
WHERE p.amount >= '7.00';

--3. Show all customer names who have made over $175 in payments (use
--subqueries)

SELECT *
FROM customer c 
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);


--4. List all customers that live in Argentina (use multiple joins)

SELECT first_name, last_name, a.district, co.country
FROM customer c
JOIN address a
ON c.address_id = a.address_id 
JOIN city ci 
ON a.city_id = ci.city_id 
JOIN country co
ON ci.country_id = co.country_id 
WHERE country = 'Argentina';

--5. Show all the film categories with their count in descending order

SELECT count(*), c.name
FROM film f 
JOIN film_category fc 
ON f.film_id = fc.film_id 
JOIN category c 
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY count(*) DESC;

--6. What film had the most actors in it (show film info)?

SELECT f.title, count(*) AS actor_count
FROM film f 
JOIN film_actor fa
ON f.film_id = fa.film_id 
JOIN actor a
ON fa.actor_id = a.actor_id 
GROUP BY title 
ORDER BY count(*) DESC
LIMIT 1;

--7. Which actor has been in the least movies?

SELECT a.first_name, a.last_name, count(*) AS num_of_movies
FROM actor a
JOIN film_actor fa 
ON a.actor_id = fa.actor_id 
JOIN film f
ON fa.film_id = f.film_id 
GROUP BY a.first_name, a.last_name 
ORDER BY count(*) ASC 
LIMIT 1;


--8. Which country has the most cities?

SELECT country_id, count(*)
FROM city c 
GROUP BY country_id 
ORDER BY count(*) DESC ;

SELECT co.country_id, co.country, count(*) AS num_cities
FROM city c 
JOIN country co
ON c.country_id = co.country_id
GROUP BY co.country_id 
ORDER BY count(*) DESC 
LIMIT 1;

--9. List the actors who have been in between 20 and 25 films.

SELECT a.first_name, a.last_name, count(*) AS num_of_movies
FROM actor a
JOIN film_actor fa 
ON a.actor_id = fa.actor_id 
JOIN film f
ON fa.film_id = f.film_id 
GROUP BY a.first_name, a.last_name  
HAVING count(*) BETWEEN 20 AND 25
ORDER BY count(*) DESC;
