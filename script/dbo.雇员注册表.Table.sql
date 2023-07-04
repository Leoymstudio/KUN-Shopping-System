USE [ctask6]
GO
/****** Object:  Table [dbo].[雇员注册表]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[雇员注册表](
	[g用户名] [char](20) NOT NULL,
	[密码] [char](20) NOT NULL,
	[雇员id] [int] NOT NULL,
 CONSTRAINT [PK_雇员注册表] PRIMARY KEY CLUSTERED 
(
	[g用户名] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
