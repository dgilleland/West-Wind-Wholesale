create view InvoiceItems AS
SELECT Orders.ShipName,
       Orders.ShipAddress,
       Orders.ShipCity,
       Orders.ShipRegion,
       Orders.ShipPostalCode,
       Orders.ShipCountry,
       Orders.CustomerID,
       Customers.CompanyName,
       Customers.[Address],
       Customers.City,
       Customers.Region,
       Customers.PostalCode,
       Customers.Country, 
	   (FirstName + ' ' + LastName) AS 'SalesRep',
       Orders.OrderID,
       Orders.OrderDate,
       Orders.RequiredDate,
       [OrderDetails].ProductID,
       Products.ProductName,
       [OrderDetails].UnitPrice,
       [OrderDetails].Quantity,
       [OrderDetails].Discount,
       (CONVERT(MONEY,([OrderDetails].UnitPrice*Quantity*(1-Discount)/100))*100) AS 'ExtendedPrice',
       Orders.Freight
FROM 	Products
INNER JOIN [OrderDetails] ON Products.ProductID = [OrderDetails].ProductID
INNER JOIN Orders ON Orders.OrderID = [OrderDetails].OrderID 
INNER JOIN Employees ON Employees.EmployeeID = Orders.SalesRepID 
INNER JOIN Customers ON Customers.CustomerID = Orders.CustomerID 
