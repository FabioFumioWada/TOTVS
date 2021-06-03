SELECT *
FROM (

        SELECT  GFILTROS.CODCOLIGADA,
                GFILTROS.ID,
                GFILTROS.CODAPLICACAO,
                GFILTROS.DESCRICAO,
                GFILTROS.TABELA,
                GCONDICAO.CAMPO,
                GCONDICAO.OPERADOR,
                GCONDICAO.VALOR,
                GCONDICAO.OPERADORLOGICO,
                GCONDICAO.ORDEM,
                GFILTROS.RECCREATEDBY,
                GFILTROS.RECMODIFIEDBY
        FROM    GFILTROS
                    INNER JOIN GCONDICAO
                        ON GFILTROS.ID = GCONDICAO.IDFILTRO
        WHERE GFILTROS.TABELA IN ('PFUNC','PPESSOA','FLAN','FXCX','FCFO','SALUNO','SMATRICPL','SCONTRATO','TMOV')
        AND UPPER(GCONDICAO.CAMPO) IN (     SELECT DISTINCT UPPER(COLUMN_NAME)
                                            FROM USER_TAB_COLUMNS
                                            WHERE DATA_TYPE IN ('VARCHAR2','CHAR','LONG'))
    )