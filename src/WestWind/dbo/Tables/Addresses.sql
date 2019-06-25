CREATE TABLE [dbo].[Addresses] (
    [AddressID]  INT           IDENTITY (1, 1) NOT NULL,
    [Address]    NVARCHAR (60) NOT NULL,
    [City]       NVARCHAR (15) NOT NULL,
    [Region]     NVARCHAR (15) NULL,
    [PostalCode] NVARCHAR (10) NULL,
    [Country]    NVARCHAR (15) NOT NULL,
    CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED ([AddressID] ASC)
);

