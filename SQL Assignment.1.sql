-- Q.1 Identify the primary keys and foreign keys in maven movies db. Discuss the differences
-- Answer:- the Major difference in primary key and foreign key are primary key use to identify not null and unique value in column
-- other hand foreign key establish relationship between two table . 

-- Q.2 List all details of actors
Select * from Actor; 

-- Q.3 List all customer information from DB. 
Select * from customer;

-- Q.4 List different countries.
Select distinct country from Country;

  -- Q5.Display all active customers.
Select Customer_id, First_Name, Last_Name, Email from Customer where active = 1;
 
 -- Q6. List of all rental IDs for customer with ID 1.
 Select rental_id from rental where customer_id = 1;

-- Q.7 Display all the films whose rental duration is greater than 5 .
Select title from film where rental_duration > 5;

-- Q.8 List the total number of films whose replacement cost is greater than $15 and less than $20.
Select count(*) as Total_no_of_film from film where replacement_cost between 15 and 20;
 
-- Q.9 Display the count of unique first names of actors.
Select count(distinct first_name) from actor;

 -- Q.10 Display the first 10 records from the customer table.
 select * from Customer limit 10;
 
 -- Q.11 Display the first 3 records from the customer table whose first name starts with ‘b’.
 Select * from customer where first_name like 'b%' limit 3;
 
-- Q.12 Display the names of the first 5 movies which are rated as ‘G’.
Select title from film where rating = 'G' limit 5;

-- Q.13 Find all customers whose first name starts with "a".
Select first_name from customer where first_name like 'a%';  

-- Q.14 Find all customers whose first name ends with "a".
Select first_name from Customer where first_name like '%a'; 

-- Q.15 Display the list of first 4 cities which start and end with ‘a’ . 
 Select city from city where city like '%a%' limit 4;
 
 -- Q.16 Find all customers whose first name have "NI" in any position.
Select first_name from customer where first_name like '%in%';
 
 -- Q.17 Find all customers whose first name have "r" in the second position.
 Select first_name from customer where first_name like '_r%';
 
 -- Q.18 Find all customers whose first name starts with "a" and are at least 5 characters in length.
 Select first_name from customer where first_name like 'a____';
 
 -- Q.19 Find all customers whose first name starts with "a" and ends with "o".
select first_name from customer where first_name like 'a%o';
 
 -- Q.20 Get the films with pg and pg-13 rating using IN operator. 
Select title, rating from film where rating in ('pg','pg-13');

 -- Q.21 Get the films with length between 50 to 100 using between operator. 
Select title, length from film where length between 50 and 100;

-- Q.22 Get the top 50 actors using limit operator. 
Select first_name from actor limit 50;

-- Q.23 Get the distinct film ids from inventory table.
Select distinct(film_id) from inventory;
