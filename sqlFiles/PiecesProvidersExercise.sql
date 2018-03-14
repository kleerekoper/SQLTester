-- Source: https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers

DROP TABLE IF EXISTS Provides;
DROP TABLE IF EXISTS Providers;
DROP TABLE IF EXISTS Pieces;

CREATE TABLE Pieces (
	Code INTEGER PRIMARY KEY NOT NULL,
	Name TEXT NOT NULL
);

CREATE TABLE Providers (
	Code VARCHAR(10) PRIMARY KEY NOT NULL,
	Name TEXT NOT NULL
);

CREATE TABLE Provides (
	Piece INTEGER REFERENCES Pieces(Code),
	Provider VARCHAR(10) REFERENCES Providers(Code),
	Price INTEGER NOT NULL,
	PRIMARY KEY(Piece, Provider)
);

INSERT INTO Providers(Code, Name) VALUES('HAL','Clarke Enterprises');
INSERT INTO Providers(Code, Name) VALUES('RBT','Susan Calvin Corp.');
INSERT INTO Providers(Code, Name) VALUES('TNBC','Skellington Supplies');

INSERT INTO Pieces(Code, Name) VALUES(1,'Sprocket');
INSERT INTO Pieces(Code, Name) VALUES(2,'Screw');
INSERT INTO Pieces(Code, Name) VALUES(3,'Nut');
INSERT INTO Pieces(Code, Name) VALUES(4,'Bolt');

INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'HAL',10);
INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'HAL',20);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'TNBC',14);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'RBT',50);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'TNBC',45);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'HAL',5);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'RBT',7);

-- Insert this Test
INSERT INTO admin_Tests (T_id, T_name, T_schemaPic) VALUES (4, "Pieces and Providers", "Pieces_providers.png");

INSERT INTO admin_TestPasswords(T_id, Password) VALUES (4, SHA1(""));


-- Questions for this Test
INSERT INTO admin_Questions (T_id, Category, Question, Answer)
VALUES

(4, "OneTableSelect", "List the names of all the pieces.", "SELECT Name FROM Pieces;"),
(4, "OneTableSelect", "List the names of all providers.", "SELECT Name FROM Providers;"),
(4, "OneTableSelect", "List the name and code of all pieces.", "SELECT Name, Code FROM Pieces;"),
(4, "OneTableSelect", "List the name and code of all providers.", "SELECT Name, Code FROM Providers;"),

(4, "OneTableSelectWhere", "List the names of all pieces starting with an S.", "SELECT Name FROM Pieces WHERE Name LIKE 'S%';"),
(4, "OneTableSelectWhere", "List the names of all providers with a C in their name.", "SELECT Name FROM Providers WHERE Name LIKE '%C%';"),
(4, "OneTableSelectWhere", "List the code of all providers who provide a product costing between $15 and $45.", "SELECT DISTINCT Provider FROM Provides WHERE Price BETWEEN 15 AND 45;"),
(4, "OneTableSelectWhere", "List the name of all pieces whose name contains no more than 5 characters.", "SELECT Name FROM Pieces WHERE length(Name) <= 5;"),

(4, "OneTableSelectOrder", "List the names of all pieces in alphabetical order.", "SELECT Name FROM Pieces ORDER BY Name;"),
(4, "OneTableSelectOrder", "List the name of all providers in reverse alphabetical order.", "SELECT Name FROM Providers ORDER BY Name DESC;"),
(4, "OneTableSelectOrder", "List the name of pieces in reverse alphabetical order.", "SELECT Name FROM Pieces ORDER BY Name DESC;"),
(4, "OneTableSelectOrder", "List the name of all providers in alphabetical order.", "SELECT Name FROM Providers ORDER BY Name;"),

(4, "RowFunction", "List the names of the pieces in ALLCAPS.", "SELECT upper(Name) AS Name FROM Pieces;"),
(4, "RowFunction", "List the names of the providers in lower-case.", "SELECT lower(Name) AS Name FROM Providers;"),
(4, "RowFunction", "List the prices of all pieces after applying a 7.5% discount.", "SELECT Price * 0.925 AS \"Discounted Price\" FROM Provides;"),
(4, "RowFunction", "List the prices of all pieces increased by $2.50 for postage.", "SELECT Price  + 2.5 AS \"Including Postage\" FROM Provides;"),

(4, "GroupFunction", "Compute the total number of providers.", "SELECT COUNT(*) AS \"Number of Providers\" FROM Providers;"),
(4, "GroupFunction", "Compute the average price of the pieces.", "SELECT AVG(Price) AS \"Average Price\" FROM Provides;"),
(4, "GroupFunction", "Compute the difference between the most expensive and cheapest piece.", "SELECT MAX(Price) - MIN(Price) AS Difference FROM Provides;"),
(4, "GroupFunction", "Compute half the price of the most expensive piece.", "SELECT 0.5*MAX(Price) AS \"Half Most Expensive\" FROM Provides;"),

