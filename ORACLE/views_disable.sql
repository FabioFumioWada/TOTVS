Oracle - Disable Views
SELECT 'DROP VIEW '||OWNER||'.'||VIEW_NAME||';' FROM DBA_VIEWS WHERE OWNER='RM' OR OWNER='WMSYS'