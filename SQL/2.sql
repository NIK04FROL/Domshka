CREATE DATABASE TestShop

 CREATE TABLE Customers
  (CustomerID int IDENTITY(1,1) PRIMARY KEY,
   FirstName nvarchar(30) NOT NULL,
   LastName nvarchar(30) NULL,
   MiddleName nvarchar(30) NULL,
   Gender nchar(1) NOT NULL
     CONSTRAINT Dbo_Customers_Gender
   CHECK (Gender = N'М' or Gender = N'Ж'),
   Adress nvarchar(60) NOT NULL
   );
 GO

 CREATE TABLE Product
   (ProductID int IDENTITY(1,1) PRIMARY KEY,
    ProductName nvarchar(30) NOT NULL,
    UnitMeasure nvarchar(5) NULL,
    Price money NOT NULL
    );
  GO

 CREATE TABLE Orders
  (OrderID int IDENTITY(1,1) PRIMARY KEY,
   CustomerID int FOREIGN KEY 
   REFERENCES Customers (CustomerID) NOT  NULL,
   OrderPrice money 
   );
 GO

 CREATE TABLE OrderDetail
   (OrderDetailID int FOREIGN KEY 
    REFERENCES Orders(OrderID),
    ProductID int FOREIGN KEY 
    REFERENCES Product (ProductID),
    ProductCount int NOT NULL
    );
 GO

    CREATE TRIGGER Orders_OrderPrice_INSERT 
    ON OrderDetail
    AFTER UPDATE, INSERT
    AS
      UPDATE Orders
      SET OrderPrice = (
        SELECT SUM(OrderDetail.ProductCount * Product.Price)
        FROM OrderDetail
        INNER JOIN Product on OrderDetail.ProductID = Product.ProductID
        WHERE Orders.OrderID = OrderDetail.OrderDetailID);



INSERT INTO Customers(FirstName, LastName, MiddleName, Gender, Adress)
VALUES (N'Петр', N'', N'Романов', N'М', N'СПб, Сенатская площадь д.1'), 
	   (N'Софи́я', N'Авгу́ста Фредери́ка', N'А́нгальт-Це́рбстская', N'Ж', N'СПб, площадь Островского д.1'), 
	   (N'Александр', N'', N'Рюрикович', N'М', N'СПб, пл. Александра Невского д.1');

INSERT INTO Product(ProductName, UnitMeasure, Price)
VALUES (N'Топор', N'шт', 500), 
	   (N'Пила', N'шт', 450), 
	   (N'Доски', N'м3', 4890), 
	   (N'Брус', N'м3', 9390), 
	   (N'Парусина', N'м.п.', 182), 
	   (N'Платье бальное', N'шт', 15000), 
	   (N'Грудки куринные', N'кг', 180), 
	   (N'Салат', N'шт', 52); 

INSERT INTO Orders(CustomerID)
VALUES (1),(2),(3)

INSERT INTO OrderDetail(OrderDetailID, ProductID, ProductCount)
VALUES (1, 1, 1), (1, 2, 1), (1, 3, 200), (1, 4, 20), (1, 5, 100), 
	   (2, 6, 999), 
	   (3, 7, 5), (3, 8, 5)

