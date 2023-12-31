USE [ctask6]
GO
/****** Object:  Table [dbo].[订单]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[订单](
	[订单id] [int] NOT NULL,
	[订购日期] [datetime] NULL,
	[发货日期] [datetime] NULL,
	[到货日期] [datetime] NULL,
	[货款确认日期] [datetime] NULL,
	[运货费] [money] NULL,
	[货主名称] [nvarchar](80) NULL,
	[货主地址] [nvarchar](120) NULL,
	[货主城市] [nvarchar](30) NULL,
	[货主地区] [nvarchar](30) NULL,
	[货主邮政编码] [nvarchar](20) NULL,
	[货主国家] [nvarchar](30) NULL,
	[折扣id] [smallint] NULL,
 CONSTRAINT [PK_订单] PRIMARY KEY CLUSTERED 
(
	[订单id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
