CREATE TABLE [dbo].[Customers] (
    [CustomerID]   NCHAR (5)     NOT NULL,
    [CompanyName]  NVARCHAR (40) NOT NULL,
    [ContactName]  NVARCHAR (30) NOT NULL,
    [ContactTitle] NVARCHAR (30) NULL,
    [ContactEmail] NVARCHAR (50) NOT NULL,
    [AddressID]    INT           NOT NULL,
    [Phone]        NVARCHAR (24) NOT NULL,
    [Fax]          NVARCHAR (24) NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerID] ASC),
    CONSTRAINT [FK_Customers_Addresses] FOREIGN KEY ([AddressID]) REFERENCES [dbo].[Addresses] ([AddressID]),
    CONSTRAINT [UX_Customers_AddressID] UNIQUE ([AddressID])
);




GO



GO
CREATE NONCLUSTERED INDEX [CompanyName]
    ON [dbo].[Customers]([CompanyName] ASC);


GO



GO


