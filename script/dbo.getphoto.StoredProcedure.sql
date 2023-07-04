USE [ctask6]
GO
/****** Object:  StoredProcedure [dbo].[getphoto]    Script Date: 2023/5/22 15:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getphoto](@id int)
as 
begin

DECLARE @ImageData VARBINARY(MAX);
SELECT @ImageData = BulkColumn
FROM OPENROWSET(BULK N'D:\下载\海鲜.jpeg', SINGLE_BLOB) AS Image;

UPDATE 类别
SET 图片 = @ImageData
WHERE 类别id=@id; -- 指定行的条件

end
GO
