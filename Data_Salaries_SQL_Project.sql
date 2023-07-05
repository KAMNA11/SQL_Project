#1 Average salary for all jobs
select avg(salary) as avg_salary from job;

#2 Job title with highest salary
select job_title, max(salary) as highest_salary from job;

#3 Average salary for each job title
select job_title,round(avg(salary),2) as avg_salary from job group by job_title;

#4 Average Salary of Data Scientists in US
select round(avg(salary),2) as avg_salary from job
where job_title= 'Data Scientist' and company_location ='US';

#5 No. of jobs available for each job title
select job_title, count(job_title) as job_count from job group by job_title;

#6 Total salary paid to all Data Analysts in DE 
select sum(salary) as total_salary from job
where job_title='Data Analyst' and company_location='DE';

#7 Top 5  Average salaries with job title
select job_title,round(avg(salary),2) as avg_salary from job 
group by job_title order by avg_salary desc limit 5;

#8 No. of jobs available in each location
select distinct(company_location), count(job_title) as job_count_in_location from job
group by company_location;

#9 Top 3 job titles with most jobs available
select job_title, count(job_title) as top_job_title from job
group by job_title
order by top_job_title desc
limit 3;

#10 Average salary for Data Engineers in Indiana
select avg(salary) as avg_salary from job where company_location='IN' and job_title='Data Engineer';

#11 Top 5 Cities with highest Average Salary
select company_location, round(avg(salary)) as avg_salary from job
group by company_location
order by avg_salary desc
limit 5;

#12 Average Salary and Total no. of jobs with respect to job title
select job_title, round(avg(salary),2) as avg_salary, count(job_title) as job_count from job
group by job_title;

#13 Top 5 jobs with highest salary and total no.of jobs 
select job_title, round(sum(salary),2) as total_salary, count(job_title) as job_count from job
group by job_title order by total_salary desc limit 5; 

#14 Top 5 location with highest salary and no.of jobs
select company_location, round(sum(salary)) as total_salary, count(job_title) as job_count from job
group by company_location order by total_salary desc limit 5;

#15 Average Salaries for each job title in each location with total no. of jobs
select job_title,company_location,round(avg(salary),2) as avg_salary, count(job_title) as job_count 
from job group by job_title, company_location order by avg_salary;

#16 Average Salaries for each job title in each location and percentage of no. of jobs
select job_title, company_location, round(avg(salary),2) as avg_salary,
concat(round(count(job_title)*100/(select round(sum(job_title),2) as total_salary from job),2),'%') as pct_of_jobs
from job group by job_title,company_location;

#17 Average salary for each job title with percentage of total no.of jobs
select job_title, round(avg(salary)) as avg_salary, 
concat(round(count(job_title)*100/(select round(sum(job_title),2) from job),2),'%') as pct
from job group by job_title;

#18 Total no. of jobs w.r.t Experience and Average salary for each year
select experience_level,round(sum(job_title)) as total_jobs, round(avg(salary)) as avg_salary
from job group by experience_level;

#19 Job titles with highest average salary in each location
select job_title, company_location, round(avg(salary)) as avg_salary from job
where job_title in (select job_title from job group by job_title order by avg(salary) desc)
group by job_title, company_location
order by avg(salary) desc; 

#20 Top 5 highest salaries along with Company name that offer high salary for each Job title
select  c.company_name , j.job_title, max(j.salary) as high_salary from job as j
join company as c
on j.id=c.id
group by c.company_name
order by high_salary desc
limit 5;

#21 Total no. of jobs for each job title and company name offering highest salary for each job title
select count(j.job_title) as total_job_count,c.company_name,max(salary) as high_salary  from job as j
join company as c
on j.id=c.id
where (select max(salary) as highest_salary from job )
group by job_title, company_name;

#22 Top 5 cities with highest average salary along with company that offers highest salary in each city
select j.company_location, c.company_name,round(avg(j.salary),2) as avg_salary from job as j
join company as c
on j.id=c.id
group by j.company_location
order by avg_salary desc
limit 5;

#23 Rank of each job title within each company based on average salary
select j.job_title,c.company_name,round(avg(j.salary)) as avg_salary,
rank() over(partition by company_name order by avg(salary) desc) as salary_rank
from job as j
join company as c
on j.id=c.id
group by j.job_title,c.company_name;

#24 Rank of each job title within each location based on  total no. of jobs
select j.job_title,j.company_location,count(j.job_title) as total_no_of_jobs ,
rank() over(partition by j.company_location order by count(j.job_title) desc ) as Job_rank
from job as j
join company as c
on j.id=c.id
group by j.job_title,j.company_location;

#25 Top 5 companies rank with highest avearge salary for Data Scientist position
select c.company_name, avg(salary) as avg_salary,
rank() over(order by avg(salary) desc) as Salary_rank
from job as j
join  company as c
on j.id=c.id 
where j.job_title='Data Scientist' 
group by c.company_name order by avg_salary desc limit 5;

#26 Total no.of jobs w.r.t Experience within each location and its Rank
select experience_level, company_location, count(*) as total_no_of_jobs,
rank() over(partition by company_location order by count(*) desc) as Experience_rank
from job 
group by experience_level,company_location;










