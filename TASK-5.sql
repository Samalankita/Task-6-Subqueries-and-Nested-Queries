create database customer;

use customer;

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Country VARCHAR(50)
); 

CREATE TABLE Orderss (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

insert into Customer values(1,'ankita','india'),(2,'abhi','eng'),(3,'david','UK'),(4,'isha','USA');

insert into Orderss values(101,1,'laptop'),(102,2,'ph'),(103,3,'tablet'),(104,4,'watch');

-- inner join
SELECT Customer.CustomerName, Orderss.Product
FROM Customer
INNER JOIN Orderss
ON Customer.CustomerID = Orderss.CustomerID;

-- left join
SELECT Customer.CustomerName, Orderss.Product
FROM Customer
LEFT JOIN Orderss
ON Customer.CustomerID = Orderss.CustomerID;
-- RIGHT JOIN
SELECT Customer.CustomerName, Orderss.Product
FROM Customer
RIGHT JOIN Orderss
ON Customer.CustomerID = Orderss.CustomerID;


-- full outer join
SELECT Customers.CustomerName, Orders.Product
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
UNION
SELECT Customers.CustomerName, Orders.Product
FROM Orders
LEFT JOIN Customers
ON Customers.CustomerID = Orders.CustomerID;

-- subquires in select
 SELECT 
    CustomerName,
    (SELECT COUNT(*) 
     FROM Orderss 
     WHERE Orderss.CustomerID = Customer.CustomerID) AS TotalOrderss
FROM Customer;

-- subquires in where
SELECT CustomerName
FROM Customers
WHERE CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Orders
);


-- subquires in from
SELECT t.CustomerName, t.Product
FROM (
    SELECT c.CustomerName, o.Product,
           ROW_NUMBER() OVER (PARTITION BY c.CustomerID ORDER BY o.OrderID) AS rn
    FROM Customer c
    JOIN Orderss o
    ON c.CustomerID = o.CustomerID
) AS t
WHERE t.rn = 1;

-- subquires in =
SELECT CustomerName
FROM Customer
WHERE CustomerID = (
    SELECT CustomerID
    FROM Orderss
    GROUP BY CustomerID
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- subquires in exits
SELECT CustomerName
FROM Customer c
WHERE EXISTS (
    SELECT 1
    FROM Orderss o
    WHERE o.CustomerID = c.CustomerID
);






