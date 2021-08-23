----#1 A customer wants to know the films about “astronauts”. How many recommendations could you give for him?
select count(film_id) as total_recommendation from film
where description like '%stronaut%'

----#2 I wonder, how many films have a rating of “R” and a replacement cost between $5 and $15?
select count(film_id) as total_film from film
where rating = 'R' and
replacement_cost between 5 and 15

----#3 We have two staff members with staff IDs 1 and 2. We want to give a bonus to the staff member that handled the most payments.How many payments did each staff member handle? And how much was the total amount processed by each staff member? 
select s.staff_id, concat(s.first_name,' ',s.last_name) as staff_name, count(p.amount) as total_payment, sum(p.amount) as total_amount from payment p
inner join staff s on p.staff_id = s.staff_id
group by 1,2
order by total_payment desc

----#4 Corporate headquarters is auditing the store! They want to know the average replacement cost of movies by rating!
select rating, avg(replacement_cost) as average_replacement_cost from film
group by rating
order by average_replacement_cost desc

----#5 We want to send coupons to the 5 customers who have spent the most amount of money. Get the customer name, email and their spent amount!
select concat(c.first_name,' ', c.last_name) as name, c.email, sum(p.amount) as total_amount
from customer c
inner join payment p
on p.customer_id = c.customer_id
group by 1,2
order by total_amount desc
limit 5

----#6 We want to audit our stock of films in all of our stores. How many copies of each movie in each store, do we have?
select i.store_id, i.film_id, f.title, count(i.inventory_id) as stock 
from inventory i
inner join film f on f.film_id = i.film_id
group by 1,2,3
order by 1,2,3

----#7 We want to know what customers are eligible for our platinum credit card. The requirements are that the customer has at least a total of 40 transaction payments. Get the customer name, email who are eligible for the credit card! 
select c.customer_id, concat(c.first_name, ' ', c.last_name), c.email, count(p.amount) as total_transaction
from payment p
inner join customer c
on p.customer_id = c.customer_id
group by 1,2
having count(p.amount) >= 40
order by total_transaction desc
