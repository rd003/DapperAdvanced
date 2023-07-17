USE [master]
GO
/****** Object:  Database [DapperAdvanced]    Script Date: 17-07-2023 15:55:26 ******/
CREATE DATABASE [DapperAdvanced]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DapperAdvanced', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DapperAdvanced.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DapperAdvanced_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DapperAdvanced_log.ldf' , SIZE = 816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DapperAdvanced] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DapperAdvanced].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DapperAdvanced] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DapperAdvanced] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DapperAdvanced] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DapperAdvanced] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DapperAdvanced] SET ARITHABORT OFF 
GO
ALTER DATABASE [DapperAdvanced] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DapperAdvanced] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DapperAdvanced] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DapperAdvanced] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DapperAdvanced] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DapperAdvanced] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DapperAdvanced] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DapperAdvanced] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DapperAdvanced] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DapperAdvanced] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DapperAdvanced] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DapperAdvanced] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DapperAdvanced] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DapperAdvanced] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DapperAdvanced] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DapperAdvanced] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DapperAdvanced] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DapperAdvanced] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DapperAdvanced] SET  MULTI_USER 
GO
ALTER DATABASE [DapperAdvanced] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DapperAdvanced] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DapperAdvanced] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DapperAdvanced] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DapperAdvanced] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DapperAdvanced]
GO
/****** Object:  UserDefinedTableType [dbo].[typBook]    Script Date: 17-07-2023 15:55:26 ******/
CREATE TYPE [dbo].[typBook] AS TABLE(
	[Title] [nvarchar](100) NULL,
	[Author] [nvarchar](100) NULL,
	[Year] [int] NULL
)
GO
/****** Object:  Table [dbo].[Book]    Script Date: 17-07-2023 15:55:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[Id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[Title] [nvarchar](100) NOT NULL,
	[Author] [nvarchar](100) NOT NULL,
	[Year] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Book_Genre]    Script Date: 17-07-2023 15:55:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book_Genre](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BookId] [uniqueidentifier] NULL,
	[GenreId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Genre]    Script Date: 17-07-2023 15:55:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[order]    Script Date: 17-07-2023 15:55:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NULL DEFAULT (getdate()),
	[CustomerName] [nvarchar](30) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 17-07-2023 15:55:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Price] [decimal](10, 3) NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Book_Genre]  WITH CHECK ADD FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([Id])
GO
ALTER TABLE [dbo].[Book_Genre]  WITH CHECK ADD FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genre] ([Id])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[order] ([Id])
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD CHECK  ((len([title])>=(4)))
GO
/****** Object:  StoredProcedure [dbo].[sp_AddBooks]    Script Date: 17-07-2023 15:55:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_AddBooks] @typBook dbo.typBook readonly
as
begin
   insert into Book(Title,Author,[year])
   select * from @typBook
end
GO
/****** Object: StoredProcedure [dbo].[uspGetBookDetail]    Script Date: 17-07-2023 15:55:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspGetBookDetail]
@Id uniqueidentifier,
@Title nvarchar(100) output,
@Author nvarchar(100) output
as
begin
 select @Title=title,@Author=Author from Book where id=@Id
end
GO
USE [master]
GO
ALTER DATABASE [DapperAdvanced] SET  READ_WRITE 
GO
