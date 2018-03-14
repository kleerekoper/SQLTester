-- Source: https://en.wikibooks.org/wiki/SQL_Exercises/Employee_management

DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments (
	Code INTEGER PRIMARY KEY NOT NULL,
	Name TEXT NOT NULL ,
	Budget REAL NOT NULL 
);

CREATE TABLE Employees (
	SSN INTEGER PRIMARY KEY NOT NULL,
	Name TEXT NOT NULL ,
	LastName TEXT NOT NULL ,
	Department INTEGER NOT NULL , 
	CONSTRAINT fk_Departments_Code FOREIGN KEY(Department) 
	REFERENCES Departments(Code)
);
 
INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','O''Donnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);

-- Insert this Test
INSERT INTO admin_Tests (T_id, T_name, T_schemaPic) VALUES (2, "Employee Management", "Employees.png");

INSERT INTO admin_TestPasswords(T_id, Password) VALUES (2, SHA1(""));

-- Questions for this Test
INSERT INTO admin_Questions (T_id, Category, Question, Answer)
VALUES

(2, "OneTableSelect", "List the name, surname and department of all employees.", "SELECT Name, LastName, Department FROM Employees;"),
(2, "OneTableSelect", "List the name and budget of all departments.", "SELECT Name, Budget FROM Departments;"),
(2, "OneTableSelect", "List the SSN and surname of all employees.", "SELECT SSN, LastName FROM Employees;"),
(2, "OneTableSelect", "List the name of all departments.", "SELECT Name FROM Departments;"),

(2, "OneTableSelectWhere", "List the names of all employees in department 14.", "SELECT Name, LastName, Department FROM Employees WHERE Department = 14;"),
(2, "OneTableSelectWhere", "List the names of all departments with budgets greater than $60,000.", "SELECT Name, Budget FROM Departments WHERE Budget > 60000;"),
(2, "OneTableSelectWhere", "List the names of all departments with budgets between $25,000 and $100,000.", "SELECT Name, Budget FROM Departments WHERE Budget BETWEEN 25000 AND 100000;"),
(2, "OneTableSelectWhere", "List the names of all employees whose surnames start with an S.", "SELECT Name, LastName FROM Employees WHERE LastName LIKE 'S%';"),

(2, "OneTableSelectOrder", "List all departments in order of their budgets from highest to lowest.", "SELECT Name, Budget FROM Departments ORDER BY Budget DESC;"),
(2, "OneTableSelectOrder", "List the names of all employees in alphabetical order of surname and forename.", "SELECT Name, LastName FROM Employees ORDER BY LastName, Name;"),
(2, "OneTableSelectOrder", "List the names of the departments in alphabetical order.", "SELECT Name FROM Departments ORDER BY Name;"),
(2, "OneTableSelectOrder", "List the names of the departments in order of their budgets from lowest to highest.", "SELECT Name, Budget FROM Departments ORDER BY Budget ASC;"),

(2, "RowFunction", "List the names and monthly budgets of all departments (i.e. divide the budget by 12).", "SELECT Name, ROUND(Budget / 12,2) AS \"New Budget\" FROM Departments;"),
(2, "RowFunction", "List the surnames of all employees in upper case.", "SELECT upper(LastName) AS Surname FROM Employees;"),
(2, "RowFunction", "List the names and budgets of all departments after applying a 10% increase.", "SELECT Name, ROUND(Budget*1.1) AS \"Increased Budget\" FROM Departments;"),
(2, "RowFunction", "List the names of all employees in lower case.", "SELECT lower(name) AS Name, lower(LastName) AS Surname FROM Employees;"),

(2, "GroupFunction", "Compute the average budget for the departments.", "SELECT AVG(Budget) AS \"Average Budget\" FROM Departments;"),
(2, "GroupFunction", "Compute the number of employees.", "SELECT COUNT(*) AS \"Number of Employees\" FROM Employees;"),
(2, "GroupFunction", "Compute the number of departments.", "SELECT COUNT(*) AS \"Number of Departments\" FROM Departments;"),
(2, "GroupFunction", "Compute the largest budget from all the departments.", "SELECT MAX(Budget) AS \"Largest Budget\" FROM Departments;"),

