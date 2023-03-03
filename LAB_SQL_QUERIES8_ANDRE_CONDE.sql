# LAB SQL Queries 8

# 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

SELECT film_id, title, length, rating,  DENSE_RANK() OVER (ORDER BY length ASC)
FROM film;

# 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column).  In your output, only select the columns title, length, rating and rank.

SELECT title, length, rating,  DENSE_RANK() OVER (PARTITION BY rating ORDER BY length ASC) AS Ranking
FROM film;

# 3. How many films are there for each of the categories in the category table? 

SELECT * 
FROM film_category;

SELECT * 
FROM category;

SELECT category.category_id, name, count(film_id) AS num_film
FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
GROUP BY category.category_id;

# 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and 
# count the number of times an actor appears.

SELECT actor.actor_id, CONCAT(first_name, " ", actor.last_name) AS Name, count(actor.actor_id) AS most_app_actor
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY most_app_actor DESC
LIMIT 1;

# 5. Which is the most active customer (the customer that has rented the most number of films)? 
# Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT rental.customer_id, count(rental.customer_id) AS most_active_customer
FROM customer
INNER JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY customer_id
ORDER BY most_active_customer DESC
LIMIT 1;

# Bonus: Which is the most rented film? (The answer is Bucket Brotherhood). 
SELECT film_id, count(rental_id) AS most_rented
FROM inventory
INNER JOIN rental
ON rental.inventory_id = inventory.inventory_id
GROUP BY film_id
ORDER BY most_rented DESC
LIMIT 1;

SELECT title, film_id
FROM film
WHERE film_id = 103;

SELECT inventory.film_id, title, COUNT(rental_id) AS num_of_rentals
FROM inventory
INNER JOIN rental
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON film.film_id = inventory.film_id
GROUP BY film_id
ORDER BY num_of_rentals DESC
LIMIT 1;
