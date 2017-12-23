USE sakila;

/*3a. Add a `middle_name` column to the table `actor`. Position it between `first_name` and `last_name`. Hint: you will need to specify the data type.*/

ALTER TABLE actor
ADD COLUMN middle_name VARCHAR(15) AFTER first_name;

/*3b. You realize that some of these actors have tremendously long last names. Change the data type of the `middle_name` column to `blobs`.*/

ALTER TABLE actor
MODIFY COLUMN middle_name BLOB;

/*3c. Now delete the `middle_name` column.*/

ALTER TABLE actor
DROP COLUMN middle_name;

/*4a. List the last names of actors, as well as how many actors have that last name.*/

SELECT 
    last_name, COUNT(*)
FROM
    actor
GROUP BY last_name;

/*4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors*/

SELECT 
    last_name, COUNT(last_name)
FROM
    actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;

/* 4c. Oh, no! The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.*/
  	
UPDATE actor
SET last_name = "WILLIAMS", first_name = "HARPO"
WHERE last_name = "WILLIAMS" AND first_name = "GROUCHO";


/* 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`. Otherwise, change the first name to `MUCHO GROUCHO`, as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO `MUCHO GROUCHO`, HOWEVER! (Hint: update the record using a unique identifier.)*/


UPDATE actor 
SET first_name = "MUCHO GROUCHO"
WHERE first_name = "GROUCHO";

UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

SELECT *
FROM
actor
WHERE
first_name LIKE "%GROUCH%"
;


/*5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?*/

describe sakila.address;