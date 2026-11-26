-- ============================================
-- WEEK 7 ASSIGNMENT: DATABASE DESIGN AND NORMALIZATION
-- ============================================


-- ============================================
-- QUESTION 1: ACHIEVING FIRST NORMAL FORM (1NF)
-- ============================================
-- Problem: ProductDetail.Products holds multiple values in one cell
-- (e.g. 'Laptop, Mouse'), which violates 1NF.
-- Fix: store exactly one product per row.

DROP TABLE IF EXISTS ProductDetail_1NF;

CREATE TABLE ProductDetail_1NF (
    OrderID      INT          NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Product      VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID, Product)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe',    'Laptop'),
(101, 'John Doe',    'Mouse'),
(102, 'Jane Smith',  'Tablet'),
(102, 'Jane Smith',  'Keyboard'),
(102, 'Jane Smith',  'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Verify
SELECT * FROM ProductDetail_1NF;


-- ============================================
-- QUESTION 2: ACHIEVING SECOND NORMAL FORM (2NF)
-- ============================================
-- Partial dependency: with composite key (OrderID, Product),
-- CustomerName depends only on OrderID (part of the key), not on
-- the whole key. This violates 2NF.
-- Fix: move CustomerName into an Orders table keyed by OrderID, and keep
-- Product and Quantity in OrderItems, which references Orders.

DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    OrderID      INT          NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID)
);

CREATE TABLE OrderItems (
    OrderID  INT          NOT NULL,
    Product  VARCHAR(100) NOT NULL,
    Quantity INT          NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)
);

INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop',   2),
(101, 'Mouse',    1),
(102, 'Tablet',   3),
(102, 'Keyboard', 1),
(102, 'Mouse',    2),
(103, 'Phone',    1);

-- Verify
SELECT * FROM Orders;
SELECT * FROM OrderItems;
