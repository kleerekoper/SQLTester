-- Source: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store

DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Manufacturers;

CREATE TABLE Manufacturers (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (Code)   
);

CREATE TABLE Products (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL ,
  Price DECIMAL NOT NULL ,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code), 
  FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
);


INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);

-- Insert this Test
INSERT INTO admin_Tests (T_id, T_name, T_schemaPic) VALUES (1, "The Computer Store", "Computer-store-db.png");

INSERT INTO admin_TestPasswords(T_id, Password) VALUES (1, SHA1(""));

-- Questions for this Test
INSERT INTO admin_Questions (T_id, Category, Question, Answer)
VALUES

(1, "OneTableSelect", "List the names of all the products in the store.","SELECT Name FROM Products;"),
(1, "OneTableSelect", "List the names and price of all the products in the store.","SELECT Name, Price FROM Products;"),
(1, "OneTableSelect", "List the names of all manufacturers.",	"SELECT Name FROM Manufacturers;"),
(1, "OneTableSelect", "List the prices of all products in the store.","SELECT Price FROM Products;"),

(1, "OneTableSelectWhere", "List the name of the products with a price less than or equal to $200.","SELECT Name FROM Products WHERE Price <= 200;"),
(1, "OneTableSelectWhere", "List all the products with a price between $60 and $120.","SELECT * FROM Products WHERE Price >= 60 AND Price <= 120;"),
(1, "OneTableSelectWhere", "List the name and prices of all \"drive\" products.", "SELECT Name, Price FROM Products WHERE Name LIKE '%drive%';"),
(1, "OneTableSelectWhere", "List the names of all manufacturers who do not have an 'e' in their name.","SELECT Name FROM Manufacturers WHERE Name NOT LIKE '%e%';"),

(1, "OneTableSelectOrder", "List the names of all the products in the store in alphabetical order.","SELECT Name FROM Products ORDER BY Name ASC;"),
(1, "OneTableSelectOrder", "List the names and price of all the products in the store in order from most expensive to least expensive.","SELECT Name, Price FROM Products ORDER BY Price DESC;"),
(1, "OneTableSelectOrder", "List the names of all manufacturers in reverse alphabetical order.","SELECT Name FROM Manufacturers ORDER BY Name DESC;"),
(1, "OneTableSelectOrder", "List the prices of all products in the store from cheapest to most expensive.","SELECT Price FROM Products ORDER BY Price ASC;"),

(1, "RowFunction", "List the name and price in cents (i.e., the price must be multiplied by 100).","SELECT Name, Price * 100 AS Price FROM Products;"),
(1, "RowFunction", "List the name and price of products after first applying a 10% discount to all products.","SELECT Name, Price * 0.9 AS \"Discounted Price\" FROM Products;"),
(1, "RowFunction", "List the names of all manufacturers in lower case.","SELECT lower(Name) AS Name FROM Manufacturers;"),
(1, "RowFunction", "List the names of all products in ALLCAPS.", "SELECT upper(Name) AS Name FROM Products;"),

(1, "GroupFunction", "Compute the average price of all the products.","SELECT AVG(Price) as \"Average Price\" FROM Products;"),
(1, "GroupFunction", "Compute the average price of all products with manufacturer code equal to 2.","SELECT AVG(Price) as \"Average Price\" FROM Products WHERE Manufacturer=2;"),
(1, "GroupFunction", "Compute the number of products with a price larger than or equal to $180.","SELECT COUNT(*) as \"Number of Products\" FROM Products WHERE Price >= 180;"),
(1, "GroupFunction", "Compute the difference between the most expensive and least expensive product.","SELECT MAX(Price) – MIN(Price) AS Difference FROM Products;"),

