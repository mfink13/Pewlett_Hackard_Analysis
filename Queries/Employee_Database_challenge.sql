--Create retirement_titles.csv--
SELECT e.emp_no,
    e.first_name,
e.last_name,
   ti.title,
   ti.from_date,
   ti.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Check table --
SELECT * FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)
rt.emp_no,
    rt.first_name,
rt.last_name,
   rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;

-- Check table
SELECT * FROM unique_titles

-- Create table with counts per title
SELECT title, COUNT (title)
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title 
ORDER BY count DESC;

-- Check table
SELECT * FROM retiring_titles


-- Create a Mentorship Eligibility table that holds the employees 
-- who are eligible to participate in a mentorship program
SELECT DISTINCT ON (e.emp_no)
e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date,
de.from_date, 
de.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees as e 
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ASC;

-- Check table
SELECT * FROM mentorship_eligibilty


---------- For Summary ----------

-- Create table with total employees not eligible for retirement		
SELECT e.emp_no,
    e.first_name,
e.last_name,
   ti.title,
   ti.from_date,
   ti.to_date
INTO not_retiring
FROM employees as e
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1956-01-01' AND '9999-01-01')
ORDER BY e.emp_no;

SELECT DISTINCT ON (nr.emp_no)
nr.emp_no,
    nr.first_name,
nr.last_name,
   nr.title
INTO no_retiring_unique_titles
FROM not_retiring as nr
ORDER BY nr.emp_no ASC, nr.to_date DESC;


-- Create table with counts per title for all employees
SELECT title, COUNT (title)
INTO not_retiring_titles
FROM no_retiring_unique_titles as nor
GROUP BY nor.title 
ORDER BY count DESC

SELECT * FROM not_retiring_titles