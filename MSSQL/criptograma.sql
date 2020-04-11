SQL \ RM - Criptograma
Pessoal,

Conforme solicitado várias vezes a RM Sistemas, alguns clientes solicitam que informações importantes, tais como: valores e datas sejam mascaradas, ou seja, anuladas. O principal intuito é a  preservação e sigilo de informações cadastradas na base de dados. Sendo assim, criamos o procedimento abaixo que fará todo o processo, sendo que haverá necessidade apenas de pré-determinar quais tabelas e quais informações deverão ser anuladas.

veja exemplo abaixo:

Dentro do cursor criado na estrutura da procedure, filtrei as seguintes informações a serem anuladas:

P% => Limitei apenas nas tabelas que começam com a letra P, neste caso tabelas do RM-Labore
SALA% => Cujo campos começam com SALA ou
VALOR% => cujo campos começam com VALOR ou
DATA% => cujo campos começam com DATA

Obs.: Dentro deste cursor o usuário poderá definir vários filtros de acordo com a necessidade.

DECLARE @TABELA VARCHAR(20)
DECLARE @CAMPO  VARCHAR(20)
DECLARE @COMANDO VARCHAR(255)
DECLARE INFO CURSOR FOR
       SELECT T.NAME,C.NAME FROM SYSOBJECTS T, SYSCOLUMNS C
       WHERE T.ID=C.ID AND T.NAME LIKE 'P%' AND (C.NAME LIKE 'SALA%' OR C.NAME LIKE 'VALOR%'OR C.NAME LIKE 'DATA%')
OPEN INFO
 FETCH NEXT FROM INFO INTO @TABELA,@CAMPO
  WHILE @@FETCH_STATUS = 0
   BEGIN
      SET @COMANDO = 'UPDATE ' + @TABELA + ' SET ' + ''+@CAMPO+'' + ' = NULL '
      EXEC ( @COMANDO)
      PRINT 'O campo '+@campo+' da tabela '+@tabela +' foi anulado.'
   FETCH NEXT FROM INFO INTO @TABELA,@CAMPO
 END
CLOSE INFO
DEALLOCATE INFO
Postado por Fabio Fumio Wada às 15:54  
Marcadores: Criptograma, RM, SQL
SQL - Case (Exemplo)
 (SELECT 'diasemana' =
        CASE
         WHEN DATEPART(WEEKDAY, ZATENDIMENTOS.DTHENTRADA) = 1 THEN 'Domingo'
         WHEN DATEPART(WEEKDAY, ZATENDIMENTOS.DTHENTRADA) = 2 THEN 'Segunda'
         WHEN DATEPART(WEEKDAY, ZATENDIMENTOS.DTHENTRADA) = 3 THEN 'Terça'
         WHEN DATEPART(WEEKDAY, ZATENDIMENTOS.DTHENTRADA) = 4 THEN 'Quarta'
         WHEN DATEPART(WEEKDAY, ZATENDIMENTOS.DTHENTRADA) = 5 THEN 'Quinta'
         WHEN DATEPART(WEEKDAY, ZATENDIMENTOS.DTHENTRADA) = 6 THEN 'Sexta'
         WHEN DATEPART(WEEKDAY, ZATENDIMENTOS.DTHENTRADA) = 7 THEN 'Sábado'
    END) DIASEMANA,