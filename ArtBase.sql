USE [ArtBase]
GO
/****** Object:  Table [dbo].[Period]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Period](
	[PeriodID] [int] IDENTITY(1,1) NOT NULL,
	[PeriodName] [varchar](50) NOT NULL,
	[Description] [varchar](255) NULL,
 CONSTRAINT [PK_Period] PRIMARY KEY CLUSTERED 
(
	[PeriodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ArtCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[ArtCategoryName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ArtCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Material]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Material](
	[MaterialID] [int] IDENTITY(1,1) NOT NULL,
	[ArtCategoryID] [varchar](50) NOT NULL,
	[MaterialName] [varbinary](50) NOT NULL,
 CONSTRAINT [PK_Material] PRIMARY KEY CLUSTERED 
(
	[MaterialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movement]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movement](
	[MovementID] [int] IDENTITY(1,1) NOT NULL,
	[MovementName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Movement] PRIMARY KEY CLUSTERED 
(
	[MovementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Artist]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artist](
	[ArtistID] [int] IDENTITY(1,1) NOT NULL,
	[ArtistFirstName] [varchar](50) NOT NULL,
	[ArtistLastName] [varchar](50) NOT NULL,
	[ArtistBirthYear] [int] NOT NULL,
	[ArtistDeathYear] [int] NOT NULL,
	[PeriodID] [int] NOT NULL,
	[MovementID] [int] NOT NULL,
	[Country] [varchar](50) NULL,
	[Comments] [varchar](max) NULL,
 CONSTRAINT [PK_Artist] PRIMARY KEY CLUSTERED 
(
	[ArtistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subject](
	[SubjectID] [int] IDENTITY(1,1) NOT NULL,
	[SubjectCategoryName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED 
(
	[SubjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Artwork]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artwork](
	[ArtworkID] [int] IDENTITY(1,1) NOT NULL,
	[ArtworkName] [varchar](255) NOT NULL,
	[ArtworkYear] [int] NOT NULL,
	[PeriodID] [int] NOT NULL,
	[MovementID] [int] NOT NULL,
	[ArtistID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[MaterialID] [int] NOT NULL,
	[SubjectID] [int] NOT NULL,
	[CurrentValue] [float] NOT NULL,
	[ValuationDate] [date] NOT NULL,
 CONSTRAINT [PK_Artwork] PRIMARY KEY CLUSTERED 
(
	[ArtworkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Artwork_Information]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Artwork_Information]
AS
SELECT dbo.Artwork.ArtworkName, dbo.Artist.ArtistLastName, dbo.Artist.ArtistFirstName, dbo.Period.PeriodName, dbo.Movement.MovementName, dbo.Category.ArtCategoryName, dbo.Subject.SubjectCategoryName, 
                  dbo.Material.MaterialName
FROM     dbo.Artist INNER JOIN
                  dbo.Artwork ON dbo.Artist.ArtistID = dbo.Artwork.ArtistID INNER JOIN
                  dbo.Category ON dbo.Artwork.CategoryID = dbo.Category.ArtCategoryID INNER JOIN
                  dbo.Material ON dbo.Artwork.MaterialID = dbo.Material.MaterialID AND dbo.Category.ArtCategoryID = dbo.Material.MaterialID INNER JOIN
                  dbo.Movement ON dbo.Artist.MovementID = dbo.Movement.MovementID AND dbo.Artwork.MovementID = dbo.Movement.MovementID INNER JOIN
                  dbo.Period ON dbo.Artwork.PeriodID = dbo.Period.PeriodID INNER JOIN
                  dbo.Subject ON dbo.Artwork.SubjectID = dbo.Subject.SubjectID
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] NOT NULL,
	[OrderDate] [date] NOT NULL,
	[OrderAmount] [float] NOT NULL,
	[ArtworkID] [int] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseRecord]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseRecord](
	[PurchaseRecordID] [int] IDENTITY(1,1) NOT NULL,
	[GuestID] [int] NULL,
	[OrderID] [int] NULL,
 CONSTRAINT [PK_PurchaseRecord] PRIMARY KEY CLUSTERED 
(
	[PurchaseRecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Guest]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Guest](
	[GuestID] [int] IDENTITY(1,1) NOT NULL,
	[GuestFirstName] [varchar](50) NOT NULL,
	[GuestLastName] [varchar](50) NOT NULL,
	[StreetAddress] [varchar](75) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [char](2) NOT NULL,
	[Zipcode] [int] NOT NULL,
	[PurchaseRecordID] [int] NOT NULL,
	[FavoriteArtworks] [varchar](max) NULL,
	[FavoriteArtists] [varchar](max) NULL,
 CONSTRAINT [PK_Guest] PRIMARY KEY CLUSTERED 
(
	[GuestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Guest_Information]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Guest_Information]
AS
SELECT dbo.Guest.GuestID, dbo.Guest.GuestLastName, dbo.Guest.GuestFirstName, dbo.Guest.StreetAddress, dbo.Guest.City, dbo.Guest.State, dbo.Guest.Zipcode, dbo.Guest.FavoriteArtworks, dbo.Guest.FavoriteArtists, 
                  dbo.Guest.PurchaseRecordID
FROM     dbo.Guest INNER JOIN
                  dbo.PurchaseRecord ON dbo.Guest.PurchaseRecordID = dbo.PurchaseRecord.PurchaseRecordID AND dbo.Guest.GuestID = dbo.PurchaseRecord.GuestID INNER JOIN
                  dbo.Orders ON dbo.PurchaseRecord.OrderID = dbo.Orders.OrderID
GO
/****** Object:  View [dbo].[Artist_Information]    Script Date: 7/18/2021 10:08:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Artist_Information]
AS
SELECT dbo.Artist.ArtistID, dbo.Artist.ArtistLastName, dbo.Artist.ArtistFirstName, dbo.Artist.ArtistBirthYear, dbo.Artist.ArtistDeathYear, dbo.Period.PeriodName, dbo.Movement.MovementName, dbo.Artist.Country
FROM     dbo.Artist INNER JOIN
                  dbo.Movement ON dbo.Artist.MovementID = dbo.Movement.MovementID INNER JOIN
                  dbo.Period ON dbo.Artist.PeriodID = dbo.Period.PeriodID
GO
ALTER TABLE [dbo].[Artist]  WITH CHECK ADD  CONSTRAINT [FK_MovementID] FOREIGN KEY([MovementID])
REFERENCES [dbo].[Movement] ([MovementID])
GO
ALTER TABLE [dbo].[Artist] CHECK CONSTRAINT [FK_MovementID]
GO
ALTER TABLE [dbo].[Artwork]  WITH CHECK ADD  CONSTRAINT [FK_Artwork_Artist] FOREIGN KEY([ArtistID])
REFERENCES [dbo].[Artist] ([ArtistID])
GO
ALTER TABLE [dbo].[Artwork] CHECK CONSTRAINT [FK_Artwork_Artist]
GO
ALTER TABLE [dbo].[Artwork]  WITH CHECK ADD  CONSTRAINT [FK_Artwork_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ArtCategoryID])
GO
ALTER TABLE [dbo].[Artwork] CHECK CONSTRAINT [FK_Artwork_Category]
GO
ALTER TABLE [dbo].[Artwork]  WITH CHECK ADD  CONSTRAINT [FK_Artwork_Material] FOREIGN KEY([MaterialID])
REFERENCES [dbo].[Material] ([MaterialID])
GO
ALTER TABLE [dbo].[Artwork] CHECK CONSTRAINT [FK_Artwork_Material]
GO
ALTER TABLE [dbo].[Artwork]  WITH CHECK ADD  CONSTRAINT [FK_Artwork_Movement] FOREIGN KEY([MovementID])
REFERENCES [dbo].[Movement] ([MovementID])
GO
ALTER TABLE [dbo].[Artwork] CHECK CONSTRAINT [FK_Artwork_Movement]
GO
ALTER TABLE [dbo].[Artwork]  WITH CHECK ADD  CONSTRAINT [FK_Artwork_Period] FOREIGN KEY([PeriodID])
REFERENCES [dbo].[Period] ([PeriodID])
GO
ALTER TABLE [dbo].[Artwork] CHECK CONSTRAINT [FK_Artwork_Period]
GO
ALTER TABLE [dbo].[Artwork]  WITH CHECK ADD  CONSTRAINT [FK_Artwork_Subject] FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subject] ([SubjectID])
GO
ALTER TABLE [dbo].[Artwork] CHECK CONSTRAINT [FK_Artwork_Subject]
GO
ALTER TABLE [dbo].[Guest]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseRecordID] FOREIGN KEY([PurchaseRecordID])
REFERENCES [dbo].[PurchaseRecord] ([PurchaseRecordID])
GO
ALTER TABLE [dbo].[Guest] CHECK CONSTRAINT [FK_PurchaseRecordID]
GO
ALTER TABLE [dbo].[Material]  WITH CHECK ADD  CONSTRAINT [FK_ArtCategoryID] FOREIGN KEY([MaterialID])
REFERENCES [dbo].[Category] ([ArtCategoryID])
GO
ALTER TABLE [dbo].[Material] CHECK CONSTRAINT [FK_ArtCategoryID]
GO
ALTER TABLE [dbo].[PurchaseRecord]  WITH CHECK ADD  CONSTRAINT [FK_GuestID] FOREIGN KEY([GuestID])
REFERENCES [dbo].[Guest] ([GuestID])
GO
ALTER TABLE [dbo].[PurchaseRecord] CHECK CONSTRAINT [FK_GuestID]
GO
ALTER TABLE [dbo].[PurchaseRecord]  WITH CHECK ADD  CONSTRAINT [FK_OrderID] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[PurchaseRecord] CHECK CONSTRAINT [FK_OrderID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'For example: painting, sculpture, engraving, Etc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Artwork', @level2type=N'CONSTRAINT',@level2name=N'FK_Artwork_Category'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Artistic Movement' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Period'
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
         Begin Table = "Artist"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 298
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Movement"
            Begin Extent = 
               Top = 7
               Left = 295
               Bottom = 220
               Right = 501
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Period"
            Begin Extent = 
               Top = 7
               Left = 549
               Bottom = 148
               Right = 743
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Artist_Information'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Artist_Information'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[60] 4[1] 2[20] 3) )"
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
         Begin Table = "Artist"
            Begin Extent = 
               Top = 94
               Left = 18
               Bottom = 357
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Artwork"
            Begin Extent = 
               Top = 101
               Left = 512
               Bottom = 429
               Right = 706
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Category"
            Begin Extent = 
               Top = 7
               Left = 245
               Bottom = 126
               Right = 460
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Material"
            Begin Extent = 
               Top = 7
               Left = 747
               Bottom = 148
               Right = 941
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Movement"
            Begin Extent = 
               Top = 299
               Left = 276
               Bottom = 418
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Period"
            Begin Extent = 
               Top = 84
               Left = 975
               Bottom = 225
               Right = 1169
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Subject"
            Begin Extent = 
               Top = 265
               Left = 843
               Bottom = 384
               Right = 1087
            End
            DisplayFlags = 28' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Artwork_Information'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'0
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Artwork_Information'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Artwork_Information'
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
         Begin Table = "Guest"
            Begin Extent = 
               Top = 32
               Left = 113
               Bottom = 285
               Right = 328
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Orders"
            Begin Extent = 
               Top = 47
               Left = 885
               Bottom = 210
               Right = 1079
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PurchaseRecord"
            Begin Extent = 
               Top = 7
               Left = 553
               Bottom = 148
               Right = 768
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Guest_Information'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Guest_Information'
GO
