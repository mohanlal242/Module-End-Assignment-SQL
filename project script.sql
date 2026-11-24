create database sales_analysis;
create table learners (
learner_id int primary key,
full_name varchar(30),
country varchar(15)
);
create table courses (
course_id int primary key,
course_name varchar(25),
category varchar(15),
unit_price decimal (10.2)
);
create table purchases (
purchase_id int primary key,
learner_id int,foreign key (learner_id) references learners(learner_id),
course_id int,foreign key (course_id) references courses(course_id),
quantity int,
purchase_date date
);

 select * from courses;
 select*from learners;
 select * from purchases;
 
 insert into learners (learner_id,full_name,country) values
 (101, 'Mohanlal','India'),
 (102, 'Bala' , 'India'),
 (103, 'John' , 'USA'),
 (104, 'Rowan' , 'France'),
 (105, 'Jackie_Chan' , 'Hong_Kong'),
 (106, 'Alexander' , 'Germany');
 
 insert into courses (course_id,course_name,category,unit_price) values
(1001, 'SQL for Data Analysis', 'Data Science', 49.99),
(1002, 'Python Programming', 'Programming', 59.99),
(1003, 'UI/UX Design Basics', 'Design', 39.99),
(1004, 'Excel for Business', 'Business', 29.99),
(1005, 'Machine Learning ', 'Data Science', 79.99);

insert	into	purchases	(purchase_id, learner_id, course_id, quantity, purchase_date) values
(1010, 101, 1001, 2, '2023-02-23'),
(1020, 102, 1002, 1, '2023-03-25'),
(1030, 103,1003,  4, '2023-5-01'),
(1040, 101, 1002, 2, '2023-06-14'),
(1050, 104, 1004, 3, '2023-07-07'),
(1060, 105, 1005, 1, '2023-08-17'),
(1070, 106, 1004, 2, '2023-09-09'),
(1080, 103, 1005, 1, '2023-11-28');
select * from purchases;
select l.learner_id,l.full_name,c.course_id,c.course_name,c.category,p.purchase_id,p.purchase_date,p.quantity,round(p.quantity * c.unit_price,2) as total_amount
from learners l 
inner join purchases p on l.learner_id = p.learner_id
inner join  courses c on p.course_id = c.course_id;

select l.learner_id,l.full_name,c.course_id,c.course_name,c.category,p.purchase_id,p.purchase_date,p.quantity,round(p.quantity * c.unit_price,2) as total_amount
from learners l 
left join purchases p on l.learner_id = p.learner_id
left join  courses c on p.course_id = c.course_id;

select l.learner_id,l.full_name,c.course_id,c.course_name,c.category,p.purchase_id,p.purchase_date,p.quantity,round(p.quantity * c.unit_price,2) as total_amount
from learners l 
right join purchases p on l.learner_id = p.learner_id
right join  courses c on p.course_id = c.course_id;

select l.learner_id,l.full_name, l.country,c.unit_price,p.quantity,round(p.quantity * c.unit_price,2) as total_spend
from learners l
left join purchases p on l.learner_id = p.learner_id
left join  courses c on p.course_id = c.course_id;

select c.course_id,c.course_name,c.category,sum(p.quantity) as total_quantity_sold ,round(sum(p.quantity * c.unit_price), 2) as total_revenue
from courses c
inner join purchases p on c.course_id = p.course_id
group by c.course_id, c.course_name, c.category
order by total_quantity_sold desc
limit 3;

select  c.category,count(distinct p.learner_id) as unique_learners,round(sum(p.quantity * c.unit_price), 2) AS total_revenue
from courses c
inner join  purchases p on c.course_id = p.course_id
group by c.category
order by total_revenue desc;

select l.learner_id,l.full_name,l.country,count(distinct c.category) as categories_purchased,round(sum(p.quantity * c.unit_price), 2) as total_spent
from learners l
inner join purchases p on l.learner_id = p.learner_id
inner join courses c on p.course_id = c.course_id
group by l.learner_id, l.full_name, l.country
having count(distinct c.category) > 1
order by categories_purchased desc, total_spent desc;

select c.course_id,c.course_name,c.category,round(c.unit_price, 2) as unit_price
from courses c
left join purchases p on c.course_id = p.course_id
where p.purchase_id is null;




   
 