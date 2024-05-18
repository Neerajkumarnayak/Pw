-- Q.1 Write a query to display the customer's first name, last name, email, and city they live in
Select concat(first_name," ",last_name) as customer_full_name, email, city from customer c
inner join address a
on a.address_id = c.address_id
inner join city ci
on ci.city_id = a.city_id
order by customer_full_name;

-- Q.2 Retrieve the film title, description, and release year for the film that has the longest duration
Select title, description, release_year from film
where length = (select max(length) from film);

-- Q.3 List the customer name, rental date, and film title for each rental made. Include customers
 -- who have never rented a film
  SELECT c.first_name, c.last_name, r.rental_date, f.title
 FROM customer c
 LEFT JOIN rental r ON c.customer_id = r.customer_id
 LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
 LEFT JOIN film f ON i.film_id = f.film_id;
 
 -- Q.4  Find the number of actors for each film. Display the film title and the number of actors for each film.
 Select title, count(A.actor_id) count_of_actor from film f
inner join film_actor fa
on f.film_id = fa.film_id
inner join actor a
on a.actor_id = fa.actor_id
group by title;

-- Q.5  Display the first name, last name, and email of customers along with the rental date, film title, and rental 
-- return date.
Select concat(first_name," ",last_name) customer_name, email, rental_date, title, return_date from film f
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on r.inventory_id = i.inventory_id
inner join customer c
on c.customer_id = r.customer_id;

-- Q.6 Retrieve the film titles that are rented by customers whose email domain ends with '.net'.
 Select title from film 
 where film_id in (select film_id from inventory 
 where store_id in (select store_id from customer where email like '%.org'));

-- Q.7  Show the total number of rentals made by each customer, along with their first and last names
Select first_name, last_name, count(rental_id) from customer c
left join rental r
on c.customer_id = r.customer_id
group by first_name,last_name;

-- Q.8  List the customers who have made more rentals than the average number of rentals made by all customers.
select first_name from customer where  customer_id in 
(select customer_id from rental
Group by customer_id having count(rental_id) > (Select avg(rental_count) from 
(Select count(rental_id) as rental_count from rental group by customer_id ) as Avr_rentals));

-- Q.9 Display the customer first name, last name, and email along with the names of other customers living in 
-- the same city.
Select * from customer;
Select * from city;
Select * from address;
Select concat(first_name," ",last_name) As full_name, email from customer c
left join address a
on c.address_id = a.address_id
left join city ci
on ci.city_id = a.city_id;

 -- Q.10 Retrieve the film titles with a rental rate higher than the average rental rate of films in the same category
 Select title,rental_rate from film f where rental_rate > (select avg(rental_rate) from film);
 
-- Q.11  Retrieve the film titles along with their descriptions and lengths that have a rental rate greater than the 
-- average rental rate of films released in the same year
 Select title, description, length from film f where 
 rental_rate > (Select avg(rental_rate) from film where f.release_year = release_year);
 
 -- Q.12  List the first name, last name, and email of customers who have rented at least one film in the 
-- 'Documentary' category.
Select first_name, last_name, email from customer
where customer_id in (select distinct(c.customer_id) from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on i.inventory_id = r.inventory_id
join film_category fc on fc.film_id = i.film_id
join category ca on ca.category_id = fc.category_id 
where name = 'Documentary');

-- Q.13 Show the title, rental rate, and difference from the average rental rate for each film.
Select title, rental_rate, rental_rate -(select  avg(rental_rate) from film) as Rate_Difference from film;

-- Q.14  Retrieve the titles of films that have never been rented
Select title from film Where film_id not in ( select distinct(film_id) from inventory where film_id is not null);

-- Q.15 List the titles of films whose rental rate is higher than the average rental rate of films released
 -- in the same year and belong to the 'Sci-Fi' category.
 Select title from film f where rental_rate > (select avg(rental_rate) from film where f.release_year = release_year) 
 and film_id in (select fc.film_id from film_category fc
 join category c on fc.category_id  = c.category_id where name = 'Sci-Fi');
 
 -- Q.16 Find the number of films rented by each customer, excluding customers who have rented
 -- fewer than five films
 Select customer_id, count(rental_id) from rental
 group by customer_id 
 having count(rental_id) >= 5;