-- Oracle - Upper, Lower, Initcap, Replace, CHR e ASCII

-- Upper, Lower, Initcap, Replace, CHR e ASCII 

SELECT  UPPER('teste') AS MAIUSCULO,
        LOWER(UPPER('teste')) MINUSCULO,
        INITCAP('teste') PRIMEIRA_MAISUCULA,
        REPLACE(('TESTE  TAB  TAB'),CHR(32),' ') AS RETIRA_TAB,
       'FUMIO'||CHR(32)||'TESTE' AS ADICIONA_TAB_TEXTO,
        ASCII(' ') VERIFICA_CODIGO_ASC_TAB
from dual