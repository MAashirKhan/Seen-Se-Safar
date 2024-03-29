USE [master]
GO
/****** Object:  Database [IMS]    Script Date: 1/13/2021 2:56:19 AM ******/
CREATE DATABASE [IMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'IMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\IMS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'IMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\IMS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [IMS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [IMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [IMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [IMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [IMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [IMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [IMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [IMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [IMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [IMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [IMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [IMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [IMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [IMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [IMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [IMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [IMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [IMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [IMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [IMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [IMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [IMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [IMS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [IMS] SET  MULTI_USER 
GO
ALTER DATABASE [IMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [IMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [IMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [IMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [IMS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [IMS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [IMS] SET QUERY_STORE = OFF
GO
USE [IMS]
GO
/****** Object:  Table [dbo].[Productstbl]    Script Date: 1/13/2021 2:56:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productstbl](
	[pcode] [nvarchar](50) NOT NULL,
	[pbarcode] [nvarchar](max) NULL,
	[pdesc] [varchar](max) NULL,
	[bid] [int] NULL,
	[cid] [int] NULL,
	[price] [decimal](18, 2) NULL,
	[qty] [int] NULL,
	[reorder] [int] NULL,
 CONSTRAINT [PK_Productstbl] PRIMARY KEY CLUSTERED 
(
	[pcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carttbl]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carttbl](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[transno] [varchar](50) NULL,
	[pcode] [nvarchar](50) NULL,
	[price] [decimal](18, 2) NULL,
	[qty] [int] NULL,
	[disc_percent] [decimal](18, 2) NULL,
	[disc] [decimal](18, 2) NULL,
	[total] [decimal](18, 2) NULL,
	[sdate] [date] NULL,
	[status] [varchar](50) NULL,
	[cashier] [varchar](50) NULL,
 CONSTRAINT [PK_Carttbl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwSoldItems]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwSoldItems]
AS
SELECT dbo.Carttbl.pcode, dbo.Productstbl.pdesc, dbo.Carttbl.qty, dbo.Carttbl.sdate, dbo.Carttbl.status, dbo.Carttbl.total
FROM   dbo.Carttbl INNER JOIN
             dbo.Productstbl ON dbo.Carttbl.pcode = dbo.Productstbl.pcode
GO
/****** Object:  Table [dbo].[Brandtbl]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brandtbl](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[brand] [varchar](500) NULL,
 CONSTRAINT [PK_Brandtbl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categorytbl]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorytbl](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[category] [varchar](300) NULL,
 CONSTRAINT [PK_Categorytbl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwCriticalStockItems]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[vwCriticalStockItems] as select p.pcode, p.pbarcode, p.pdesc, b.brand, c.category, p.price,
p.reorder, p.qty from Productstbl as p inner join Brandtbl as b on b.id = p.bid inner join Categorytbl as c on c.id = p.cid where qty <= p.reorder 
GO
/****** Object:  Table [dbo].[Canceltbl]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Canceltbl](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[transno] [varchar](50) NULL,
	[pcode] [nvarchar](50) NULL,
	[price] [decimal](18, 2) NULL,
	[qty] [int] NULL,
	[total] [decimal](18, 2) NULL,
	[sdate] [date] NULL,
	[voidby] [varchar](50) NULL,
	[cancelledby] [varchar](50) NULL,
	[reason] [text] NULL,
	[action] [varchar](50) NULL,
 CONSTRAINT [PK_Canceltbl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwCancelOrder]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[vwCancelOrder] as Select c.transno, c.pcode, p.pdesc, c.price, c.qty, c.total, c.sdate, c.voidby, c.cancelledby, c.reason, c.action from Canceltbl as c inner join Productstbl as p on c.pcode = p.pcode
GO
/****** Object:  Table [dbo].[Vendortbl]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendortbl](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[vendor] [varchar](50) NULL,
	[address] [text] NULL,
	[contactperson] [varchar](50) NULL,
	[telephone] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[fax] [varchar](50) NULL,
 CONSTRAINT [PK_Vendortbl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockIntbl]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockIntbl](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[refno] [varchar](50) NULL,
	[pcode] [nvarchar](50) NOT NULL,
	[qty] [int] NULL,
	[sdate] [datetime] NULL,
	[stockinby] [varchar](50) NULL,
	[status] [varchar](50) NULL,
	[vendorid] [int] NULL,
 CONSTRAINT [PK_Stocktbl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwStockIn]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwStockIn]
AS
SELECT dbo.StockIntbl.id, dbo.StockIntbl.refno, dbo.StockIntbl.pcode, dbo.Productstbl.pdesc, dbo.StockIntbl.qty, dbo.StockIntbl.sdate, dbo.StockIntbl.stockinby, dbo.StockIntbl.status, dbo.Vendortbl.vendor
FROM   dbo.Productstbl INNER JOIN
             dbo.StockIntbl ON dbo.Productstbl.pcode = dbo.StockIntbl.pcode INNER JOIN
             dbo.Vendortbl ON dbo.StockIntbl.vendorid = dbo.Vendortbl.id
GO
/****** Object:  Table [dbo].[Adjustmenttbl]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Adjustmenttbl](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[referenceno] [varchar](50) NULL,
	[pcode] [varchar](50) NULL,
	[qty] [int] NULL,
	[action] [varchar](50) NULL,
	[remarks] [text] NULL,
	[sdate] [date] NULL,
	[user] [varchar](50) NULL,
 CONSTRAINT [PK_Adjustmenttbl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Storetbl]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Storetbl](
	[storename] [varchar](500) NOT NULL,
	[storeaddress] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[storename] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Userstbl]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Userstbl](
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NULL,
	[role] [varchar](50) NULL,
	[name] [varchar](50) NULL,
	[isactive] [varchar](50) NULL,
 CONSTRAINT [PK_Userstbl] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vattbl]    Script Date: 1/13/2021 2:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vattbl](
	[vat] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Carttbl] ADD  CONSTRAINT [DF_Carttbl_disc_percent]  DEFAULT ((0)) FOR [disc_percent]
GO
ALTER TABLE [dbo].[Carttbl] ADD  CONSTRAINT [DF_Carttbl_disc]  DEFAULT ((0)) FOR [disc]
GO
ALTER TABLE [dbo].[Carttbl] ADD  CONSTRAINT [DF_Carttbl_status]  DEFAULT ('Pending') FOR [status]
GO
ALTER TABLE [dbo].[Productstbl] ADD  CONSTRAINT [DF_Productstbl_qty]  DEFAULT ((0)) FOR [qty]
GO
ALTER TABLE [dbo].[StockIntbl] ADD  CONSTRAINT [DF_Stocktbl_qty]  DEFAULT ((0)) FOR [qty]
GO
ALTER TABLE [dbo].[StockIntbl] ADD  CONSTRAINT [DF_StockIntbl_status]  DEFAULT ('Pending') FOR [status]
GO
ALTER TABLE [dbo].[Userstbl] ADD  CONSTRAINT [DF_Userstbl_isactive]  DEFAULT ('True') FOR [isactive]
GO
ALTER TABLE [dbo].[Carttbl]  WITH CHECK ADD  CONSTRAINT [FK_Carttbl_Productstbl] FOREIGN KEY([pcode])
REFERENCES [dbo].[Productstbl] ([pcode])
GO
ALTER TABLE [dbo].[Carttbl] CHECK CONSTRAINT [FK_Carttbl_Productstbl]
GO
ALTER TABLE [dbo].[StockIntbl]  WITH CHECK ADD  CONSTRAINT [FK_StockIntbl_Productstbl] FOREIGN KEY([pcode])
REFERENCES [dbo].[Productstbl] ([pcode])
GO
ALTER TABLE [dbo].[StockIntbl] CHECK CONSTRAINT [FK_StockIntbl_Productstbl]
GO
ALTER TABLE [dbo].[StockIntbl]  WITH CHECK ADD  CONSTRAINT [FK_StockIntbl_Vendortbl] FOREIGN KEY([vendorid])
REFERENCES [dbo].[Vendortbl] ([id])
GO
ALTER TABLE [dbo].[StockIntbl] CHECK CONSTRAINT [FK_StockIntbl_Vendortbl]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Carttbl"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "Productstbl"
            Begin Extent = 
               Top = 18
               Left = 491
               Bottom = 215
               Right = 713
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSoldItems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSoldItems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Productstbl"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "StockIntbl"
            Begin Extent = 
               Top = 9
               Left = 336
               Bottom = 206
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Vendortbl"
            Begin Extent = 
               Top = 9
               Left = 615
               Bottom = 206
               Right = 837
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
         Width = 1000
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwStockIn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwStockIn'
GO
USE [master]
GO
ALTER DATABASE [IMS] SET  READ_WRITE 
GO