(2, "InnerJoin", "List the names of the employees and the names of the departments they work in.", "SELECT e.Name, LastName, d.Name FROM Employees e INNER JOIN Departments d ON e.Department = d.Code;"),
(2, "InnerJoin", "List the names of employees who work in the IT department.", "SELECT e.Name, LastName, d.Name FROM Employees e INNER JOIN Departments d ON e.Department = d.Code WHERE d.Name = 'IT';"),
(2, "InnerJoin", "List the names of employees whose surnames begin with D and the name of the departments they work in.", "SELECT e.Name, LastName, d.Name FROM Employees e INNER JOIN Departments d ON e.Department = d.Code WHERE LastName LIKE 'D%';"),
(2, "InnerJoin", "List the names of employees who work in departments whose budgets are under $100,000.", "SELECT e.Name, LastName, Budget FROM Employees e INNER JOIN Departments d ON e.Department = d.Code WHERE Budget < 100000;"),
(2, "InnerJoin", "List the SSN numbers of employees in the Human Resources department.", "SELECT SSN, d.Name FROM Employees e INNER JOIN Departments d ON e.Department = d.Code WHERE d.Name = 'Human Resources';"),
(2, "InnerJoin", "List the names of all departments employing someone whose first name begins with a vowel.", "SELECT DISTINCT d.Name FROM Employees e INNER JOIN Departments d ON e.Department = d.Code WHERE e.Name LIKE 'A%' OR e.Name LIKE 'E%' OR e.Name LIKE 'I%' OR e.Name LIKE 'O%' OR e.Name LIKE 'U%';"),
(2, "InnerJoin", "List the name and budget of the department in which John Doe works.", "SELECT d.Name, Budget FROM Employees e INNER JOIN Departments d ON e.Department = d.Code WHERE e.Name = 'John' AND LastName = 'Doe';"),
(2, "InnerJoin", "List the SSN and surname of all employees and the budgets of their departments.", "SELECT SSN, LastName, Budget FROM Employees e INNER JOIN Departments d ON e.Department = d.Code;"), 

(2, "GroupBy", "Compute the number of employees per department.", "SELECT d.Name, COUNT(*) AS \"Number of Employees\" FROM Employees e INNER JOIN Departments d ON e.Department = d.Code GROUP BY d.Name;"),
(2, "GroupBy", "Compute the number of employees with each surname.", "SELECT LastName, COUNT(*) AS \"Number of Employees\" FROM Employees GROUP BY LastName;"),

(2, "GroupByHaving", "List the names of the departments with more than 2 employees.", "SELECT d.Name, COUNT(*) AS \"Number of Employees\" FROM Employees e INNER JOIN Departments d ON e.Department = d.Code GROUP BY d.Name HAVING COUNT(*)  > 2;"),
(2, "GroupByHaving", "List the surnames where only one employee has that surname.", "SELECT LastName, COUNT(*) AS \"Number of Employees\" FROM Employees GROUP BY LastName HAVING COUNT(*) = 1;"),

(2, "SimpleSubquery", "Compute the name and budget of the department with the largest budget.", "SELECT Name, Budget FROM Departments WHERE Budget =     (SELECT MAX(Budget) FROM Departments);"),
(2, "SimpleSubquery", "Compute the name of the department with the smallest budget.", "SELECT Name, Budget FROM Departments WHERE Budget =    (SELECT MIN(Budget) FROM Departments);"),
(2, "SimpleSubquery", "List the name and budget of all departments whose budgets are below average.", "SELECT Name, Budget FROM Departments WHERE Budget <   (SELECT AVG(Budget) FROM Departments);"),
(2, "SimpleSubquery", "List the name and budget of all departments whose budgets are above average.", "SELECT Name, Budget FROM Departments WHERE Budget >   (SELECT AVG(Budget) FROM Departments);");

