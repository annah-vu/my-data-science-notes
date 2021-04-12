USE florence02;
CREATE TEMPORARY TABLE my_numbers(
    n INT UNSIGNED NOT NULL 
);

SHOW TABLES;

INSERT INTO my_numbers(n) VALUES (1), (2), (3), (4), (5);
SELECT * FROM my_numbers;

USE florence02;
SELECT employees.employees.first_name, employees.employees.last_name, employees.salaries.salary
FROM employees.salaries
JOIN employees.employees USING(emp_no)
WHERE to_date > curdate();

CREATE TEMPORARY TABLE current_salary AS (
SELECT employees.employees.first_name, employees.employees.last_name, employees.salaries.salary
FROM employees.salaries
JOIN employees.employees USING(emp_no)
WHERE to_date > curdate());

SELECT * FROM current_salary;

-- if we do 5% raises for all current employees, what is the sum of all of those new salaries?

UPDATE current_salary SET salary = salary + salary * .05;

SELECT * FROM current_salary;

SELECT sum(salary) FROM current_salary;

SELECT sum(salary) FROM employees.salaries;

SELECT(SELECT sum(salary FROM current_salary) -
 (SELECT sum(salary) FROM employees.salaries 
WHERE to_date > curdate());

USE florence02;
CREATE TEMPORARY TABLE fruits AS(
SELECT * FROM fruits_db.fruits);

SELECT * FROM fruits;

USE florence02;
SELECT *
FROM current_salary
JOIN employees.employees USING(first_name);