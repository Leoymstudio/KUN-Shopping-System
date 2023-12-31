USE [ctask6]
GO
/****** Object:  Table [dbo].[雇员]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[雇员](
	[雇员id] [int] NOT NULL,
	[姓氏] [nvarchar](40) NULL,
	[名字] [nvarchar](20) NULL,
	[职务] [nvarchar](60) NULL,
	[尊称] [nvarchar](50) NULL,
	[出生日期] [datetime] NULL,
	[雇佣日期] [datetime] NULL,
	[地址] [nvarchar](120) NULL,
	[城市] [nvarchar](30) NULL,
	[地区] [nvarchar](30) NULL,
	[邮政编码] [nvarchar](20) NULL,
	[国家] [nvarchar](30) NULL,
	[家庭电话] [nvarchar](48) NULL,
	[分机] [nvarchar](8) NULL,
	[照片] [nvarchar](510) NULL,
	[备注] [ntext] NULL,
 CONSTRAINT [PK_雇员] PRIMARY KEY CLUSTERED 
(
	[雇员id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
