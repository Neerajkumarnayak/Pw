-- Q.1 Retrieve the total number of rentals made in the Sakila database.
Select count( Distinct (rental_id))  as Total_Rentals from rental;

-- Q.2 Find the average rental duration (in days) of movies rented from the Sakila database.
Select avg(rental_duration) as Days from film;

-- Q.3 Display the first name and last name of customers in uppercase. 
Select Upper(first_name) as First_Name, upper(last_name) as Last_Name from customer;

-- Q.4 Extract the month from the rental date and display it alongside the rental ID
Select monthname(rental_date) as Months, rental_id from rental;

-- Q.5 Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
Select first_name,count(rental_id) as count_of_rental from customer c
inner join rental r
on c.customer_id = r.customer_id
group by first_name;

-- Q.6 Find the total revenue generated by each store.
select store,sum(total_sales) as Total_revanue from Sales_by_store group by store;

-- Q.7 Display the title of the movie, customer's first name, and last name who rented it. 
Select title,first_name,last_name from film f
inner join inventory i
on f.film_id = i.film_id
inner join customer c
on c.store_id = i.store_id
inner join rental r
on c.customer_id = r.customer_id;

 -- Q.8 Retrieve the names of all actors who have appeared in the film "GRAIL FRANKENSTEIN" 
Select first_name,last_name, title from film_actor fa
inner join actor a
on fa.actor_id = a.actor_id
inner join film f
on fa.film_id = f.film_id
where title = 'GRAIL FRANKENSTEIN';

-- Q.9 Determine the total number of rentals for each category of movies.
Select name ,count(rental_id) as Total_rental_movies from film_category fc
inner join film f
on fc.film_id = f.film_id
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on r.inventory_id = i.inventory_id
inner join category c
on fc.category_id = c.category_id
group by name;

-- Q.10 Find the average rental rate of movies in each language. 
Select name, avg(rental_rate) as Avg_rental_rate from film f
inner join language l
on f.language_id = l.language_id
group by name;

-- Q.11 Retrieve the customer names along with the total amount they've spent on rentals
Select first_name, sum(amount) Total_amount from customer c
inner join payment p
on c.customer_id = p.customer_id
group by first_name;

-- Q.12 List the titles of movies rented by each customer in a particular city (e.g., 'London').
Select title,first_name, city from film f
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on i.inventory_id = r.inventory_id
inner join customer c
on c.customer_id = r.customer_id
inner join address a
on a.address_id = c.address_id
inner join city ci
on ci.city_id = a.city_id
where city = 'london';

-- Q.13 Display the top 5 rented movies along with the number of times they've been rented.
Select title, count(rental_id) rented_times from film f
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on r.inventory_id = i.inventory_id
group by title
limit 5;

-- Q.14 Determine the customers who have rented movies from both stores (store ID 1 and store ID 2)
Select * from customer;
Select * from rental;
Select * from inventory;
Select first_name from rental r
inner join customer c
on r.customer_id = c.customer_id
inner join  inventory i
on i.inventory_id = r.inventory_id
where i.store_id = 1 and i.store_id = 2;
