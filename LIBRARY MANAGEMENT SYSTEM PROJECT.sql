CREATE DATABASE LIBRARY;

USE LIBRARY;

-- BRANCH

CREATE TABLE Branch 
(Branch_no INT PRIMARY KEY,
Manager_Id INT,
Branch_address VARCHAR(255),
Contact_no VARCHAR(15));

INSERT INTO Branch VALUES (1, 101, '123 Library St', '123-456-7890');
INSERT INTO Branch VALUES (2, 102, '456 Book Rd', '987-654-3210');

-- EMPLOYEE

CREATE TABLE Employee 
(Emp_Id INT PRIMARY KEY,
Emp_name VARCHAR(50),
Position VARCHAR(50),
Salary DECIMAL(10, 2),
Branch_no INT,
FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no));

INSERT INTO Employee VALUES (201, 'Alice', 'Manager', 60000, 1);
INSERT INTO Employee VALUES (202, 'Bob', 'Assistant', 40000, 1);
INSERT INTO Employee VALUES (203, 'Charlie', 'Manager', 65000, 2);

-- BOOKS

CREATE TABLE Books 
(ISBN VARCHAR(13) PRIMARY KEY,
Book_title VARCHAR(255),
Category VARCHAR(100),
Rental_Price DECIMAL(10, 2),
Status VARCHAR(3),
Author VARCHAR(100),
Publisher VARCHAR(100));

INSERT INTO Books VALUES ('978-3-16', 'SQL Fundamentals', 'Education', 30.00, 'yes', 'John Doe', 'Tech Press');
INSERT INTO Books VALUES ('978-1-23', 'Advanced SQL', 'Education', 45.00, 'no', 'Jane Smith', 'Data Press');

-- CUSTOMER

CREATE TABLE Customer 
(Customer_Id INT PRIMARY KEY,
Customer_name VARCHAR(100),
Customer_address VARCHAR(255),
Reg_date DATE);

INSERT INTO Customer VALUES (301, 'David', '789 Reader Ln', '2021-12-15');
INSERT INTO Customer VALUES (302, 'Eva', '456 Book Rd', '2023-01-10');

-- ISSUE STATUS

CREATE TABLE IssueStatus 
(Issue_Id INT PRIMARY KEY,
Issued_cust INT,
Issued_book_name VARCHAR(255),
Issue_date DATE,
Isbn_book VARCHAR(13),
FOREIGN KEY (Issued_cust) 
REFERENCES Customer(Customer_Id),
FOREIGN KEY (Isbn_book) 
REFERENCES Books(ISBN));

INSERT INTO IssueStatus VALUES (401, 301, 'SQL Fundamentals', '2023-06-15', '978-3-16');

-- RETURN STATUS

CREATE TABLE ReturnStatus 
(Return_Id INT PRIMARY KEY,
Return_cust INT,
Return_book_name VARCHAR(255),
Return_date DATE,
Isbn_book2 VARCHAR(13),
FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN));

INSERT INTO ReturnStatus VALUES (501, 301, 'SQL Fundamentals', '2023-07-01', '978-3-16');

-- 1
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

-- 2
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3
SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

-- 4
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;

-- 5
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

-- 8
SELECT Customer.Customer_name
FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- 9
SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

-- 10
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

-- 11
SELECT Employee.Emp_name, Branch.Branch_address
FROM Employee
JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;

-- 12
SELECT Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Books.Rental_Price > 25;
