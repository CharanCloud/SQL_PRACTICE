CREATE SCHEMA PRACTICE;


CREATE TABLE Employee(
    EmpId integer, 
    FirstName varchar(20), 
    LastName varchar(20), 
    Email varchar(25), 
    PhoneNo varchar(25), 
    Salary integer
);



INSERT INTO Employee 
VALUES 
(3,'Neena','Kochhar','neena@test.com','123.456.4568',17000),
(4,'Lex','De Haan','lex@test.com','123.456.4569',15000);


select * from Employee;



create table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);


insert into emp
values (1, 'Ankit', 100,10000, 4, 39);
insert into emp
values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp
values (3, 'Vikas', 100, 10000,4,37);
insert into emp
values (4, 'Rohit', 100, 5000, 2, 16);
insert into emp
values (5, 'Mudit', 200, 12000, 6,55);
insert into emp
values (6, 'Agam', 200, 12000,2, 14);
insert into emp
values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp
values (8, 'Ashish', 200,5000,2,12);
insert into emp
values (1, 'Saurabh',900,12000,2,51);

create table dept(
dep_id int,
dep_name varchar(20)
);

select * from dept;

insert into dept
values (100, 'Analytics');
insert into dept
values (300, 'IT');

create table orders(
 customer_name char(10),
 order_date date,
 order_amount int,
 customer_gender char(6)
 );

  insert into orders values('Shilpa','2020-01-01',10000,'Male');
 insert into orders values('Rahul','2020-01-02',12000,'Female');
 insert into orders values('Shilpa','2020-01-02',12000,'Male');
 insert into orders values('Rohit','2020-01-03',15000,'Female');
 insert into orders values('Shilpa','2020-01-03',14000,'Male');
 

select * from orders;


create table stadium (
id int,
visit_date date,
no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);


select * from stadium;


CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);


INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');

SELECT * FROM events;



create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);
delete from tickets;
insert into tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');
create table holidays
(
holiday_date date
,reason varchar(100)
);
delete from holidays;
insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');

select * from holidays;


create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');

DELETE FROM hospital WHERE EMP_ID=5;


09:01:40	DELETE FROM hospital WHERE EMP_ID=5	Error Code: 1175. 
You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  
To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.00032 sec


select * from hospital;

CREATE TABLE UNDERSTANDNG_NULL
(
ID INT
);

INSERT INTO UNDERSTANDNG_NULL VALUES(1);
INSERT INTO UNDERSTANDNG_NULL VALUES(1);
INSERT INTO UNDERSTANDNG_NULL VALUES(2);


INSERT INTO UNDERSTANDNG_NULL VALUES(NULL);
INSERT INTO UNDERSTANDNG_NULL VALUES(NULL);
INSERT INTO UNDERSTANDNG_NULL VALUES(NULL);

SELECT * FROM UNDERSTANDNG_NULL ;

create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);
delete from airbnb_searches;
insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room')
;

SELECT * FROM airbnb_searches;



CREATE TABLE emp_salary
(
    emp_id INTEGER  NOT NULL,
    name NVARCHAR(20)  NOT NULL,
    salary NVARCHAR(30),
    dept_id INTEGER
);


INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');

SELECT * FROM emp_salary;

