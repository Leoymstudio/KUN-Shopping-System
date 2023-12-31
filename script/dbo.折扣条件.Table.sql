USE [ctask6]
GO
/****** Object:  Table [dbo].[折扣条件]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[折扣条件](
	[条件] [int] NULL,
	[折扣类型] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[折扣条件]  WITH CHECK ADD  CONSTRAINT [FK_折扣条件_折扣类型] FOREIGN KEY([折扣类型])
REFERENCES [dbo].[折扣类型] ([折扣类型])
GO
ALTER TABLE [dbo].[折扣条件] CHECK CONSTRAINT [FK_折扣条件_折扣类型]
GO
