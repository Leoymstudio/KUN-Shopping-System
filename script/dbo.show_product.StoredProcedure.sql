USE [ctask6]
GO
/****** Object:  StoredProcedure [dbo].[show_product]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[show_product]
@id_in int,
@name char(80) output,
@onece char(40) output,
@price money output,
@amount smallint output

as
begin

select @name=产品名称,
@onece=单位数量,
@price=单价,
@amount=库存量
from 产品
where 产品id=@id_in

end


GO
