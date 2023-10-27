##################################################################################################################################################
# THOERY NOTES imp
# >> select--FROM--JOIN ON---WHERE------GROUP BY---HAING----ORDER BY

# Primary key vs unique key

# union vs union all : TWO select statement seperated by union / union all
#select item_code from sales union select item_code from sales_dup; # will not have duplicates
#select item_code from sales union all  select item_code from sales_dup; # will have duplicates

# colease/ifnull
# ex : SELECT *, ifnull(item_code , 'not_present') FROM ifnull_exm;  will create new col by replacing null values as mentioned 
# ex : SELECT *, coalesce(item_code,'nan') FROM ifnull_exm;

# >> LIKE % , _

# >> Case statement 
SELECT *  , CASE 
	WHEN  salary > 40000 AND salary <= 50000 THEN 'Medium'
    WHEN salary > 50000 THEN 'high'
END AS new_col
FROM salaries;

# >> SELF join

# veiws (virtual table): the table that doesnot exist in reality they take the data from the base table
#veiws are created when u want to execute the same query many times, whenever run the query it is executed on latest data;

# constraint : NOT NULL and check constrint
CREATE TABLE Persons (ID int NOT NULL,LastName varchar(255) NOT NULL,FirstName varchar(255),Age int CHECK (Age>=18));


# window functions (cummulative , rank ,dense rank)
select name, marks, rank() over(order by marks) as ranked from ranks;
select name, marks, dense_rank() over(order by marks) as ranked from ranks;

# ALTER AND UPDATE 
# add col  :  ALTER TABLE alter_exp ADD COLUMN price int ;
# remove col :  ALTER TABLE alter_exp DROP price;
# add constrint (primary key) :  ALTER TABLE alter_exp ADD CONSTRAINT id PRIMARY KEY(id);
# remove constrint (primary key): ALTER TABLE alter_exp DROP PRIMARY KEY;
# change name of existing column : ALTER TABLE alter_exp CHANGE COLUMN id  item_id int; 
# change datatype of existing column : ALTER TABLE alter_exp CHANGE COLUMN item_id item_id varchar(20);
									 # ALTER TABLE alter_exp MODIFY COLUMN item_id BIGINT;
									 # : ALTER TABLE alter_exp MODIFY COLUMN item_id DOUBLE;
                                     # DOUBLE vs INT vs BIG int    

# DELETE  : DELETE FROM delete_exm WHERE name = 'phone';
# TRUNCATE  : TRUNCATE delete_exm;
# DROP      # DROP TABLE delete_exm;
#################################################################################################################################################
############################################### 20 JUNE 2023 ####################################################################################
CREATE DATABASE mocks;
USE mocks;

########## ENUM CONCEPT ################################ 
# population table
CREATE TABLE population ( age int, gender enum('m','f'), income int);
SELECT * FROM population;
INSERT INTO population VALUES (24,'f',10000),
							(23,'m',3000),
                            (29,'m',29000),
                            (18,'f',200000),
                            (38,'m',70000),
                            (40,'m',400),
                            (50,'f',200000),
                            (20,'f',40000),
                            (38,'m',390909),
                            (38,'f',87969);
SELECT * FROM population;

# QUE:1  reequirement to find mean avg income for males and females 
SELECT * FROM population;
SELECT gender , avg(income) FROM population GROUP BY gender;

# QUE:2 to get max income of male and female
SELECT gender ,max(income) FROM population GROUP BY gender;
 
# QUE:3 to get min income of male and female
SELECT gender, min(income) FROM population GROUP BY gender;
 
# QUE 4:  sorting  of income
SELECT * FROM population ORDER BY income desc ;
#######################################################################################################################
#p1startupexpansion table

#QUE 5 :  max revenue in each region 
SELECT * FROM p1startupexpansion;
SELECT MAX(Revenue) FROM p1startupexpansion GROUP BY SalesRegion;

# QUE 6: total revenue for region
SELECT SalesRegion,SUM(Revenue) as total_revenue FROM p1startupexpansion GROUP BY SalesRegion;

# QUE 7 : revenue for each region group by on salesregiom and state order by on revenue
SELECT State, SalesRegion, SUM(REVENUE) FROM  p1startupexpansion GROUP BY SalesRegion , state ORDER BY SUM(REVENUE) desc;

#######################################################################################################################
# p1officesupplies
SELECT * FROM p1officesupplies;

# QUE 8: sum of sales for each region.
SELECT Region , SUM(Units* `Unit Price`) FROM p1officesupplies GROUP BY region;

# QUE 9: highest selling item
SELECT Item , sum(Units) FROM p1officesupplies GROUP BY Item ORDER BY sum(Units) desc LIMIT 1;

