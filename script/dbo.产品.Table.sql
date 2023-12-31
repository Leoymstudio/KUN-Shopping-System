USE [ctask6]
GO
/****** Object:  Table [dbo].[产品]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[产品](
	[产品id] [int] NOT NULL,
	[产品名称] [nvarchar](80) NULL,
	[单位数量] [nvarchar](40) NULL,
	[单价] [money] NULL,
	[库存量] [smallint] NULL,
	[订购量] [smallint] NULL,
	[再订购量] [smallint] NULL,
	[中止] [bit] NULL,
 CONSTRAINT [PK_产品] PRIMARY KEY CLUSTERED 
(
	[产品id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
