
CREATE PROCEDURE [dbo].[Customers_GetByPartialContactName]
	@PartialName nvarchar(30) = NULL
	
AS
IF @PartialName IS NULL
	BEGIN
		SELECT
			[CustomerID],
			[CompanyName],
			[ContactName],
			[ContactTitle],
			[ContactEmail],
			[AddressID],
			[Phone],
			[Fax]
		FROM Customers
		WHERE
			[ContactName] IS NULL
	END
ELSE
	BEGIN
		SELECT
			[CustomerID],
			[CompanyName],
			[ContactName],
			[ContactTitle],
			[ContactEmail],
			[AddressID],
			[Phone],
			[Fax]
		FROM Customers
		WHERE
			[ContactName] LIKE '%' + @PartialName + '%'
	END
