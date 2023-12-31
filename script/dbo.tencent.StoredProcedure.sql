USE [ctask6]
GO
/****** Object:  StoredProcedure [dbo].[tencent]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[tencent](@kh_id char(5),@gy_id int,@a_r int)
as
begin


declare @dd_id int

declare @num int
select @num=count(*)
from 订单
if @num>0
	begin
	select @dd_id=max(订单id)
	from 订单
	set @dd_id=@dd_id+1
	end
else
	begin
	set @dd_id=10000
	end


if @a_r=1
	begin
	insert 订单 values(@dd_id,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)

	update 客户_雇员_订单 
	set 雇员id=@gy_id,订单id=@dd_id
	where 申请id =(select top(1)申请id from 客户_雇员_订单 where 客户id=@kh_id
	and 雇员id is null)
	end

if @a_r=0
	begin
	delete
	from 客户_雇员_订单
	where 申请id =(select top(1)申请id from 客户_雇员_订单 where 客户id=@kh_id and 订单id is null)

	end

return @dd_id
end
GO
