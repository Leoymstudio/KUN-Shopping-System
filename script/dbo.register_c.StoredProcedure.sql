USE [ctask6]
GO
/****** Object:  StoredProcedure [dbo].[register_c]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[register_c](@username char(20),@password char(20),@id nvarchar(10))
as
begin
insert 注册表 values(@username,@password,@id)
end
GO
