
CREATE PROCEDURE [dbo].[Suppliers_GetByPartialContactName]
	@PartialName varchar(30) = NULL
	
AS

IF @PartialName IS NULL
	BEGIN
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
			[ContactName] IS NULL
	END
ELSE
	BEGIN
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
			[ContactName] LIKE '%' + @PartialName + '%'
	END