# QUE 10: which rep has done the highest sales and which least sale
SELECT Rep , SUM(Units*`Unit Price`) FROM p1officesupplies GROUP BY Rep ORDER BY SUM(Units*`Unit Price`) desc LIMIT 1; 
SELECT Rep , SUM(Units*`Unit Price`) FROM p1officesupplies GROUP BY Rep ORDER BY SUM(Units*`Unit Price`)  LIMIT 1; 

# QUE 11: which item max value in dollar
SELECT Item, SUM(Units*`Unit Price`) FROM p1officesupplies GROUP BY Item ORDER BY SUM(Units*`Unit Price`) desc LIMIt 1;

#######################################################################################################################
#p1ukbankcustomers
SELECT * FROM  p1ukbankcustomers;

# QUE 12: mean income for job category
SELECT JobClassification, round(avg(Balance),2) FROM p1ukbankcustomers GROUP BY JobClassification;

# QUE 13:  mean income for gender along with job classification
SELECT Gender,JobClassification, avg(Balance) FROM p1ukbankcustomers GROUP BY JobClassification,Gender; 

# QUE 14: select the data only for those people who are white collar
SELECT * FROM p1ukbankcustomers WHERE JobClassification = 'White Collar';

# QUE 15: req to create table for male who are white collar
SELECT *  FROM p1ukbankcustomers WHERE  JobClassification = 'White Collar' AND gender = 'Male';

# QUE 16:  select record where job is blue collar and age more than 40
SELECT * FROM p1ukbankcustomers WHERE JobClassification = 'Blue Collar' AND age > 40;

# QUE 17:  requirement is to get data where balance is more than 40000 and less than 55000
SELECT * FROM p1ukbankcustomers WHERE Balance > 40000 AND Balance < 55000;

########################################## PATTERN MATCHING 21 june #########################################################################

# QUE 18:  all the names which start with da
SELECT * FROM p1ukbankcustomers;
SELECT * FROM p1ukbankcustomers WHERE Name LIKE 'da%';

# QUE 19: for getting 3 digit name including da
SELECT * FROM p1ukbankcustomers WHERE Name LIKE 'da_';

# QUE 20 : to get 'is' in name anywhere
SELECT * FROM p1ukbankcustomers WHERE Name LIKE '%is%';
SELECT DISTINCT(Name) FROm p1ukbankcustomers;

# QUE 21 : All records of ava or ryan or carl or grace or paul
SELECT * FROM  p1ukbankcustomers WHERE Name = 'Ava' OR NAME = 'Ryan' OR Name = 'Carl';
SELECT * FROM p1ukbankcustomers WHERE Name IN ('Ava','Ryan','Carl');

# QUE 22 : my requirement is to see all the data of person who has highest bal
SELECT * FROM p1ukbankcustomers ORDER BY Balance desc LIMIT 1;

# QUE 23 : To get the data with second highest balance USING LIMIT AND SUBQUERY 
SELECT * FROM p1ukbankcustomers ORDER BY Balance DESC LIMIT 1,1;
SELECT max(Balance) FROm p1ukbankcustomers WHERE Balance < (SELECT max(Balance) FROM p1ukbankcustomers);

# QUE 24 : create a output with two coloumn with name and  their count
SELECT name ,count(name) FROM p1ukbankcustomers GROUP BY name;

#######################################################################################################################
########################################### 22 JUNE ###################################################################
# employees database
SELECT * FROM employees; # emp_no, birth_date, first_name ,last_name, gender, hire_date
SELECT * FROM dept_emp;  #emp_no, dept_no, from_date, to_date
SELECT * FROM departments; #dept_no, dept_name
SELECT * FROM salaries; # emp_no, salary , from_date, to_date
SELECT * FROM dept_manager; #emp_no, dept_no, from_date, to_date
SELECT * FROM titles; #emp_no,title,from_date,to_date

# QUE 25 : To get the data to ur hr who have joined in yr 1995
SELECT * FROM employees WHERE hire_date >= '1995-01-01' AND hire_date <='1995-12-31';
SELECT * FROM employees WHERE hire_date BETWEEN '1995-01-01' AND '1995-12-31';

################################################## CASE statement ###############################################################################

# QUE 26: # Many times u r not interested in actual salary but salary bucket low salary, high salary, medium salary ,
#new  coloumn (salary less than 40000)
#> 40000 till 50000 medium
# if more than 50000 high
SELECT * FROM salaries;
SELECT *  ,
 CASE 
	WHEN  salary > 40000 AND salary <= 50000 THEN 'Medium'
    WHEN salary > 50000 THEN 'high'
END AS new_col
FROM salaries;

