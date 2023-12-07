REM   Script: Session 02
REM   ONLINESTORE


CREATE TABLE Product ( 
    ProductID INT PRIMARY KEY, 
    Name VARCHAR(255) NOT NULL, 
    Description VARCHAR(1000), 
    Price DECIMAL(10, 2) NOT NULL, 
    StockQuantity INT NOT NULL 
);

CREATE TABLE Customer ( 
    CustomerID INT PRIMARY KEY, 
    FirstName VARCHAR(255) NOT NULL, 
    LastName VARCHAR(255) NOT NULL, 
    Email VARCHAR(255) UNIQUE NOT NULL, 
    PhoneNumber VARCHAR(20), 
    Address VARCHAR(500) 
);

INSERT INTO Customer (CustomerID, FirstName, LastName, Email, PhoneNumber, Address) 
VALUES 
    (1, 'John', 'Doe', 'john.doe@email.com', '123-456-7890', '123 Main St');

INSERT INTO Customer (CustomerID, FirstName, LastName, Email, PhoneNumber, Address) 
VALUES 
     (2, 'Jane', 'Smith', 'jane.smith@email.com', '987-654-3210', '456 Oak St');

CREATE TABLE Orders ( 
    OrderID INT PRIMARY KEY, 
    CustomerID INT, 
    OrderDate DATE, 
    TotalAmount DECIMAL(10, 2) NOT NULL, 
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) 
);

CREATE TABLE OrderItem ( 
    OrderItemID INT PRIMARY KEY, 
    OrderID INT, 
    ProductID INT, 
    Quantity INT NOT NULL, 
    Subtotal DECIMAL(10, 2) NOT NULL, 
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID), 
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) 
);

INSERT INTO Product (ProductID, Name, Description, Price, StockQuantity) 
VALUES 
    (1, 'Laptop', 'High-performance laptop', 999.99, 50) 
    -- (2, 'Smartphone', 'Latest smartphone model', 599.99, 100), 
    -- (3, 'Headphones', 'Wireless noise-canceling headphones', 149.99, 30) ;

INSERT INTO Product (ProductID, Name, Description, Price, StockQuantity) 
VALUES 
    --(1, 'Laptop', 'High-performance laptop', 999.99, 50) 
    (2, 'Smartphone', 'Latest smartphone model', 599.99, 100) 
    -- (3, 'Headphones', 'Wireless noise-canceling headphones', 149.99, 30) ;

INSERT INTO Product (ProductID, Name, Description, Price, StockQuantity) 
VALUES 
    --(1, 'Laptop', 'High-performance laptop', 999.99, 50) 
    --(2, 'Smartphone', 'Latest smartphone model', 599.99, 100) 
    (3, 'Headphones', 'Wireless noise-canceling headphones', 149.99, 30) ;

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) 
VALUES 
    (1, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 999.99);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) 
VALUES 
    (2, 2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 749.98);

INSERT INTO OrderItem (OrderItemID, OrderID, ProductID, Quantity, Subtotal) 
VALUES 
    (1, 1, 1, 2, 1999.98);

INSERT INTO OrderItem (OrderItemID, OrderID, ProductID, Quantity, Subtotal) 
VALUES 
    --(1, 1, 1, 2, 1999.98), 
    (2, 2, 2, 1, 599.99);

SELECT * FROM Product;

 SELECT * FROM Customer;

SELECT * FROM Product WHERE StockQuantity > 0;

SELECT COUNT(*) AS TotalProducts FROM Product;

SELECT DISTINCT c.* 
FROM Customer c 
JOIN Orders o ON c.CustomerID = o.CustomerID;

SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName, p.Name AS ProductName, oi.Quantity, oi.Subtotal 
FROM Orders o 
JOIN Customer c ON o.CustomerID = c.CustomerID 
JOIN OrderItem oi ON o.OrderID = oi.OrderID 
JOIN Product p ON oi.ProductID = p.ProductID;

SELECT 
    p.ProductID, 
    p.Name AS ProductName, 
    SUM(oi.Quantity) AS TotalSold, 
    SUM(oi.Subtotal) AS TotalRevenue 
FROM 
    Product p 
JOIN 
    OrderItem oi ON p.ProductID = oi.ProductID 
GROUP BY 
    p.ProductID, p.Name 
ORDER BY 
    TotalRevenue DESC;
