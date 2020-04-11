SQL - Deleta Estatisticas
declare @tab_nome varchar(255)
declare @tab_statistic varchar(255)
declare @sql_str varchar(255)
declare @db_nome varchar(255)

select @db_nome=name from master..sysdatabases where dbid=(select dbid from master..sysprocesses where spid=@@SPID)
set @sql_str= 'sp_dboption ''' + @db_nome + ''',''auto create statistics'',''false'''
exec (@sql_str)
set @sql_str= 'sp_dboption ''' + @db_nome + ''',''auto update statistics'',''false'''
exec (@sql_str)
checkpoint

declare cur cursor for SELECT object_name(id),name FROM SYSINDEXES WHERE NAME LIKE '_WA_Sys%'
set nocount on
open cur
fetch next from cur into @tab_nome,@tab_statistic
while(@@fetch_status=0)
begin
  set @sql_str='drop statistics ' + @tab_nome + '.' + @tab_statistic
  print @sql_str
  exec (@sql_str)
  fetch next from cur into @tab_nome,@tab_statistic
end
close cur
deallocate cur
set nocount off
