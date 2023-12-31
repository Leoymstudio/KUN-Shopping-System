USE [ctask6]
GO
/****** Object:  UserDefinedFunction [dbo].[all_money]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[all_money](@data_id int)
returns float

as
begin




declare @money float,
@cp_id int,
@cp_amount int
set @money=0

declare cs cursor local for
select 产品id,数量
from 订单详细
where 订单id=@data_id

open cs
fetch next from cs into @cp_id,@cp_amount

declare @another float
set @another=0
while @@FETCH_STATUS=0
begin

select @another=单价
from 产品
where 产品id=@cp_id

set @money=@money+@another*@cp_amount

fetch next from cs into @cp_id,@cp_amount
end





close cs

return @money
end


GO
