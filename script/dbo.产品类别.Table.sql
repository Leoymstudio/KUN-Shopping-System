USE [ctask6]
GO
/****** Object:  Table [dbo].[产品类别]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[产品类别](
	[产品id] [int] NOT NULL,
	[类别id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_产品类别]    Script Date: 2023/5/22 15:12:33 ******/
CREATE CLUSTERED INDEX [IX_产品类别] ON [dbo].[产品类别]
(
	[类别id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[产品类别]  WITH CHECK ADD  CONSTRAINT [FK_产品类别_产品] FOREIGN KEY([类别id])
REFERENCES [dbo].[产品] ([产品id])
GO
ALTER TABLE [dbo].[产品类别] CHECK CONSTRAINT [FK_产品类别_产品]
GO
ALTER TABLE [dbo].[产品类别]  WITH CHECK ADD  CONSTRAINT [FK_产品类别_类别] FOREIGN KEY([类别id])
REFERENCES [dbo].[类别] ([类别id])
GO
ALTER TABLE [dbo].[产品类别] CHECK CONSTRAINT [FK_产品类别_类别]
GO
