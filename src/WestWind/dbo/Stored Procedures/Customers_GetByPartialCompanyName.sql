
CREATE PROCEDURE [dbo].[Customers_GetByPartialCompanyName]
	@PartialName nvarchar(40)
	
AS

SELECT
	[CustomerID],
	[CompanyName],
	[ContactName],
	[ContactTitle],
	[ContactEmail],
	[Address],
	[City],
	[Region],
	[PostalCode],
	[Country],
	[Phone],
	[Fax]
FROM Customers
WHERE
	[CompanyName] LIKE '%' + @PartialName + '%'
