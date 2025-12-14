SQL placement notes:

DB: collection of data in a format that can be accessed easily.
DBMS: software application used to manage DB

user accesses DBMS to access data in DB

SQL is used for DBMS - made by IBM

DB: relational - mySQL, oracle, PostgreSQL and non relational - mongoDB

SQL: Structered query lang - 
-comp understands it 
-is used to interact with computer 
-to perform CRUD operations
-used to interact with relational db

DB has many tables like college db has inter related tables for student, fees, courses

Table has cols -> structure/schema(design) and 
          rows -> individual student ka data

while creating a table, u need to mention which all cols

sql is not case sensitive

CREATE DATABASE college;

DROP DATABASE db_name; - deletes the database

USE college;

CREATE TABLE table_name(
col_name1 datatype constraint,
col_name2 datatype constraint,
col_name3 datatype constraint
);

CREATE TABLE student(
id INT PRIMARY KEY,
name VARCHAR(50),
age INT NOT NULL
);

INSERT INTO student VALUES(1, "aman", 26);

SELECT * FROM student;

Datatypes: char(50) - strings of fixed length, varchar(50)-upto given length, blob- large binary obj like file data int, double, float, date-yyyy-mm-dd, year, boolean

signed n unsigned- only for numeric datatyes
signed datatype => can be +ve or -ve
unsigned => only positive - like age, salary - to increase range

eg: TINYINT (-128- 127)
TINYINT UNSIGNED (0-255)


Types of SQL Commands:
DDL: Data definition lang - create, alter, rename, truncate, drop
DQL: Data query lang - select
DML: Data manipulation lang - insert, update, delete
DCL: Data control lang - grant and revoke permissions to user
TCL: Transaction control lang - start transaction, commit, rollback


CREATE DATABASE IF NOT EXISTS college;
DROP DATABSE IF EXISTS college;

SHOW DATABASES;
SHOW TABLES;


Table related queries:

CREATE TABLE student(
rollno INT PRIMARY KEY,
name VARCHAR(50)
);

primary key - is not null, has to be unique

SELECT * FROM student;

To add data:
INSERT INTO student
(rollno, name) VALUES (101,"karan"),(102,"arjun"); 

or INSERT INTO student VALUES(104, "ram");.. for single values inserting


Keys: special col in dbs

Primary key: 
-uniquely identifies a row
-can't be null
-there is only one primary key

Foreign key:
-refers to primary key of another table
-can have duplicate and null values
-there can be multiple foreign keys

eg: student table
id(pk), name, cityid(fk), city

city table
id(pk), city_name


Constraints: to specify rules for data in a table
-NOT NULL eg:col1 int NOT NULL
-UNIQUE
-PRIMARY KEY
-DEFAULT
-CHECK


CREATE TABLE temp1(
id INT,
name VARCHAR(50),
age INT, 
city VARCHAR(20),
PRIMARY KEY(id, name)
);

salary INT DEFAULT 25000;

CREATE TABLE temp(
cust_id int,
FOREIGN KEY (cust_id) references customer(id)
);
here customer is another table and id is its PK


CREATE TABLE newTab(
age INT CHECK(age >= 18)
CONSTRAINT age_check CHECK (age>=18 AND city="Delhi")
); 

 
SELECT:
to select any data from the database

SELECT name, marks FROM student;
SELECT * FROM student;

SELECT DISTINCT city FROM student; - to get only unique values

Clauses:
-WHERE
SELECT * FROM student WHERE marks+10 > 80;
SELECT * FROM student WHERE city= "Mumbai" AND/OR marks = 80;

operators with WHERE clause:
arithmetic: +,-,*,/,%
comparision: =,!=,>,<,>=,<=
logical: AND, OR, NOT, IN, BETWEEN, ALL, LIKE, ANY
bitwise: &,|

SELECT * FROM student WHERE marks BETWEEN 80 AND 90;
SELECT * FROM student WHERE city IN ("Delhi","Mumbai");
SELECT * FROM student WHERE city NOT IN ("Delhi","Mumbai");

-LIMIT
SELECT * FROM student LIMIT 3; -first 3 students data is shown

-ORDER BY(to sort in asc or desc order)
SELECT * FROM student ORDER BY city ASC;
SELECT * 
FROM student 
ORDER BY marks DESC 
LIMIT 3;


