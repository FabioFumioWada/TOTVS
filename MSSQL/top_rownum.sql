Oracle|MSSQL - ROWNUM\TOP


Prezados,

No banco dados SQL Server (MSSQL), é comum criarmos sentenças com o comando TOP, para facilitar as nossas pesquisas e análises.

Ex:          SELECT TOP 5 *
                FROM GCOLIGADA

Neste comando, ele listará os 5 primeiros registros da tabela GCOLIGADA.

No Oracle, não temos o comando TOP, com o mesmo resultado/funcionalidade, então podemos usar o comando ROWNUM, que funcionará da mesma forma que o comando TOP (MSSQL):

Ex:          SELECT *
                FROM GCOLIGADA
                WHERE ROWNUM <= 5