USE [ctask6]
GO
/****** Object:  StoredProcedure [dbo].[apply]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[apply](@c_id char(5))
as
begin

declare @id int
set @id=1

declare @num int
select @num=count(*)
from 客户_雇员_订单

if @num>0
	begin
	select @id=max(申请id)+@id
	from 客户_雇员_订单
	end


insert 客户_雇员_订单 values(@id,@c_id,NULL,NULL)
end
GO
