USE sakila;

/*6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:*/


SELECT 
    staff.first_name,
    staff.last_name,
    address.address,
    address.district
FROM
    staff
        INNER JOIN
    address ON staff.address_id = address.address_id;

/** 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`. */

SELECT 
    staff.staff_id,
    staff.first_name,
    staff.last_name,
    SUM(payment.amount)
FROM
    staff
        INNER JOIN
    payment ON staff.staff_id = payment.staff_id
WHERE
    (payment.payment_date BETWEEN '2005-08-01 00:00:01' AND '2005-09-01 00:00:00')
GROUP BY staff_id;

	
/** 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.*/
SELECT 
    film.title, COUNT(film_actor.actor_id)
FROM
    film
        INNER JOIN
    film_actor ON film.film_id = film_actor.film_id
GROUP BY film.title
;