(4, "InnerJoin", "List the name, provider code and price of every piece.", "SELECT Name, Provider, Price FROM Pieces INNER JOIN Provides ON Pieces.Code = Provides.Piece;"),
(4, "InnerJoin", "List the name of the pieces and the providers of those pieces.", "SELECT Pieces.Name, Providers.Name FROM Pieces INNER JOIN Provides  ON Pieces.Code = Provides.Piece INNER JOIN Providers    ON Provides.Provider = Providers.Code;"),
(4, "InnerJoin", "List the name of the providers and the price of their products.", "SELECT Name, Price FROM Providers INNER JOIN Provides    ON Provides.Provider = Providers.Code;"),
(4, "InnerJoin", "List the name of the pieces and their price.", "SELECT Name, Price FROM Pieces INNER JOIN Provides ON Pieces.Code = Provides.Piece;"),
(4, "InnerJoin", "List the names and prices of products provided by Clarke Enterprises.", "SELECT Pieces.Name, Provides.Price FROM Pieces  INNER JOIN Provides    ON Pieces.Code = Provides.Piece INNER JOIN Providers    ON Provides.Provider = Providers.Code WHERE Providers.Name = \"Clarke Enterprises\";"),
(4, "InnerJoin", "List the names of the pieces costing less than $40.", "SELECT Name, Price FROM Pieces INNER JOIN Provides ON Pieces.Code = Provides.Piece WHERE Price < 40;"),
(4, "InnerJoin", "List the names of the companies that provide Sprockets.", "SELECT Pieces.Name, Providers.Name FROM Pieces  INNER JOIN Provides   ON Pieces.Code = Provides.Piece INNER JOIN Providers   ON Provides.Provider = Providers.Code WHERE Pieces.Name = 'Sprocket';"),
(4, "InnerJoin", "List the name and price of every piece provided by the provider with code RBT.", "SELECT Name, Provider, Price FROM Pieces INNER JOIN Provides ON Pieces.Code = Provides.Piece WHERE Provider = 'RBT';"),

(4, "GroupBy", "Compute the average price of the pieces provided by each provider.", "SELECT Providers.Name, ROUND(AVG(Price),2) AS \"Average Price\" FROM Provides INNER JOIN Providers ON Provides.Provider = Providers.Code GROUP BY Providers.Name;"),
(4, "GroupBy", "Compute the number of pieces provided by each provider.", "SELECT Providers.Name, COUNT(*) AS \"Number of Pieces\" FROM Provides INNER JOIN Providers ON Provides.Provider = Providers.Code GROUP BY Providers.Name;"), 
(4, "GroupBy", "Compute the price of the most expensive piece from each provider.", "SELECT Providers.Name, MAX(Price) AS Price FROM Providers INNER JOIN Provides ON Provides.Provider = Providers.Code GROUP BY Providers.Name;"),
(4, "GroupBy", "Compute the price of the cheapest piece from each provider.", "SELECT Providers.Name, MIN(Price) AS Price FROM Providers INNER JOIN Provides ON Provides.Provider = Providers.Code GROUP BY Providers.Name;"),

(4, "GroupByHaving", "Compute the average price of the pieces provided by each provider where the average is between $20 and $30.", "SELECT Providers.Name, ROUND(AVG(Price),2) AS \"Average Price\" FROM Provides INNER JOIN Providers ON Provides.Provider = Providers.Code GROUP BY Providers.Name HAVING AVG(Price) BETWEEN 20 AND 30;"),
(4, "GroupByHaving", "Compute the number of pieces provided by each provider for those providing at least 3 pieces.", "SELECT Providers.Name, COUNT(*) AS \"Number of Pieces\" FROM Provides INNER JOIN Providers ON Provides.Provider = Providers.Code GROUP BY Providers.Name HAVING COUNT(*) >= 3;"), 
(4, "GroupByHaving", "Compute the price of the most expensive piece from each provider, if the most expensive piece costs $45 .", "SELECT Providers.Name, MAX(Price) AS Price FROM Providers INNER JOIN Provides ON Provides.Provider = Providers.Code GROUP BY Providers.Name HAVING MAX(Price) = 45;"),
(4, "GroupByHaving", "Compute the price of the cheapest piece from each provider, if the cheapest is no more than $10.", "SELECT Providers.Name, MIN(Price) AS Price FROM Providers INNER JOIN Provides ON Provides.Provider = Providers.Code GROUP BY Providers.Name HAVING MIN(Price) <= 10;"),

(4, "SimpleSubquery", "Compute the name of the provider selling the cheapest piece.", "SELECT Providers.Name, Provides.Price FROM Providers INNER JOIN Provides ON Provides.Provider = Providers.Code WHERE Provides.Price =    (SELECT MIN(Price) FROM Provides);"),
(4, "SimpleSubquery", "Compute the name of the provider selling the most expensive piece.", "SELECT Providers.Name, Provides.Price FROM Providers INNER JOIN Provides ON Provides.Provider = Providers.Code WHERE Provides.Price =    (SELECT MAX(Price) FROM Provides);"),
(4, "SimpleSubquery", "List the names of the pieces that cost more than the average.", "SELECT Pieces.Name, Price FROM Pieces INNER JOIN Provides ON Pieces.Code = Provides.Piece WHERE Price >   (SELECT AVG(Price) FROM Provides);"),
(4, "SimpleSubquery", "List the names of the pieces that cost less than the average.", "SELECT Pieces.Name, Price FROM Pieces INNER JOIN Provides ON Pieces.Code = Provides.Piece WHERE Price <  (SELECT AVG(Price) FROM Provides);");