# QUE 27: create a coloumn which based on  below requirement  mark asst eng, eng , staff as entry level , senior engg and senior staff as mid_level
 #, mark tech lab and manager as msmt_level
 SELECT DISTINCT(title) FROM titles;
 SELECT * FROM titles;
 SELECT * , 
 CASE 
	WHEN title IN ('Assistant Engineer','Engineer','Staff') THEN 'ENTRY LEVEL'
    WHEN title IN ('Senior Engineer','Senior Staff') THEN 'mid_level'
    WHEN title IN ('Technique Leader','Manager') THEN 'mgmt_level'
END AS level
FROM titles ;

# QUE 27.1 # emp_no, dept_no,from_date,to_date, status--> left/working
USE employees;
SELECT * FROM dept_emp;
SELECT * , 
CASE 
	WHEN to_date > sysdate() THEN 'WORKING'
    ELSE 'LEFT'
END AS 'satus'
FROM dept_emp;
 
################################################## SUB QUERY ################################################################################
# QUE 28. Emp_no , first_name , last name for all manager using sub query
SELECT DISTINCT(title) FROM titles;
SELECT emp_no FROM titles WHERE title = 'Manager';
SELECT emp_no , first_name, last_name FROm employees WHERE emp_no IN (SELECT emp_no FROM titles WHERE title = 'Manager');
select emp_no,first_name,last_name from employees where emp_no in (select emp_no from dept_manager);

# QUE 29. Find 3rd highest salary using sub query and order by and limit
SELECT * FROM salaries;
SELECT max(salary) FROM salaries WHERE salary < (SELECT max(salary) FROm salaries WHERE salary < (SELECT max(salary) FROM salaries)); #'155709'
SELECT salary FROM salaries ORDER BY salary desc LIMIT 2,1; #  '155709'

# QUE 30. find all details of employee of managers whose salary is more than 100000 using subquery
# table used employee, manager , salary
SELECT * FROM salaries ;
SELECT * FROM dept_manager;

SELECT * FROM employees WHERE emp_no IN (SELECT emp_no FROM dept_manager WHERE emp_no IN (SELECT emp_no FROM salaries WHERE salary > 100000));


# QUE 31.  get the curent department of every employee # emp_no , dept_no
SELECT * FROM dept_emp;
SELECT emp_no , dept_no , max(from_date) FROM dept_emp  WHERE to_date > sysdate() GROUP BY emp_no ,dept_no;


############################################## cheack / NOT NULL constraint ################################################################################
USE mocks;
# QUE 32. create a table which has 2 coloumns id , mob 10 digit no(1000000000,9999999999) 10 digit only allowed

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int CHECK (Age>=18)
);
INSERT INTO Persons (ID,lastname, age) VALUES (1,'as',18);

############################################ ifnull /coalesce function ####################################################################################
create table ifnull_exm( 
purchae_id int,
cust_id int,
item_code varchar(10));

insert into ifnull_exm(purchae_id ,cust_id) values  (1,123), (10,456);
insert into ifnull_exm values  (30,45,'tv'), (20,60,'fridge');
SELECT * FROM ifnull_exm;
SELECT *, ifnull(item_code , 'not_present') FROM ifnull_exm;        
SELECT *, coalesce(item_code,'nan') FROM ifnull_exm;
#######################################################################################################################################################

################################################ rank() and dense rank() ################################################################################
create table ranks(name char, marks int);
insert into ranks values('a',	50),('b',59),('c',60),('d',45),('e',70),('f',60),('g',80),('h',64),('i',80),('m',80),('k',90);
SELECT * FROM ranks;
SELECT name, marks, RANK() OVER(ORDER BY marks desc) FROM ranks;
SELECT name, marks, dense_rank() OVER(ORDER BY marks) as denserank FROM ranks;

###########################################################################################################################################################

###################################### ALTER AND UPDATE #################################################################################################

create table alter_exp(id int,item_name varchar(20),city varchar(20));

SELECT * FROM alter_exp;ALTER TABLE alter_exp ADD COLUMN price int ;
ALTER TABLE alter_exp DROP price;
ALTER TABLE alter_exp ADD CONSTRAINT id PRIMARY KEY(id);
DESC alter_exp;
ALTER TABLE alter_exp DROP PRIMARY KEY;
ALTER TABLE alter_exp CHANGE COLUMN id  item_id int;
ALTER TABLE alter_exp CHANGE COLUMN item_id item_id varchar(20);
ALTER TABLE alter_exp MODIFY COLUMN item_id DOUBLE;
ALTER TABLE alter_exp MODIFY COLUMN item_id BIGINT;

########################################## DELETE / TRUNCATE / DROP ######################################################################
create table delete_exm(id int,name varchar(10));
insert into delete_exm values(11,'phone'),(23,'tv'),(45,'car');
SELECT * FROM delete_exm;
DELETE FROM delete_exm WHERE name = 'phone';

TRUNCATE delete_exm;
DROP TABLE delete_exm;
###############################################################################################################################################

############################### UPDATE ###################################################################################


################################### INDEX #############################################################################