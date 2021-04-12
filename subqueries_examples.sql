USE join_example_db;
SELECT * FROM users;
SELECT * FROM roles;

-- show users that have the commenter role
SELECT *
FROM users 
WHERE role_id IN(SELECT id FROM roles
WHERE NAME = 'commenter'
);

-- SHOW users that have the reviewer role
SELECT *
FROM users 
WHERE role_id IN(SELECT id FROM roles
WHERE NAME = 'reviewer'
);

--  this does not need to be done on a different table
USE chipotle;
SELECT * FROM orders 
WHERE item_name IN(
SELECT item_name FROM orders 
WHERE item_name LIKE '%bowl%');

SELECT * FROM orders
WHERE item_name LIKE '%bowl%';


-- Let's say you want to see what has the max quantity sold
SELECT max(quantity) FROM orders;

SELECT item_name, max(quantity) FROM orders
GROUP BY item_name;

-- let's try doing a subquery where we have an aggregation!
SELECT item_name, quantity FROM orders
WHERE quantity = (
SELECT max(quantity) FROM orders
);

-- Let's find names of all current women that are department managers
USE employees;

SELECT first_name, last_name FROM `employees`
WHERE emp_no IN(SELECT emp_no FROM dept_manager
WHERE to_date > curdate())
AND gender = 'F';

-- building my subquery below that will go up here^
SELECT emp_no FROM dept_manager
WHERE to_date > curdate();


/* ways this can break:
selecting a column outside of the scope, the problem is even though you are referencing dept_manager, it won't know it cause you said it was from employees. 
 */
SELECT first_name, last_name, dept_manager.dept_no FROM `employees`
WHERE emp_no IN(SELECT emp_no FROM dept_manager
WHERE to_date > curdate())
AND gender = 'F';

/* ways this can break:
To_date has to be inside the dept_manager subquery, if it's outside, it represents from the employees which doesn't have this column. 
 */
 SELECT first_name, last_name, dept_manager.dept_no FROM `employees`
WHERE emp_no IN(SELECT emp_no FROM dept_manager
)
WHERE to_date > curdate() AND gender = 'F';