CREATE TABLE [dbo].[Customers] (
    [CustomerID]   NCHAR (5)     NOT NULL,
    [CompanyName]  NVARCHAR (40) NOT NULL,
    [ContactName]  NVARCHAR (30) NOT NULL,
    [ContactTitle] NVARCHAR (30) NULL,
    [ContactEmail] NVARCHAR(50)  NOT NULL, 
    [Address]      NVARCHAR (60) NOT NULL,
    [City]         NVARCHAR (15) NOT NULL,
    [Region]       NVARCHAR (15) NULL,
    [PostalCode]   NVARCHAR (10) NULL,
    [Country]      NVARCHAR (15) NOT NULL,
    [Phone]        NVARCHAR (24) NOT NULL,
    [Fax]          NVARCHAR (24) NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [City]
    ON [dbo].[Customers]([City] ASC);


GO
CREATE NONCLUSTERED INDEX [CompanyName]
    ON [dbo].[Customers]([CompanyName] ASC);


GO
CREATE NONCLUSTERED INDEX [PostalCode]
    ON [dbo].[Customers]([PostalCode] ASC);


GO
CREATE NONCLUSTERED INDEX [Region]
    ON [dbo].[Customers]([Region] ASC);

