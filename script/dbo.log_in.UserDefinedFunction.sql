USE [ctask6]
GO
/****** Object:  UserDefinedFunction [dbo].[log_in]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[log_in](@user char(20),@password char(20),@identity int)
returns char(6)
as
begin
declare @id char(10)
declare @num int
declare @pass char(20)

if(@identity=1)
	begin
	select @num=count(*)
	from 注册表
	where 用户名=@user
	if(@num=0) begin return 'failed'  end
	if(@num=1)
		begin
		select @pass=密码
		from 注册表
		where 用户名=@user

		select @id=客户id
		from 注册表
		where 用户名=@user

		if(@pass=@password)
			begin

			select @id=客户id
			from 注册表
			where 用户名=@user

			return @id
			end
		else begin return 'failed' end
		end
	end


if(@identity=2)
	begin
	select @num=count(*)
	from 雇员注册表
	where g用户名=@user
	if(@num=0) begin return 'failed'  end
	if(@num=1)
		begin
		select @pass=密码
		from 雇员注册表
		where g用户名=@user
		if(@pass=@password)
			begin

			select @id=雇员id
			from 雇员注册表
			where g用户名=@user

			return @id
			end
		else begin return 'failed' end
		end
	
	end


return 'failed'
end

GO
