USE [ctask6]
GO
/****** Object:  UserDefinedFunction [dbo].[getpassword]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[getpassword](@username char(20),@password char(20))
returns int
as
begin
declare @t char(20)
select @t=密码
from 注册表
where 用户名=@username


if(@t=@password) 
begin return 1 end

return 0
end
GO
