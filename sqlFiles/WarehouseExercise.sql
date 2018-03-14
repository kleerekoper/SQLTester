-- Source: https://en.wikibooks.org/wiki/SQL_Exercises/The_warehouse

DROP TABLE IF EXISTS Boxes;
DROP TABLE IF EXISTS Warehouses;

CREATE TABLE Warehouses (
	Code INTEGER PRIMARY KEY NOT NULL,
	Location TEXT NOT NULL ,
	Capacity INTEGER NOT NULL 
);

CREATE TABLE Boxes (
	Code VARCHAR(10) PRIMARY KEY NOT NULL,
	Contents TEXT NOT NULL ,
	Value REAL NOT NULL ,
	Warehouse INTEGER NOT NULL, 
	CONSTRAINT fk_Warehouses_Code FOREIGN KEY (Warehouse) REFERENCES Warehouses(Code)
);

INSERT INTO Warehouses(Code,Location,Capacity) VALUES(1,'Chicago',3);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(2,'Chicago',4);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(3,'New York',7);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(4,'Los Angeles',2);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(5,'San Francisco',8);

INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('0MN7','Rocks',180,3);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4H8P','Rocks',250,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4RT3','Scissors',190,4);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('7G3H','Rocks',200,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8JN6','Papers',75,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8Y6U','Papers',50,3);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('9J6F','Papers',175,2);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('LL08','Rocks',140,4);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P0H6','Scissors',125,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P2T6','Scissors',150,2);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('TU55','Papers',90,5);

-- Insert into Tests
INSERT INTO admin_Tests (T_id, T_name, T_schemaPic) VALUES (5, "The Warehouse", "Warehouse.png");

INSERT INTO admin_TestPasswords(T_id, Password) VALUES (5, SHA1(""));


INSERT INTO admin_Questions (T_id, Category, Question, Answer)
VALUES

(5,"OneTableSelect", "List the locations and capacity of the warehouses.", "SELECT Location, Capacity FROM Warehouses;"),
(5,"OneTableSelect", "List the contents and value of the boxes.", "SELECT Contents, Value FROM Boxes;"),
(5,"OneTableSelect", "List the locations of the warehouses.", "SELECT Location FROM Warehouses;"),
(5,"OneTableSelect", "List the value of the boxes.", "SELECT Value FROM Boxes;"),

(5,"OneTableSelectWhere", "List the locations of warehouses with capacity of at least 4.",	"SELECT Location FROM Warehouses WHERE Capacity >= 4;"),
(5,"OneTableSelectWhere", "List the contents of boxes worth at least $100.",	"SELECT Contents FROM Boxes WHERE Value >= 100;"),
(5,"OneTableSelectWhere", "List the warehouse locations and capacities for warehouses in cities with two words in the name.",	"SELECT Location, Capacity FROM Warehouses WHERE Location LIKE '% %';"),
(5,"OneTableSelectWhere", "List the values of boxes containing Rocks or Scissors.",	"SELECT Contents, Value FROM Boxes WHERE Contents IN ('Rocks', 'Scissors');"),

(5,"OneTableSelectOrder", "List the contents of the boxes in alphabetical order (without duplications).", "SELECT DISTINCT Contents FROM Boxes ORDER BY Contents;"),
(5,"OneTableSelectOrder", "List the warehouse locations in reverse alphabetical order.",	"SELECT Location FROM Warehouses ORDER BY Location DESC;"),
(5,"OneTableSelectOrder", "List the contents of boxes in order from most to least valuable.",	"SELECT Contents, Value FROM Boxes ORDER BY Value DESC;"),
(5,"OneTableSelectOrder", "List the contents of boxes in order from least to most valuable.",	"SELECT Contents, Value FROM Boxes ORDER BY Value ASC;"),


(5,"RowFunction", "List the locations of warehouses in ALLCAPS.",	"SELECT UPPER(Location) AS Location FROM Warehouses;"),
(5,"RowFunction", "List the contents of boxes in lower case without duplications.",	"SELECT DISTINCT lower(Contents) AS contents FROM Boxes;"),
(5,"RowFunction", "List the contents and values of boxes in cents (i.e. multiplying values by 100).",	"SELECT Contents, Value * 100 AS \"Value in Cents\" FROM Boxes;"),
(5,"RowFunction", "List the location and capacity of the warehouses after increasing the capacity of all warehouses by 2.",	"SELECT Location, Capacity + 2 AS \"New Capacity\"FROM Warehouses;"),

