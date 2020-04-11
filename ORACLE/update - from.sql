--Oracle - UPDATE com FROM

--Exemplo:

-- ATUALIZA CAMPO DE HORARIO (LEGADO)
 UPDATE ZIMPFUNC_DEPARA_MATER A SET A.CODHORARIOLEG = ( SELECT  COD_HORARIO_061
                                                        FROM ZIMPFUNCIONARIOS_MATER B
                                                        WHERE B.CHAPA_001 = A.CODFUNC);
                                                                                                              
-- ATUALIZA CAMPO DE HORARIO (RM)
 UPDATE ZIMPFUNC_DEPARA_MATER A SET CODHORARIORM = ( SELECT  CODLABORE
                                                     FROM ZIMPFUNC_HORARIOS B
                                                     WHERE upper(substr(descr_dominio,2,length(descr_dominio))) = upper(a.codhorarioleg)); 

                                                     