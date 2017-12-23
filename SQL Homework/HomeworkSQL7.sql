USE sakila;
/** 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English. */

SELECT 
    film.title, language.name
FROM
    film
        INNER JOIN
    language ON film.language_id = language.language_id
WHERE
    language.name = 'English'
        AND title LIKE 'K%'
        OR title LIKE 'Q%'
;


/** 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.*/
   
SELECT 
    film.title, actor.first_name, actor.last_name
FROM
    film
        INNER JOIN
    film_actor ON film.film_id = film_actor.film_id
        INNER JOIN
    actor ON film_actor.actor_id = actor.actor_id
WHERE
    film.title = 'Alone Trip';



/** 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.*/

SELECT 
    customer.first_name, customer.last_name, customer.email
FROM
    customer
        INNER JOIN
    address ON customer.address_id = address.address_id
        INNER JOIN
    city ON address.city_id = city.city_id
        INNER JOIN
    country ON city.country_id = country.country_id
WHERE
    country.country = 'Canada';


/** 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.*/
SELECT 
    rating, title
FROM
    film
WHERE
    rating = 'G';

/** 7e. Display the most frequently rented movies in descending order.*/
  	
/** 7f. Write a query to display how much business, in dollars, each store brought in.*/

/** 7g. Write a query to display for each store its store ID, city, and country.*/
  	
/** 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)*/
  	
/** 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.*/
  	
/** 8b. How would you display the view that you created in 8a?*/

/** 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.*/