(5,"GroupFunction", "Compute the average value of the boxes.",	"SELECT AVG(Value) AS \"Average Value\" FROM Boxes;"),
(5,"GroupFunction", "Compute the average capacity of the warehouses.",	"SELECT AVG(Capacity) AS \"Average Capacity\" FROM Warehouses;"),
(5,"GroupFunction", "Compute the value of the most expensive box.",	"SELECT MAX(Value) AS \"Most Expensive Box\" FROM Boxes;"),
(5,"GroupFunction", "Compute the number of boxes.",	"SELECT COUNT(*) AS \"Number of Boxes\" FROM Boxes;"),

(5,"InnerJoin", "List the contents, value and location name of the boxes.",	"SELECT Contents, Value, Location FROM Boxes INNER JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code;"),
(5,"InnerJoin", "List the contents of warehouses in Chicago.",	"SELECT Contents, Location FROM Boxes INNER JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code WHERE Location = 'Chicago';"),
(5,"InnerJoin", "List the value of boxes in warehouses with capacity less than 5.",	"SELECT Value, Capacity FROM Boxes INNER JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code WHERE Capacity < 5;"),
(5,"InnerJoin", "List the locations of warehouses with boxes containing Papers.",	"SELECT DISTINCT Location, Contents FROM Boxes INNER JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code WHERE Contents = 'Papers';"),
(5,"InnerJoin", "List the contents and locations of boxes.",	"SELECT Contents, Location FROM Boxes INNER JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code;"),
(5,"InnerJoin", "List the contents and value of boxes in cities containing an 'e'.",	"SELECT Contents, Value, Location FROM Boxes INNER JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code WHERE Location LIKE '%e%';"),
(5,"InnerJoin", "List the locations of warehouses with boxes containing either Rocks or Papers.",	"SELECT Contents, Location FROM Boxes INNER JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code WHERE Contents IN ('Rocks', 'Papers');"),
(5,"InnerJoin", "List the locations of boxes worth more than $150.",	"SELECT DISTINCT Location FROM Boxes INNER JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code WHERE Value > 150;"),

(5,"GroupBy", "Compute the average value of boxes in each location.",	"SELECT Location, AVG(Value) AS \"Average Value\" FROM Boxes INNER JOIN Warehouses ON Warehouses.Code = Boxes.Warehouse GROUP BY Location;"),
(5,"GroupBy", "Compute the number of boxes containing each type of contents.",	"SELECT Contents, COUNT(*) AS \"Number of Boxes\" FROM Boxes GROUP BY Contents;"),
(5,"GroupBy", "Compute the most expensive box in each location.",	"SELECT Location, MAX(Value) AS \"Most Expensive Box\" FROM Boxes INNER JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code GROUP BY Location;"),
(5,"GroupBy", "Compute the cheapest box in each location.",	"SELECT Location, MIN(Value) AS \"Cheapest Box\" FROM Boxes INNER JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code GROUP BY Location;"),

(5,"GroupByHaving", "List the warehouse codes of warehouses whose boxes have an average value between $150 and $175.",	"SELECT Warehouse, AVG(VALUE) AS \"Average Value\" FROM Boxes GROUP BY Warehouse HAVING AVG(VALUE) BETWEEN 150 AND 175;"),
(5,"GroupByHaving", "List the locations of warehouses whose most expensive boxes are worth between $100 and $200.",	"SELECT Location, MAX(Value) AS \"Most Expensive Box\" FROM Boxes INNER JOIN Warehouses ON Boxes.Warehouse = Warehouses.Code GROUP BY Location HAVING MAX(Value) BETWEEN 100 AND 200;"),
(5,"GroupByHaving", "List the contents where the average value of boxes with those contents is under $100.",	"SELECT Contents, AVG(Value) AS \"Average Value\" FROM Boxes GROUP BY Contents HAVING AVG(Value) < 100;"),
(5,"GroupByHaving", "List the contents where the cheapest box with those contents is over $125.",	"SELECT Contents, MIN(Value) AS \"Cheapest Box\" FROM Boxes GROUP BY Contents HAVING MIN(Value) > 125;"),

(5,"SimpleSubquery", "Compute the number of boxes with above-average values.",	"SELECT COUNT(*) AS \"Number of Boxes\" FROM Boxes WHERE Value > (SELECT AVG(Value) FROM Boxes);"),
(5,"SimpleSubquery", "List the location of the warehouse with the most valuable box.",	"SELECT Location FROM Warehouses INNER JOIN Boxes ON Warehouses.Code = Boxes.Warehouse WHERE Value =    (SELECT MAX(Value) FROM Boxes);"),
(5,"SimpleSubquery", "Compute the number of boxes with below-average values.",	"SELECT COUNT(*) AS \"Number of Boxes\" FROM Boxes WHERE Value <    (SELECT AVG(Value) FROM Boxes);"),
(5,"SimpleSubquery", "List the locations of the warehouses with below-average capacity.",	"SELECT DISTINCT Location FROM Warehouses WHERE Capacity <    (SELECT AVG(Capacity) FROM Warehouses);");

