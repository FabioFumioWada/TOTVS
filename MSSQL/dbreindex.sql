SQL - DBReindex
DECLARE @COMANDO VARCHAR(255)
DECLARE @TABELA VARCHAR(100)

DECLARE CUR_TABLES CURSOR FOR
SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' ORDER BY NAME

OPEN CUR_TABLES
FETCH NEXT FROM CUR_TABLES INTO @TABELA

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Atualizando indices da tabela '+@TABELA
    SELECT @COMANDO = (SELECT 'DBCC DBREINDEX ('+@TABELA+')')
    EXEC ( @COMANDO )
    FETCH NEXT FROM CUR_TABLES INTO @TABELA
END
CLOSE CUR_TABLES
DEALLOCATE CUR_TABLES

SELECT @COMANDO = (SELECT 'DBCC UPDATEUSAGE ('+(select db_name())+')')
EXEC ( @COMANDO )
