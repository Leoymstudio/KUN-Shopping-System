USE [ctask6]
GO
/****** Object:  UserDefinedFunction [dbo].[show_dd]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[show_dd]()
returns @temp table(dd_id int,old float,new float,name char(20),onece char(20),num int)
as
begin


declare cur cursor local for
select *
from dbo.客户订单详情

declare @dd_id int,@old float,@new float,@name1 char(20),@onece char(20),@num int

declare @dd int

open cur
fetch next from cur into @dd_id,@old,@new,@name1,@onece,@num 
insert into @temp values(@dd_id,@old,@new,@name1,@onece,@num)

set @dd=@dd_id


fetch next from cur into @dd_id,@old,@new,@name1,@onece,@num


while @@FETCH_STATUS=0
	begin
	
	if(@dd=@dd_id)
		begin
		insert into @temp values(NULL,NULL,NULL,@name1,@onece,@num)
		end
	else
		begin
		set @dd=@dd_id
		insert into @temp values(@dd_id,@old,@new,@name1,@onece,@num)
		end
	fetch next from cur into @dd_id,@old,@new,@name1,@onece,@num
	end

return
end
GO
