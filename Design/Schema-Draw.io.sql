CREATE TABLE Categories
(
CategoryID PRIMARY KEY,
CategoryName,
Description,
Picture,
PictureMimeType 
);

CREATE TABLE Customers
(
CustomerID PRIMARY KEY,
CompanyName,
ContactName,
ContactTitle,
Address,
City,
Region,
PostalCode,
Country,
Phone,
Fax 
);

CREATE TABLE Employees
(
EmployeeID PRIMARY KEY,
LastName,
FirstName,
Title,
TitleOfCourtesy,
BirthDate,
HireDate,
Address,
City,
Region,
PostalCode,
Country,
HomePhone,
Extension,
Photo,
PhotoMimeType,
Notes,
ReportsTo 
);

CREATE TABLE EmployeeTerritories
(
EmployeeID PRIMARY KEY,
TerritoryID PRIMARY KEY 
);

CREATE TABLE OrderDetails
(
OrderID PRIMARY KEY,
ProductID PRIMARY KEY,
UnitPrice,
Quantity,
Discount 
);

CREATE TABLE Orders
(
OrderID PRIMARY KEY,
CustomerID,
EmployeeID,
OrderDate,
RequiredDate,
Freight,
ShipName,
ShipAddress,
ShipCity,
ShipRegion,
ShipPostalCode,
ShipCountry 
);

CREATE TABLE Payment
(
PaymentID PRIMARY KEY,
PaymentDate,
Amount,
PaymentTypeID,
OrderID 
);

CREATE TABLE PaymentType
(
PaymentTypeID PRIMARY KEY,
PaymentTypeDescription 
);

CREATE TABLE Products
(
ProductID PRIMARY KEY,
ProductName,
SupplierID,
CategoryID,
QuantityPerUnit,
UnitPrice,
UnitsOnOrder,
Discontinued 
);

CREATE TABLE Region
(
RegionID PRIMARY KEY,
RegionDescription 
);

CREATE TABLE Shippers
(
ShipperID PRIMARY KEY,
CompanyName,
Phone 
);

CREATE TABLE Shipment
(
ShipmentID PRIMARY KEY,
OrderID,
ShippedDate,
ShipVia,
FreightCharge,
TrackingCode
);

CREATE TABLE ShipmentManifest
(
ShipmentManifestID PRIMARY KEY,
ShipmentID,
ProductID,
ShipQuantity
);

CREATE TABLE Suppliers
(
SupplierID PRIMARY KEY,
CompanyName,
ContactName,
ContactTitle,
Address,
City,
Region,
PostalCode,
Country,
Phone,
Fax,
HomePageTitle,
HomePageUrl,
LastModified 
);

CREATE TABLE Territories
(
TerritoryID PRIMARY KEY,
TerritoryDescription,
RegionID 
);

