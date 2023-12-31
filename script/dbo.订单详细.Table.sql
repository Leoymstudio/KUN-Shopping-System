USE [ctask6]
GO
/****** Object:  Table [dbo].[订单详细]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[订单详细](
	[订单id] [int] NOT NULL,
	[产品id] [int] NOT NULL,
	[数量] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_订单详细]    Script Date: 2023/5/22 15:12:33 ******/
CREATE CLUSTERED INDEX [IX_订单详细] ON [dbo].[订单详细]
(
	[订单id] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[订单详细]  WITH CHECK ADD  CONSTRAINT [FK_订单详细_产品] FOREIGN KEY([产品id])
REFERENCES [dbo].[产品] ([产品id])
GO
ALTER TABLE [dbo].[订单详细] CHECK CONSTRAINT [FK_订单详细_产品]
GO
ALTER TABLE [dbo].[订单详细]  WITH CHECK ADD  CONSTRAINT [FK_订单详细_订单] FOREIGN KEY([订单id])
REFERENCES [dbo].[订单] ([订单id])
GO
ALTER TABLE [dbo].[订单详细] CHECK CONSTRAINT [FK_订单详细_订单]
GO
