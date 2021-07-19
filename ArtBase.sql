USE [ArtBase]
GO
/****** Object:  Table [dbo].[Artist]    Script Date: 7/18/2021 7:42:38 PM ******/
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
/****** Object:  Table [dbo].[Artwork]    Script Date: 7/18/2021 7:42:38 PM ******/
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
/****** Object:  Table [dbo].[Category]    Script Date: 7/18/2021 7:42:38 PM ******/
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
/****** Object:  Table [dbo].[Guest]    Script Date: 7/18/2021 7:42:38 PM ******/
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
/****** Object:  Table [dbo].[Material]    Script Date: 7/18/2021 7:42:38 PM ******/
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
/****** Object:  Table [dbo].[Movement]    Script Date: 7/18/2021 7:42:38 PM ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 7/18/2021 7:42:38 PM ******/
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
/****** Object:  Table [dbo].[Period]    Script Date: 7/18/2021 7:42:38 PM ******/
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
/****** Object:  Table [dbo].[PurchaseRecord]    Script Date: 7/18/2021 7:42:38 PM ******/
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
/****** Object:  Table [dbo].[Subject]    Script Date: 7/18/2021 7:42:38 PM ******/
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
