USE [ctask6]
GO
/****** Object:  Table [dbo].[折扣类型]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[折扣类型](
	[折扣类型] [smallint] NOT NULL,
	[折扣率] [float] NULL,
 CONSTRAINT [PK_折扣类型] PRIMARY KEY CLUSTERED 
(
	[折扣类型] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
