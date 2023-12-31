USE [ctask6]
GO
/****** Object:  Table [dbo].[客户_雇员_订单]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[客户_雇员_订单](
	[申请id] [int] NOT NULL,
	[客户id] [nvarchar](10) NULL,
	[雇员id] [int] NULL,
	[订单id] [int] NULL,
 CONSTRAINT [PK_客户_雇员_订单] PRIMARY KEY CLUSTERED 
(
	[申请id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
