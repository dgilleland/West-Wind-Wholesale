CREATE TABLE [dbo].[Suppliers] (
    [SupplierID]    INT            IDENTITY (1, 1) NOT NULL,
    [CompanyName]   NVARCHAR (40)  NOT NULL,
    [ContactName]   NVARCHAR (30)  NOT NULL,
    [ContactTitle]  NVARCHAR (30)  NULL,
    [Email]         NVARCHAR (50)  NOT NULL,
    [Address]       NVARCHAR (60)  NOT NULL,
    [City]          NVARCHAR (15)  NOT NULL,
    [Region]        NVARCHAR (15)  NULL,
    [PostalCode]    NVARCHAR (10)  NULL,
    [Country]       NVARCHAR (15)  NOT NULL,
    [Phone]         NVARCHAR (24)  NOT NULL,
    [Fax]           NVARCHAR (24)  NULL,
    CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED ([SupplierID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [CompanyName]
    ON [dbo].[Suppliers]([CompanyName] ASC);


GO
CREATE NONCLUSTERED INDEX [PostalCode]
    ON [dbo].[Suppliers]([PostalCode] ASC);

