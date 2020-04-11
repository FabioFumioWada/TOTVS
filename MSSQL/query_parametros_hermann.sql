SQL - Query/Parâmetros
Exemplo....

SELECT CODCOLIGADA, CHAPA, NOME
FROM PFUNC
WHERE (CASE WHEN :PLN_$C$2_N = 9
THEN 9
ELSE CODCOLIGADA
END) = :PLN_$C$2_N


Quando o parâmetro for 9 listar todas as coligadas...
Senão listar somente a coligada corrente..