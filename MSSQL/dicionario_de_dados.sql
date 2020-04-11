SQL - Dicionário de Dados
select SUBSTRING (TABLE_NAME,1,40) TABLE_NAME, SUBSTRING (COLUMN_NAME,1,40) COLUMN_NAME, IS_NULLABLE,
       CASE DATA_TYPE
            WHEN 'varchar' then 'varchar(' + convert(varchar,CHARACTER_MAXIMUM_LENGTH) + ')'
            WHEN 'varchar' then 'char(' + convert(varchar,CHARACTER_MAXIMUM_LENGTH) + ')'
            else SUBSTRING(DATA_TYPE,1,25)
       END AS DATA_TYPE, gcampos.DESCRICAO
from information_schema.columns c, gcampos
where gcampos.tabela = c.TABLE_NAME
and gcampos.coluna = c.COLUMN_NAME
AND C.TABLE_NAME = 'FCFODEF'
order by C.TABLE_NAME,C.ORDINAL_POSITION
