
CREATE PROCEDURE [dbo].[Suppliers_GetByPartialCompanyName]
	@PartialName varchar(40)
	
AS

SELECT
	[SupplierID],
	[CompanyName],
	[ContactName],
	[ContactTitle],
    [Email],
	[AddressID],
	[Phone],
	[Fax]
FROM Suppliers
WHERE
	[CompanyName] LIKE '%' + @PartialName + '%'