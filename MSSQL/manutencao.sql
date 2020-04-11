SQL - Manutencao2.sql
set nocount on

declare @comando varchar(255)
declare @comando1 varchar(255)
declare @comando2 varchar(255)
declare @comando3 varchar(255)
declare @comando4 varchar(255)
declare @database varchar(100)

Print 'Espaco Alocado no database'

exec sp_spaceused

declare teste cursor for

SELECT distinct TABLE_CATALOG FROM INFORMATION_SCHEMA.TABLES

open teste

fetch next from teste into @database

while (@@fetch_status=0)


begin

 EXEC sp_dboption @database, 'trunc. log on chkpt.', 'TRUE'
 EXEC sp_dboption @database, 'auto create statistics', 'FALSE'
 EXEC sp_dboption @database, 'auto update statistics', 'FALSE'
 EXEC sp_dboption @database, 'ANSI null default', 'TRUE'

 print 'Verificando estrututura no Banco '+ @database
 set @comando1 ='dbcc checkdb ('+@database+')'
 exec (@comando1)
 print '---------------------------------------------'
 print ' '

 print 'Verificando espaco alocado no Banco'+@database
 set @comando2= 'dbcc checkalloc ('+@database+')'
 exec (@comando2)
 print '---------------------------------------------'
 print ' '

 print 'Alocacao '+ @database
 set @comando3= 'dbcc newalloc ('+@database+')'
 exec (@comando3)
 print ' '

fetch next from teste into @database
end
close teste
deallocate teste

Print 'Final da Manuntencao'
print '*******************************************************************************************'
print '**********************************************************************************'
print '***************************************************************'
