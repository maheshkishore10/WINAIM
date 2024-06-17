-- Create employees table
CREATE TABLE employees (
    employee_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    hire_date DATE NOT NULL,
    PRIMARY KEY (employee_id)
);
-- Create departments table
CREATE TABLE departments (
    department_id INT NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (department_id)
);
-- Create salaries table
CREATE TABLE salaries (
    employee_id INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE,
    PRIMARY KEY (employee_id, from_date),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
-- Insert sample data into departments
INSERT INTO departments (department_name) VALUES ('HR'), ('Finance'), ('IT'), ('Marketing'),
 ('Research and Development'), ('Customer Support'), ('Sales');
 -- Insert sample data into employees
INSERT INTO employees (first_name, last_name, department_id, hire_date) 
VALUES ('Kishore', 'M', 1, '2023-06-10'),
       ('Gopi', 'J', 2, '2022-03-15'),
       ('Moneshwar', 'V', 3, '2024-01-05'),
       ('Nishanth', 'CP', 4, '2021-11-20'),
       ('Sampath', 'K', 5, '2023-04-01'),
       ('Ebesam', 'S', 6, '2023-05-15'),
       ('Kavi', 'S', 7, '2022-09-10'),
       ('Dinesh', 'M', 1, '2023-07-23'),
       ('Sanjai', 'S', 2, '2021-12-30'),
       ('Sasi', 'J', 3, '2022-11-11'),
       ('Jegan', 'H', 2, '2021-10-11'),
       ('Udai', 'A', 4, '2024-02-20');
-- Insert sample data into salaries
INSERT INTO salaries (employee_id, salary, from_date, to_date) 
VALUES (1, 50000.00, '2023-06-10', NULL),
       (2, 60000.00, '2022-03-15', NULL),
       (3, 70000.00, '2024-01-05', NULL),
       (4, 80000.00, '2021-11-20', NULL),
       (5, 55000.00, '2023-04-01', NULL),
       (6, 62000.00, '2023-05-15', NULL),
	   (7, 45000.00, '2022-09-10', NULL),
	   (8, 51000.00, '2023-07-23', NULL),
       (9, 58000.00, '2021-12-30', NULL),
       (10, 67000.00, '2022-11-11', NULL),
       (11, 76000.00, '2021-10-11', NULL);
       (12, 78000.00, '2024-02-20', NULL);
       -- To Find all employees who have been hired in the last year
SELECT * 
FROM employees
WHERE hire_date >= CURDATE() - INTERVAL 1 YEAR;
--   To Calculate the total salary expenditure for each department
SELECT d.department_name, SUM(s.salary) AS total_salary_expenditure
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN salaries s ON e.employee_id = s.employee_id
GROUP BY d.department_name;
-- To Find the top 5 highest-paid employees along with their department names 
SELECT e.first_name, e.last_name, d.department_name, s.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN (
    SELECT employee_id, MAX(salary) AS salary
    FROM salaries
    GROUP BY employee_id
) s ON e.employee_id = s.employee_id
ORDER BY s.salary DESC
LIMIT 5;