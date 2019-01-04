CREATE TABLE [dbo].[Categories] (
    [CategoryID]      INT             IDENTITY (1, 1) NOT NULL,
    [CategoryName]    NVARCHAR (15)   NOT NULL,
    [Description]     NTEXT           NULL,
    [Picture]         VARBINARY (MAX) NULL,
    [PictureMimeType] NVARCHAR (40)   NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryID] ASC),
    CONSTRAINT [CK_Categories_Picture_MimeType] CHECK ([Picture] IS NULL AND [PictureMimeType] IS NULL OR [Picture] IS NOT NULL AND [PictureMimeType] IS NOT NULL)
);


GO
CREATE NONCLUSTERED INDEX [CategoryName]
    ON [dbo].[Categories]([CategoryName] ASC);

