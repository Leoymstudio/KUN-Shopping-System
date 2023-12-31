USE [ctask6]
GO
/****** Object:  Table [dbo].[订单金额]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[订单金额](
	[订单id] [int] NOT NULL,
	[原金额] [float] NULL,
	[折扣类型] [smallint] NULL,
	[折后金额] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_订单金额]    Script Date: 2023/5/22 15:12:33 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_订单金额] ON [dbo].[订单金额]
(
	[订单id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[订单金额]  WITH CHECK ADD  CONSTRAINT [FK_订单金额_订单] FOREIGN KEY([订单id])
REFERENCES [dbo].[订单] ([订单id])
GO
ALTER TABLE [dbo].[订单金额] CHECK CONSTRAINT [FK_订单金额_订单]
GO
ALTER TABLE [dbo].[订单金额]  WITH CHECK ADD  CONSTRAINT [FK_订单金额_折扣类型] FOREIGN KEY([折扣类型])
REFERENCES [dbo].[折扣类型] ([折扣类型])
GO
ALTER TABLE [dbo].[订单金额] CHECK CONSTRAINT [FK_订单金额_折扣类型]
GO