AGGREGATE Functions:
perform calculations on a set of values and return a single value
-COUNT()
-MAX()
-MIN()
-SUM()
-AVG()

SELECT max(marks) FROM student;
SELECT avg(marks) FROM student;

-GROUP BY clause
groups rows that have the same values into summary rows
it collects data from multiple records and groups the result by one or more column

genrally used with aggregate function

eg: count number of students in each city
SELECT city, count(name) 
FROM student 
GROUP BY city;

SELECT city, name, count(name) 
FROM student 
GROUP BY city, name;
 
u need to select only those cols that u have grouped based on


Question:
1. write query to find avg marks in each city in asc order

SELECT city, avg(marks)
FROM student
GROUP BY city
ORDER BY avg(marks) ASC;

2. find total payment acc to each payment method

SELECT mode, count(customer)
FROM payment
GROUP BY mode
ORDER BY count(customer);


-HAVING clause
to define conditions after grouping

WHERE is on rows
HAVING is used to apply conditions on Groups

SELECT count(name), city
FROM student
GROUP BY city
HAVING max(marks) >90;


General order:
SELECT coulmn(s)
FROM table_name
WHERE condition
GROUP BY column(s)
HAVING condition
ORDER BY column(s) ASC;

W GHO - to remember
where puts conditions on rows
having puts conditions on groups

eg: SELECT city 
    FROM student
    WHERE grade = "A"
    GROUP BY city
    HAVING MAX(marks) >93
    ORDER BY city DESC;


TABLE RELATED QUERIES:
UPDATE tablename 
SET col1 = val1, col2=val2
WHERE condition;

UPDATE student 
SET grade = "0"
WHERE grade = "A";

UPDATE student 
SET marks = 82
WHERE rollno = 105;

UPDATE student 
SET marks = marks + 1;

SET SQL_SAFE_UPDATES=0;..to exit frm safe mode n update

Delete: to delete some existing rows
DELETE FROM student 
WHERE marks < 33;

DELETE FROM student; - deletes entire table ka data

FOREIGN KEY(dept_id) references dept(id)
ON DELETE CASCADE - on deleting in table, in other one also it gets deleted
ON UPDATE CASCADE - matches updation ;
parent and child table


ALTER - to chng schema
ALTER TABLE table_name
ADD COLUMN col_name datatype constraint;
DROP COLUMN col_name; 
RENAME TO new_table_name;
MODIFY col_name new_datatype new_constraint;
CHANGE COLUMN old_name new_name new_datatype new_constraint;

TRUNCATE TABLE table_name;
- deletes table data only

DROP - deletes table only

Q. chng name of col "name" to "full_name", delete all students who scored <80, delete grades col

ALTER TABLE student
CHANGE name full_name VARCHAR(50);

DELETE FROM student WHERE marks<80;

ALTER TABLE student
DROP COLUMN grades;



JOINS:
to combine rows from two or more tables based on a related column between them

employee - name, id
salary - id,salary

combine these two to get common info .. here id is common column
not necessary to have a foreign key

types:
1. Inner join
ret records tht hv matching val in both tables

SELECT column(s)
FROM tableA
INNER JOIN tableB
ON tableA.col_name = tableB.col_name;

SELECT * 
FROM student 
INNER JOIN course
ON student.student_id = course.student_id;

2. Outer join
- Left join
ret all records frm left table n matched records from right table
SELECT column(s)
FROM tableA
LEFT JOIN tableB
ON tableA.col_name = tableB.col_name;

- Right join
ulta compared to left join
SELECT *
FROM student as a
RIGHT JOIN course as b
ON a.id = b.id;

 
- Full join
union of left n right join

SELECT *
FROM student as a
LEFT JOIN course as b
ON a.id = b.id;
UNION
SELECT *
FROM student as a
RIGHT JOIN course as b
ON a.id = b.id;

-LEFT EXCLUSIVE JOIN
SELECT column(s)
FROM tableA
LEFT JOIN tableB
ON tableA.col_name = tableB.col_name
WHERE b.id IS NULL;

-RIGHT EXCLUSIVE JOIN
SELECT column(s)
FROM tableA
LEFT JOIN tableB
ON tableA.col_name = tableB.col_name
WHERE a.id IS NULL;


