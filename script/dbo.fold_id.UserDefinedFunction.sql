USE [ctask6]
GO
/****** Object:  UserDefinedFunction [dbo].[fold_id]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fold_id](@money float)
returns smallint

as
begin
declare @id smallint,
@max float,
@max_id smallint,
@min float,
@min_id smallint

declare mi cursor local for
select *
from 折扣条件

declare ma cursor local for
select *
from 折扣条件


open mi
fetch next from mi into @min,@min_id
fetch next from mi into @min,@min_id


open ma
fetch next from ma into @max,@max_id


if(@money>=@max) begin set @id=@max_id end
else
	begin
	while @@FETCH_STATUS=0
		begin
		if(@money>=@min and @money<@max)
			begin
			set @id=@min_id
			end
		fetch next from ma into @max,@max_id
		fetch next from mi into @min,@min_id
		end
	end


return @id
end
GO
