#Hermann
#Felipe

-- Lista a coligada 9 ou a coligada do parâmetro
SELECT CODCOLIGADA, CHAPA, NOME 
FROM PFUNC
WHERE (CASE WHEN :PLN_$C$2_N = 9 
THEN 9 
ELSE CODCOLIGADA
END) = :PLN_$C$2_N

Colado de <https://fabiofumiocloud.blogspot.com.br/2010/12/?m=0> 


CASE "CODFILIAL"

-- Lista todas as filiais ou a filial selecionada/informada no parâmetro
SELECT *
FROM RM.GFILIAL
WHERE CODCOLIGADA = 2
AND (CASE WHEN TO_NUMBER(:PARAM_CODFILIAL) = 0 
        THEN 0 
    ELSE CODFILIAL
    END) = :PARAM_CODFILIAL

CASE "CODCOLIGADA" do parâmetro ou todas as coligadas

SELECT CODCOLIGADA, NOME 
FROM GCOLIGADA
WHERE (CASE WHEN :PAR_COLIGADA = 0 
                THEN 0
        ELSE CODCOLIGADA
        END) = :PAR_COLIGADA
