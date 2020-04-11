SQL - Linked Server
Prezados,
segue esquema para conexão de Banco de Dados numa outra máquina/servidor, quando necessitamos executar uma Query:

Criar um Acesso :

USE master
GO
EXEC sp_addlinkedserver
    'NOME DO SERVIDOR',
    N'SQL Server'
GO
EXEC sp_addlinkedsrvlogin 'NOME DO SERVIDOR', 'false', NULL, 'USUÁRIO', 'SENHA'


Para consultar:

SELECT *
FROM OPENQUERY(CUSTFSPSERVER, 'SELECT * FROM FINANCEIRO.DBO.GCOLIGADA')
EXEC sp_addlinkedsrvlogin 'NOME DO SERVIDOR', 'false', NULL, 'USUÁRIO', 'SENHA'