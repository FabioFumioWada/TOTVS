SQL - Cursor (modelo)
DECLARE @nome_da_tabela varchar(40)
DECLARE meu_cursor CURSOR FOR

SELECT table_name FROM information_schema.tables WHERE table_type='BASE TABLE'  and table_name like 'P%'
OPEN meu_cursor

FETCH NEXT FROM meu_cursor
INTO @nome_da_tabela

WHILE @@FETCH_STATUS = 0
BEGIN
EXECUTE ('delete  FROM ' + @nome_da_tabela)

FETCH NEXT FROM meu_cursor
INTO @nome_da_tabela
END
CLOSE meu_cursor
DEALLOCATE meu_cursor
GO