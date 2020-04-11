Oracle - Verificação
set heading off
set pagesize 0
set verify off
set feedback off
set termout off
set linesize 132

prompt spool count_rows.log
prompt !date +'%X'

spool c:\arquivo1.txt
select trim(name),trim(value) from v$parameter;
spool of

spool c:\arquivo2.txt
select * from nls_database_parameters;
spool of


prompt !date +'%X'
prompt spool off
spool off