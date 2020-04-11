SQL - Decrypt 2
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO


CREATE PROCEDURE DECRYPTSP2K (@objName varchar(50))

 AS
DECLARE @a nvarchar(4000), @b nvarchar(4000), @c nvarchar(4000), @d nvarchar(4000), @i int, @t bigint

SET @a=(SELECT ctext FROM syscomments WHERE id = object_id(@objName))
SET @b='ALTER PROCEDURE '+ @objName +' WITH ENCRYPTION AS '+REPLICATE('-', 4000-62)
EXECUTE (@b)

SET @c=(SELECT ctext FROM syscomments WHERE id = object_id(@objName))
SET @b='CREATE PROCEDURE '+ @objName +' WITH ENCRYPTION AS '+REPLICATE('-', 4000-62)

SET @i=1

SET @d = replicate(N'A', (datalength(@a) / 2))
--loop
WHILE @i<=datalength(@a)/2
    BEGIN

SET @d = stuff(@d, @i, 1,
 NCHAR(UNICODE(substring(@a, @i, 1)) ^
 (UNICODE(substring(@b, @i, 1)) ^
 UNICODE(substring(@c, @i, 1)))))
    SET @i=@i+1
    END

EXECUTE ('drop PROCEDURE '+ @objName)

SET @d=REPLACE((@d),'WITH ENCRYPTION', '')
SET @d=REPLACE((@d),'With Encryption', '')
SET @d=REPLACE((@d),'with encryption', '')
IF CHARINDEX('WITH ENCRYPTION',UPPER(@d) )>0
    SET @d=REPLACE(UPPER(@d),'WITH ENCRYPTION', '')

execute( @d)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
