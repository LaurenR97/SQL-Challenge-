DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;


CREATE TABLE Departments (
	dept_no VARCHAR(10) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(30)NOT NULL
	
);


--create table 2

CREATE TABLE dept_emp (
        emp_no INT,
        dept_no VARCHAR(30)NOT NULL 
	PRIMARY KEY (emp_no, dept_no),  
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
	
);


-- create table 3

CREATE TABLE dept_manager (
        dept_no VARCHAR NOT NULL,
        emp_no INT
    PRIMARY KEY (dept_no, emp_no), 
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);


--create table 4 

CREATE TABLE employees (
       emp_no INT PRIMARY KEY NOT NULL,
	   emp_title_id VARCHAR(5) NOT NULL,
	   birth_date DATE NOT NULL,
	   first_name VARCHAR(50) NOT NULL,
	   last_name VARCHAR(50) NOT NULL,
	   sex CHAR(1) NOT NULL,
	   hire_date DATE
);

--create table 5

CREATE TABLE salaries (
             emp_no INT,
             salary INT,
	PRIMARY KEY (emp_no), 
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)

);



--create table 6

CREATE TABLE titles (
        title_id VARCHAR PRIMARY KEY NOT NULL,
        title VARCHAR(50)
);


--ensuring information has been imported 

select * from titles
select * from departments
select * from employees
select * from salaries
select * from dept_manager
select * from dept_emp

--List the employee number, last name, first name, sex, and salary of each employee 

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--List the manager of each department along with their department number, department name, employee number, last name, and first name

SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager dm
INNER JOIN employees e ON dm.emp_no = e.emp_no
INNER JOIN departments d ON dm.dept_no = d.dept_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name 

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name, de.dept_no
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B 

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name

SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)

SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;