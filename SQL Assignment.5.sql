Use mavenmovies;

Select * from actor;
Select * from film;
Select * from film_actor;
Select * from language;
Select * from customer;
Select * from payment;
Select * from Rental;
-- Q.1. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF
-- Ans. let's consider the film table in sakila database. This table contains a column named special features that stores a comma-separated list of special features for each film. That violates 1NF
-- For 1NF following criteria:
-- 1.	All entries in each column must be atomic (indivisible).
-- 2.	Each column must contain only one type of data.

-- We create table like:

CREATE TABLE film (
    film_id INT PRIMARY KEY,
    title VARCHAR(255)
);

CREATE TABLE special_feature (
    feature_id INT PRIMARY KEY,
    feature_name VARCHAR(255)
);

CREATE TABLE film_special_feature (
    film_id INT,
    feature_id INT,
    PRIMARY KEY (film_id, feature_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    FOREIGN KEY (feature_id) REFERENCES special_feature(feature_id)
);

-- Q.2. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it
-- Ans. In database normalization, Second Normal Form (2NF) is achieved when a table is in 1NF and there are no partial dependencies of any column on the primary key. In simpler terms, each non-prime attribute (attributes that are not part of the primary key) must be fully functionally dependent on the entire primary key, and not on a part of it.

-- Q.3. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF
-- Ans. A table is said to be in third normal form.
-- 1.Meets all the condition of first normal form and second normal form.
-- 2. The table should not have transitive dependencies.
-- •	Does not contain column that are not fully dependent on the primery key.
-- •	If an attribute can be dependent by another non key attribute, it called a transitive dependency.

-- Q.4 Take a specific table in Sakila and guide through the process of normalizing it from the initial 
-- unnormalized form up to at least 2NF
-- And Let's consider the rental table in the Sakila database for this normalization example. The rental table tracks information about customer rentals, and it has the following columns:

-- Step 1: Identify the Primary Key
-- The primary key of the rental table is rental_id.

-- Step 2: Check for Partial Dependencies
-- Examine each non-prime attribute to identify if there are any partial dependencies on the primary key.

-- inventory_id depends on the rental_id.
-- customer_id depends on the rental_id.
-- return_date depends on the rental_id.
-- staff_id depends on the rental_id.
-- There are no partial dependencies; all non-prime attributes depend on the entire primary key.

-- Step 3: Verify Full Dependency
-- Ensure that each non-prime attribute is fully functionally dependent on the entire primary key. In this case, all non-prime attributes depend on the primary key (rental_id), and there are no issues.

-- Step 4: Normalize to 1NF
-- Since the initial table does not violate 1NF (it has a primary key, and all attributes are atomic), there's no need to make changes for 1NF.

-- Step 5: Normalize to 2NF
-- Since the rental table does not violate 2NF (no partial dependencies on the primary key), it is already in 2NF. However, for the sake of illustration, let's consider a hypothetical scenario where the inventory_id and customer_id are part of a composite primary key.


CREATE TABLE rental (
    rental_id INT,
    rental_date DATETIME,
    inventory_id INT,
    customer_id INT,
    return_date DATETIME,
    staff_id INT,
    PRIMARY KEY (rental_id, inventory_id, customer_id)
);
-- In this case, inventory_id and customer_id together form a composite primary key. To normalize to 2NF, we would create two new tables:


CREATE TABLE RentalInfo (
    rental_id INT PRIMARY KEY,
    rental_date DATETIME,
    return_date DATETIME,
    staff_id INT,
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id)
);

CREATE TABLE RentalCustomer (
    rental_id INT,
    inventory_id INT,
    customer_id INT,
    PRIMARY KEY (rental_id, inventory_id, customer_id),
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id));
    
-- Now, the original table (rental) is decomposed into two tables, and each table is in 2NF. This ensures that there are no partial dependencies on the primary key, and the database is properly normalized.

-- Q.5 Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have 
-- acted in from the actor and film_actor tables
With Actor_details
As
(Select concat(first_name," ",last_name) as actor_name, count(film_id) as film_count from film_actor fa
join actor a
on fa.actor_id = a.actor_id
group by actor_name)
Select * from actor_details;

-- Q.6 Use a recursive CTE to generate a hierarchical list of categories and their subcategories from the category 
-- table in Sakila
WITH RECURSIVE CategoryHierarchy AS (
    SELECT
        category_id,
        name AS category_name,
        1 AS n
    FROM
        category

    UNION ALL

    SELECT
        c.category_id,
        c.name AS category_name,
        n + 1
    FROM
        category c
)

SELECT
    category_id,
    category_name,
    level
FROM
    CategoryHierarchy
ORDER BY
    level, category_id;

-- Q.7. Create a CTE that combines information from the film and language table to display film title languge name, and rental rate
with film_info
as
(select Title, name as language_name, count(rental_rate) from film f
join language l
on f.language_id = l.language_id
group by name,title)

Select * from film_info;

-- Q.8 Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the
-- customer and payment tables
with customer_rev
as
(select c.customer_id, c.first_name, sum(p.amount) as revanue from customer c
join payment p
on c.customer_id = p.customer_id
group by c.customer_id, c.first_name)
Select * from customer_rev;

-- Q.9 Utilize a CTE with a window function to rank films based on their rental duration from the film table
with film_rank as
(Select film_id, title, rental_duration, rank() over(order by rental_duration desc) ranks
from film
group by film_id, title)
Select * from film_rank;

-- Q.10 Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer
-- table to retrieve additional customer details
with customer_details 
as
(Select c.customer_id, count(r.rental_id) as rental_count from customer c
join rental r
on r.customer_id = c.customer_id
group by c.customer_id
having rental_count > 2) 
Select * from customer_details;

-- Q.11 Write a query using a CTE to find the total number of rentals made each month, considering the  
-- from the rental table
with Rental_each_month as
(Select monthname(rental_date) as months, count(rental_id) as rental_count from rental
group by months)
Select * from rental_each_month;

-- Q.11 Use a CTE to pivot the data from the payment to display the total payments made by each customer in 
-- separate columns for different payment methods
with cutomer_wise_total as
(SELECT
        customer_id,
        sum(amount)
    FROM
        payment
    GROUP BY
        customer_id)
        select * from cutomer_wise_total;
        
-- 12. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together,using 
-- fil_actor table

with actorPair as
(SELECT
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        f.film_id,
        f.title AS film_title
    FROM
        film_actor fa1
    JOIN
        film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
    JOIN
        film f ON fa1.film_id = f.film_id)
        Select * from actorpair;