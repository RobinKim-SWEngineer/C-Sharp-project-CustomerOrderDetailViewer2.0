USE [master]
GO
/****** Object:  Database [CustomerOrderViewer2.0]    Script Date: 11/01/2021 18:44:36 ******/
CREATE DATABASE [CustomerOrderViewer2.0]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CustomerOrderViewer', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CustomerOrderViewer.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CustomerOrderViewer_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CustomerOrderViewer_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CustomerOrderViewer2.0].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET ARITHABORT OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET  MULTI_USER 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET QUERY_STORE = OFF
GO
USE [CustomerOrderViewer2.0]
GO
/****** Object:  UserDefinedTableType [dbo].[CustomerOrderType]    Script Date: 11/01/2021 18:44:36 ******/
CREATE TYPE [dbo].[CustomerOrderType] AS TABLE(
	[CustomerOrderId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ItemId] [int] NOT NULL
)
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 11/01/2021 18:44:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[MiddleName] [varchar](50) NULL,
	[LastName] [varchar](50) NOT NULL,
	[Age] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 11/01/2021 18:44:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[Price] [decimal](4, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerOrder]    Script Date: 11/01/2021 18:44:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrder](
	[CustomerOrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreateId] [varchar](50) NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[UpdateId] [varchar](50) NOT NULL,
	[ActivInd] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CustomerOrderDetail]    Script Date: 11/01/2021 18:44:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CustomerOrderDetail] AS
	SELECT
		t1.CustomerOrderId,
		t2.CustomerId,
		t3.ItemId,
		t2.FirstName,
		t2.LastName,
		t3.[Description],
		t3.Price,
		t1.ActivInd
	FROM
		dbo.CustomerOrder t1
	INNER JOIN
		dbo.Customer t2 ON t2.CustomerId = t1.CustomerId
	INNER JOIN
		dbo.Item t3 ON t3.ItemId = t1.ItemId;
GO
ALTER TABLE [dbo].[CustomerOrder] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[CustomerOrder] ADD  DEFAULT ('System') FOR [CreateId]
GO
ALTER TABLE [dbo].[CustomerOrder] ADD  DEFAULT (getdate()) FOR [UpdateDate]
GO
ALTER TABLE [dbo].[CustomerOrder] ADD  DEFAULT ('System') FOR [UpdateId]
GO
ALTER TABLE [dbo].[CustomerOrder] ADD  DEFAULT (CONVERT([bit],(1))) FOR [ActivInd]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([ItemId])
GO
/****** Object:  StoredProcedure [dbo].[Customer_GetList]    Script Date: 11/01/2021 18:44:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Customer_GetList]
AS
	BEGIN
		SELECT
			CustomerId,
			FirstName,
			MiddleName,
			LastName,
			Age
		FROM
			Customer
	END
GO
/****** Object:  StoredProcedure [dbo].[CustomerOrder_Delete]    Script Date: 11/01/2021 18:44:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CustomerOrder_Delete] ( @CustomerOrderId	  INT,
										  @UserId			  VARCHAR(50) )	
AS
	BEGIN
		UPDATE
			CustomerOrder
		SET
			ActivInd = CONVERT(BIT, 0),
			UpdateDate = GETDATE(),
			UpdateId = @UserId
		WHERE
			CustomerOrderId = @CustomerOrderId AND
			ActivInd = CONVERT(BIT, 1)
	END
GO
/****** Object:  StoredProcedure [dbo].[CustomerOrder_Upsert]    Script Date: 11/01/2021 18:44:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[CustomerOrder_Upsert] ( @CustomerOrderType CustomerOrderType READONLY,
		                           @UserId           VARCHAR(50))
AS
   BEGIN
      MERGE INTO CustomerOrder AS TARGET
      USING
      (
         SELECT
            CustomerOrderId,
            CustomerId,
            ItemId,
            @UserId [CreateId],
            GETDATE() [CreateDate],
            @UserId [UpdateId],
            GETDATE() [UpdateDate]
         FROM
            @CustomerOrderType
      ) AS SOURCE
      ON
      (
         TARGET.CustomerOrderId = SOURCE.CustomerOrderId
      )
      WHEN MATCHED
         THEN UPDATE
            SET
               TARGET.CustomerId      = SOURCE.CustomerId,
               TARGET.ItemId         = SOURCE.ItemId,
               TARGET.UpdateDate      = SOURCE.UpdateDate,
               TARGET.UpdateId         = SOURCE.UpdateId

      WHEN NOT MATCHED BY TARGET THEN 
         INSERT (CustomerId, ItemId, CreateDate, CreateId, UpdateDate, UpdateId)
         VALUES (SOURCE.CustomerId, SOURCE.ItemId, SOURCE.CreateDate, SOURCE.CreateId, SOURCE.UpdateDate, SOURCE.UpdateId);
   END
GO
/****** Object:  StoredProcedure [dbo].[CustomerOrderDetail_GetList]    Script Date: 11/01/2021 18:44:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CustomerOrderDetail_GetList]
AS
	BEGIN
		SELECT
			CustomerOrderId
			CustomerId,
			ItemId,
			FirstName,
			LastName,
			[Description],
			Price,
			ActivInd
		FROM
			CustomerOrderDetail
		WHERE
			ActivInd = CONVERT(BIT, 1)
	END
GO
/****** Object:  StoredProcedure [dbo].[Item_GetList]    Script Date: 11/01/2021 18:44:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Item_GetList]
AS
	BEGIN
		SELECT
			ItemId,
			[Description],
			Price
		FROM
			Item
	END
GO
USE [master]
GO
ALTER DATABASE [CustomerOrderViewer2.0] SET  READ_WRITE 
GO
