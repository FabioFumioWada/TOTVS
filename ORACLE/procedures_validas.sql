Oracle - Procedures Válidas?

SELECT OBJECT_NAME, STATUS
FROM DBA_OBJECTS
WHERE OBJECT_TYPE = ’PROCEDURE’
AND STATUS = ‘INVALID’
