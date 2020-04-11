SQL - Formato de datas
Formato Brasileiro sem as horas:
SELECT CONVERT(CHAR(10), CURRENT_TIMESTAMP, 103)as data
FROM GCOLIGADA
WHERE CODCOLIGADA = 0

Formato Americano sem as horas:
SELECT CONVERT(CHAR(10), CURRENT_TIMESTAMP, 120)as data
FROM GCOLIGADA
WHERE CODCOLIGADA = 0


Adiciona 23:59 da data em questão:
select dateadd(minute,59,dateadd(hour, 23, '2010-01-01'))
from gcoligada

Para zerar as horas
select dateadd(minute,-59,dateadd(hour, -23, '2010-01-01'))
from gcoligada