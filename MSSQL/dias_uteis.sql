RM - Dias Úteis
Dias Uteis (SQL)

-DROP FUNCTION DIASUTEISMES

--CREATE FUNCTION DIASUTEISMES (@MES INT, @ANO INT, @CODCOLIGADA DCODCOLIGADA, @CHAPA DCHAPA)
--RETURNS INT

--AS BEGIN

DECLARE @CODCOLIGADA DCODCOLIGADA
DECLARE @CHAPA DCHAPA
DECLARE @MES INT
DECLARE @ANO INT
DECLARE @MESPROX INT
DECLARE @ANOPROX INT
DECLARE @DIATEMP INT
DECLARE @DATATEMP DATETIME
DECLARE @STATUSDATA DATETIME
DECLARE @FERIADO INT
DECLARE @COMPDESC INT
DECLARE @DIASUTEIS INT
DECLARE @DATASTRING VARCHAR(10)

SET @MES = 10
SET @ANO = 2003
SET @CODCOLIGADA = 1
SET @CHAPA = '931.00595'

-----------------------------------------------------------------------------------------
-- PROXIMO MÊS E ANO
-----------------------------------------------------------------------------------------
IF @MES = 12
BEGIN
  SET @MESPROX = 1
  SET @ANOPROX = @ANO+1
END
ELSE
BEGIN
  SET @MESPROX = @MES+1
  SET @ANOPROX = @ANO 
END

PRINT 'MÊS E ANO PARA QUAL SERÁ COMPRADO O BENEFÍCIO'
PRINT 'PRÓXIMO MÊS: '+CAST(@MESPROX AS VARCHAR)
PRINT 'PRÓXIMO ANO: '+CAST(@ANOPROX AS VARCHAR)
PRINT '----------------------------------------'

-----------------------------------------------------------------------------------------
-- DIA COMPENSADO E DIA DE DESCANSO (SÁBADO E DOMINGO)
-----------------------------------------------------------------------------------------

-- ULTIMO DIA DO MES PROXIMO (SEJA 31, 30 OU 28)
SET @DATASTRING = (SELECT  CAST(@MESPROX AS VARCHAR) + '/1/'+ CAST(@ANOPROX AS VARCHAR))
SET @DATATEMP = (SELECT DATEADD(MONTH,1,(CAST(@DATASTRING AS DATETIME))))-1
PRINT 'DATA LIMITE DA COMPRA DO BENEFÍCIO : '+ CAST(@DATATEMP AS VARCHAR)
PRINT '----------------------------------------'

-- CÁLCULO DE SÁBADOS E DOMINGOS

SET @DIATEMP = 0
SET @COMPDESC = 0

WHILE @DIATEMP < DATEPART(DD, @DATATEMP)
BEGIN
  SET @DATASTRING = (SELECT CAST(@MESPROX AS VARCHAR) + '/'+ CAST(DATEPART(DD,@DIATEMP)AS VARCHAR) + '/'+CAST(@ANOPROX AS VARCHAR))
  --PRINT 'DATA STRING 2: ' + @DATASTRING
  SET @STATUSDATA = CAST(@DATASTRING AS DATETIME)
  --PRINT 'DATA DATETIME 2: ' + CAST(@STATUSDATA AS VARCHAR)
  --PRINT '----------------------------------------'
  IF (DATENAME(WEEKDAY,@STATUSDATA) = 'Saturday') OR (DATENAME(WEEKDAY,@STATUSDATA) = 'Sunday')
  BEGIN
    SET @COMPDESC = @COMPDESC+1
  END
  SET @DIATEMP = @DIATEMP+1
END

-----------------------------------------------------------------------------------------
-- FERIADOS
-----------------------------------------------------------------------------------------
SET @FERIADO = 0
SET @FERIADO = (SELECT COUNT(*)
                FROM GFERIADO
                WHERE CODCALENDARIO = (SELECT CODCALENDARIO
                                       FROM PSECAO
                                       WHERE CODCOLIGADA = @CODCOLIGADA
                                       AND CODIGO = (SELECT CODSECAO
                                                     FROM PFUNC
                                                     WHERE CODCOLIGADA = @CODCOLIGADA
                                                     AND CHAPA = @CHAPA))
                AND DATEPART(MM,DIAFERIADO) = @MESPROX
                AND DATEPART(YYYY,DIAFERIADO) = @ANOPROX)

-----------------------------------------------------------------------------------------
-- DIAS UTEIS
-----------------------------------------------------------------------------------------
SET @DIATEMP = 0
SET @DIATEMP = CAST(DATEPART(DD,@DATATEMP)AS INT)
PRINT 'QTD DE DIAS DO MES DE COMPRA BENEFICIO: ' + CAST(DATEPART(DD, @DATATEMP) AS VARCHAR)
PRINT 'QTD DE DIAS DE FERIADO DE COMPRA BENEFICIO: ' + CAST(@FERIADO AS VARCHAR)
PRINT 'QTD DE DIAS DE COMPENSADOS DE COMPRA DE BENEFICIO: ' + CAST(@COMPDESC AS VARCHAR)
SET @DIASUTEIS = (@DIATEMP - @FERIADO - @COMPDESC)
PRINT 'QTD DE DIAS UTEIS DO MES DE COMPRA DE BENEFICIO: ' + CAST(@DIASUTEIS AS VARCHAR)

--RETURN @DIASUTEIS

--END
