USE [ctask6]
GO
/****** Object:  Table [dbo].[供应商注册表]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[供应商注册表](
	[用户名] [char](20) NOT NULL,
	[密码] [char](20) NOT NULL,
	[供应商id] [int] NOT NULL
) ON [PRIMARY]
GO