(1, "InnerJoin", "List the name of all products sold by Creative Labs.","SELECT p.Name FROM Products p INNER JOIN Manufacturers m ON p.Manufacturer = m.Code WHERE m.Name = 'Creative Labs';"),
(1, "InnerJoin", "List the product name, price, and manufacturer name of all the products.","SELECT p.Name as \"Product Name\", Price, m.Name as \"Manufacturer Name\" FROM Products p, Manufacturers m WHERE p.Manufacturer = m.Code;"),
(1, "InnerJoin", "List the name and price of all products sold by Hewlett-Packard.","SELECT p.Name, Price FROM Products p INNER JOIN Manufacturers m ON p.Manufacturer = m.Code WHERE m.Name = 'Hewlett-Packard';"),
(1, "InnerJoin", "List the name of all manufacturers who supply drives.","SELECT DISTINCT m.Name FROM Manufacturers m INNER JOIN Products p ON m.Code = p.Manufacturer WHERE p.Name LIKE '%drive%';"),
(1, "InnerJoin", "List the name of all manufacturers who supply products selling for more than $150.","SELECT DISTINCT m.Name FROM Manufacturers m INNER JOIN Products p ON m.Code = p.Manufacturer WHERE Price > 150;"),
(1, "InnerJoin", "List the name of all products costing less than $100 and the name of their manufacturer.","SELECT p.Name AS Product, m.name AS Manufacturer FROM Products p INNER JOIN Manufacturers m ON p.Manufacturer = m.Code WHERE Price < 100;"),
(1, "InnerJoin", "List the price of all products sold by Sony.", "SELECT Price FROM Products p INNER JOIN Manufacturers m ON p.Manufacturer = m.Code WHERE m.Name = 'Sony';"),
(1, "InnerJoin", "List the names of all products and manufacturer in alphabetical order of manufacturer then product.", "SELECT p.Name, m.Name FROM Products p INNER JOIN Manufacturers m ON p.Manufacturer = m.Code ORDER BY m.Name, p.Name;"),

(1, "GroupBy", "Compute the average price of each manufacturer's products, showing only the manufacturer's code.","SELECT AVG(Price) as \"Average Price\", Manufacturer FROM Products GROUP BY Manufacturer;"),
(1, "GroupBy", "Compute the average price of each manufacturer's products, showing the manufacturer's name.","SELECT AVG(Price) as \"Average Price\", Manufacturers.Name as \"Manufacturer Name\" FROM Products, Manufacturers WHERE Products.Manufacturer = Manufacturers.Code GROUP BY Manufacturers.Name;"),
(1, "GroupBy", "Compute the most expensive product sold by each manufacturer.",	"SELECT m.Name, MAX(Price) AS Price FROM Products p INNER JOIN Manufacturers m ON p.Manufacturer = m.Code GROUP BY m.Name;"),
(1, "GroupBy", "Compute the number of products sold by each manufacturer.",	"SELECT m.Name, COUNT(*) AS \"Number of Products\" FROM Products p INNER JOIN Manufacturers m ON p.Manufacturer = m.Code GROUP BY m.Name;"),

(1, "GroupByHaving", "List the names of manufacturers whose products have an average price larger than or equal to $150.","SELECT AVG(Price) as \"Average Price\", m.Name as \"Manufacturer Name\"  FROM Products p, Manufacturers m WHERE p.Manufacturer = m.Code  GROUP BY m.Name HAVING AVG(Price) >= 150;"),
(1, "GroupByHaving", "List the names of the manufacturers whose most expensive products cost more than $175.",	"SELECT m.Name, MAX(Price) AS Price FROM Products p INNER JOIN Manufacturers m ON p.Manufacturer = m.Code GROUP BY m.Name HAVING MAX(Price) > 175;"),
(1, "GroupByHaving", "List the names of the manufacturers whose most expensive products cost under $200.",	"SELECT m.Name, MAX(Price) AS Price FROM Products p INNER JOIN Manufacturers m ON p.Manufacturer = m.Code GROUP BY m.Name HAVING MAX(Price) < 200;"),
(1, "GroupByHaving", "List the names of the manufacturers who supply more than 1 product.","SELECT m.Name, COUNT(*) AS \"Number of Products\" FROM Products p INNER JOIN Manufacturers m ON p.Manufacturer = m.Code GROUP BY m.Name HAVING COUNT(*) > 1;"),

(1, "SimpleSubquery", "Compute the name and price of the cheapest product.","SELECT Name, Price  FROM Products WHERE Price =    (SELECT MIN(Price) FROM Products);"),
(1, "SimpleSubquery", "Compute the name and price of the most expensive product.","SELECT Name, Price FROM Products WHERE Price =    (SELECT MAX(Price) FROM Products);"),
(1, "SimpleSubquery", "List the name of all products which cost less than the average of all products.",	"SELECT Name, Price FROM Products WHERE Price  <   (SELECT AVG(Price) FROM Products);"),
(1, "SimpleSubquery", "List the name of all products which cost more than the average of all products.",	"SELECT Name, Price FROM Products WHERE Price  >   (SELECT AVG(Price) FROM Products);");