subqueries: query inside query
eg: display marks of students whose marks is more than avg marks

SELECT name FROM student WHERE marks > (SELECT AVG(marks) FROM student);
SELECT MAX(marks)
FROM (SELECT * FROM student WHERE city = "Delhi") AS temp;


Hackerrank questions:

Determine type of triangle:
select (case 
       when not(a+b>c and a+c>b and b+c>a) then "Not A Triangle"
       when a=b and b=c then "Equilateral"
       when a=b or b=c or a=c then "Isosceles"
       else "Scalene" end) from TRIANGLES;

Aggregate functions:
select avg(POPULATION) from CITY where DISTRICT='California';
select sum(POPULATION) from CITY where DISTRICT='California';
select count(POPULATION) from CITY where DISTRICT='California';
select round (avg(POPULATION)) from CITY;
select (max(POPULATION)-min(POPULATION)) from CITY;
select ceil(avg(salary)- avg(replace(salary, "0",""))) from EMPLOYEES;

Shortest and longest city names:
select city, length(city) from station
order by length(city) asc, city asc
limit 1;
select city,length(city) from station
order by length(city) desc, city asc
limit 1;

City starting with vowel:
SELECT CITY FROM STATION WHERE CITY like 'a%' or CITY like 'e%' or CITY like 'i%' or CITY like 'o%' or CITY like 'u%'
Ending with vowels => %a like that
or u can use SELECT DISTINCT CITY FROM STATION WHERE RIGHT(CITY, 1) IN ('A', 'E', 'I', 'O', 'U')

Smallest latitude rounded to 4 places:
select ROUND(LAT_N, 4) FROM STATION where LAT_N > 38.7780 order by LAT_N ASC LIMIT 1;


Joins:
select sum of populations of cities in asia
select sum(c.POPULATION)
from CITY as c
INNER JOIN COUNTRY as d
ON 
c.COUNTRYCODE = d.CODE
where d.CONTINENT = "Asia";

Average Population of Each Continent
SELECT COUNTRY.CONTINENT, FLOOR(AVG(CITY.POPULATION)) FROM COUNTRY
INNER JOIN CITY
ON CITY.COUNTRYCODE = COUNTRY.CODE
GROUP BY COUNTRY.CONTINENT;

Max annual salary employees
SELECT salary*months, COUNT(employee_id) FROM employee
WHERE salary*months = (SELECT MAX(salary*months) FROM employee)
GROUP BY salary*months;


Some functions:
LOWER('string') - to convert to lowercase
INITCAP('string') - first letter in uppercase baki in lowercase
UPPER('string') - to convert to uppercase
Trim(s) - to remove spaces in string
length(city)
ROUND(val,no of decimal places)
FLOOR(val)
CEIL(val)
RIGHT(city,1)-last char of string
LEFT(city,1)-first char of string
LTRIM - removes leading spaces from a string
SELECT CONCAT('W3Schools', '.com'); - adds multiple strings together
SELECT SUBSTRING('SQL Tutorial', 1, 3) AS ExtractString; - Extract 3 characters from a string, starting in position 1: 
SELECT SUBSTRING(CustomerName, 1, 5) AS ExtractString
FROM Customers;
SELECT REVERSE('SQL Tutorial');
SELECT CHARINDEX('OM', 'Customer') AS MatchPosition; - CHARINDEX() function searches for a substring in a string, and returns the position.

SELECT FIRST(AGE) AS AgeFirst FROM Students;
SELECT LAST(AGE) AS AgeLast FROM Students; - to select first n last values in table
SELECT LCASE(NAME) FROM Students;
SELECT UCASE(NAME) FROM Students; - to convert all values to upper and lower case
LEN- length, MID is same as substring
SELECT NOW() FROM table_name;- gives current date and time
SELECT NAME, NOW() AS DateTime FROM Students; 
SELECT NAME, FORMAT(Now(),'YYYY-MM-DD') AS Date FROM Students; - format function to format data as per requirement



Questions for interview:
https://www.geeksforgeeks.org/sql-interview-questions/
https://www.interviewbit.com/sql-interview-questions/
https://takeuforward.org/interviews/must-do-questions-for-dbms-cn-os-interviews-sde-core-sheet/
