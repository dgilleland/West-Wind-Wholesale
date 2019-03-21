
CREATE PROCEDURE [dbo].[Suppliers_GetByPartialCompanyName]
	@PartialName varchar(40)
	
AS

SELECT
	[SupplierID],
	[CompanyName],
	[ContactName],
	[ContactTitle],
    [Email],
	[Address],
	[City],
	[Region],
	[PostalCode],
	[Country],
	[Phone],
	[Fax]
FROM Suppliers
WHERE
	[CompanyName] LIKE '%' + @PartialName + '%'