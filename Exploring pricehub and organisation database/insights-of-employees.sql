### Get insights of employees

use organisation ;

### Query 1
select emp_id, salary
from salaries
order by salary desc
limit 10 ;

### Query 2
select first_name, last_name, birth_date 
from employees 
order by birth_date desc
limit 100;

### Query 3
select first_name, last_name, emp_id, hire_date
from employees
order by hire_date asc, emp_id asc
limit 100 ;

### Query 4
select ((select count(*) from employees where gender = "F") / 
(select count(*) from employees) * 100) as perc_female
from employees 
limit 1;

### Query 5
select dept_name , count(distinct dept_emp.emp_id) as employee_count
from departments
inner join dept_emp
on departments.dept_no = dept_emp.dept_no 
group by dept_name
order by dept_name asc ;

### Query 6
select extract( year from from_date) as calendar_year , 
count(distinct employees.emp_id) as employee_count
from dept_emp join employees
on dept_emp.emp_id = employees.emp_id
group by calendar_year
order by calendar_year desc ;

### Query 7
select extract( year from from_date) as calendar_year , 
gender, count(employees.emp_id) as employee_count
from dept_emp join employees
on dept_emp.emp_id = employees.emp_id
group by calendar_year, gender having calendar_year > 1989
order by calendar_year ;

### Query 8
select extract( year from from_date) as calendar_year , 
count(dept_manager.emp_id) as managers
from dept_manager
group by calendar_year
order by calendar_year asc ;

### Query 9
select extract( year from from_date) as calendar_year , dept_name, 
count(distinct dept_manager.emp_id) as managers
from dept_manager join departments
on dept_manager.dept_no = departments.dept_no
group by dept_name, calendar_year
order by calendar_year asc ;

### Query 10
select extract( year from from_date) as calendar_year , gender, 
count(distinct dept_manager.emp_id) as managers
from dept_manager join employees
on dept_manager.emp_id = employees.emp_id
group by calendar_year, gender having calendar_year > 1989
order by calendar_year ;

