SQL - RM Chronus (Exemplo) - Arno
delete from funchor
declare @codcoligada int
declare @chapa       varchar(20)
declare @codsituacao       varchar(20)
--set @chapa ='0276626'
DECLARE CURSOR_CHAPA CURSOR FOR
    SELECT CODCOLIGADA,CHAPA,CODSITUACAO FROM PFUNC WHERE CODSITUACAO IN ('T','P','E','M','F','I')
and chapa ='0461376' --('0263186','0266619)
        OPEN CURSOR_CHAPA
            FETCH NEXT FROM CURSOR_CHAPA INTO @CODCOLIGADA,@CHAPA,@CODSITUACAO
                WHILE (@@FETCH_STATUS<>-1)
BEGIN

delete from calendario
declare @codhorario varchar(10)
declare @chapa2   varchar(20)
declare @contador int
declare @nrodiashor  int
declare @indiniciohorcont  int
declare @inicioindice int
    declare cursor_dias cursor for 
SELECT B.CODCOLIGADA,B.CHAPA,B.CODHORARIO,B.INDINICIOHOR,DATEDIFF(DD,d.iniciopermes,GETDATE())
FROM PFUNC B,AHORARIO C,aparam d
WHERE B.codcoligada=@CODCOLIGADA and B.CHAPA=@CHAPA
AND B.CODCOLIGADA=C.CODCOLIGADA
AND B.CODHORARIO=C.CODIGO
and b.codcoligada=d.codcoligada



open cursor_dias

fetch next from cursor_dias into @codcoligada,@chapa2,@codhorario,@inicioindice,@nrodiashor
    set @contador=@nrodiashor   
    select @indiniciohorcont=@inicioindice
    while @contador<>-1

begin
--drop table calendario
--create table calendario (codcoligada int,chapa varchar(20),data datetime,codhorario varchar(10),indice int,semana varchar(10), constraint pkcalendario primary key (codcoligada,data,codhorario,indice,semana))
insert into calendario
select     @codcoligada,@chapa2,
    convert(datetime,convert(varchar,datepart(yyyy,getdate()))+'/'+
    convert(varchar,datepart(mm,getdate()))+'/'+
    convert(varchar,datepart(dd,getdate())))-@contador,@codhorario,@indiniciohorcont,
    datename(dw,getdate()-@contador)



/*contadores*/

if @indiniciohorcont>=(SELECT MAX(INDICE) FROM ABATHOR WHERE CODHORARIO=@CODHORARIO)
begin
select @indiniciohorcont=(select distinct min(indice)
from abathor where codhorario=@codhorario)
end
else select @indiniciohorcont=@indiniciohorcont+1
select @contador=@contador-1

fetch next from cursor_dias into @codcoligada,@chapa2,@codhorario,@inicioindice,@nrodiashor
end
deallocate cursor_dias


IF @CODSITUACAO = 'F'
BEGIN

delete from func
declare @codcoligada2 int
declare @codhorario2 varchar(10)
declare @chapa3   varchar(20)
declare @contador2 int
declare @nrodiasaft1   int
declare @dtinicio1 datetime

declare cursor_comparacao1 cursor for 


SELECT A.CODCOLIGADA,A.CHAPA,B.CODHORARIO,case
    when dtfIMGOZO IS null
    then  datediff(dd,DTINIGOZO,getdate())
    else datediff(dd,dtiniGOZO,dtfiMGOZO)
    end ,dtiniGOZO
FROM PFHSTFER A,PFUNC B,AHORARIO C
WHERE A.codcoligada=@codcoligada and A.CHAPA=@chapa
AND A.CODCOLIGADA=B.CODCOLIGADA
AND A.CHAPA=B.CHAPA
AND B.CODCOLIGADA=C.CODCOLIGADA
AND B.CODHORARIO=C.CODIGO
AND A.DTINIGOZO=(SELECT MAX(DTINIGOZO) FROM PFHSTFER WHERE codcoligada=@codcoligada AND CHAPA=@chapa)


open cursor_comparacao1
fetch next from cursor_comparacao1 into @codcoligada2,@chapa3,@codhorario2,@nrodiasaft1,@dtinicio1
    set @contador2=@nrodiasaft1      
    while @contador2<>-1

begin
--drop table func
--create table func (codcoligada int,chapa varchar(20),codhorario varchar(10),data datetime, constraint pkfunc primary key  (codcoligada,chapa,codhorario,data))
--delete from func
insert into func
    select @codcoligada2,@chapa3,@codhorario2,@dtinicio1+@contador2



select @contador2=@contador2-1
fetch next from cursor_comparacao1 into @codcoligada2,@chapa3,@codhorario2,@nrodiasaft1,@dtinicio1
end
deallocate cursor_comparacao1
--drop table funchor
--CREATE TABLE FUNCHOR (CHAPA VARCHAR(20),CODHORARIO VARCHAR(10),DATA DATETIME, INDICE INT,SEMANA VARCHAR(10),BASE INT)
INSERT INTO FUNCHOR
select     a.chapa,b.codhorario,a.data,b.indice,b.semana,d.base
from func a,calendario b,abathor c,
(select codcoligada,chapa,base from aafhtfun 
where data = (select max(data) from aafhtfun where codcoligada=@codcoligada and chapa=@chapa)
and codcoligada=@codcoligada and chapa=@chapa)d
where     a.codcoligada=@codcoligada
and    a.codcoligada=b.codcoligada
and     a.chapa=b.chapa
and      a.codhorario=b.codhorario
and      a.data=b.data
and     c.codcoligada=b.codcoligada
and     c.codhorario=b.codhorario
and     c.indice=b.indice
and     a.codcoligada=d.codcoligada
and     a.chapa=d.chapa
and    c.tipo in (0)
and     b.semana <> 'Sunday'
and     b.data not in (select gferiado.diaferiado from gferiado)
and     b.data not in
(select data from aafhtfun,aparam where
aafhtfun.codcoligada=@codcoligada and aafhtfun.chapa=@chapa
and data between iniciopermes and getdate())
group by a.chapa,b.codhorario,a.data,b.indice,b.semana,d.base
order by a.data

END
ELSE
if @codsituacao in ('T','P','E','M')
/*SEGUNDA PARTE - COMPARACAO*/
begin
delete from func
declare @codcoligada1 int
declare @codhorario1 varchar(10)
declare @chapa1   varchar(20)
declare @contador1 int
declare @nrodiasaft   int
declare @dtinicio datetime

declare cursor_comparacao cursor for 
SELECT A.CODCOLIGADA,A.CHAPA,B.CODHORARIO,case
    when dtfinal IS null
    then  datediff(dd,DTINICIO,getdate())
    else datediff(dd,dtinicio,dtfinal)
    end ,dtinicio
FROM PFHSTAFT A,PFUNC B,AHORARIO C
WHERE A.codcoligada=@CODCOLIGADA and A.CHAPA=@CHAPA
AND A.CODCOLIGADA=B.CODCOLIGADA
AND A.CHAPA=B.CHAPA
AND B.CODCOLIGADA=C.CODCOLIGADA
AND B.CODHORARIO=C.CODIGO
AND A.DTINICIO=(SELECT MAX(DTINICIO) FROM PFHSTAFT WHERE CODCOLIGADA=@CODCOLIGADA AND CHAPA=@CHAPA)

open cursor_comparacao
fetch next from cursor_comparacao into @codcoligada1,@chapa1,@codhorario1,@nrodiasaft,@dtinicio
    set @contador1=@nrodiasaft      
    while @contador1<>-1

begin
--drop table func
--create table func (codcoligada int,chapa varchar(20),codhorario varchar(10),data datetime, constraint pkfunc primary key  (codcoligada,chapa,codhorario,data))
insert into func
    select @codcoligada1,@chapa1,@codhorario1,@dtinicio+@contador1



select @contador1=@contador1-1
fetch next from cursor_comparacao into @codcoligada1,@chapa1,@codhorario1,@nrodiasaft,@dtinicio
end
deallocate cursor_comparacao
--drop table funchor
--CREATE TABLE FUNCHOR (CHAPA VARCHAR(20),CODHORARIO VARCHAR(10),DATA DATETIME, INDICE INT,SEMANA VARCHAR(10),BASE INT)
INSERT INTO FUNCHOR
select     a.chapa,b.codhorario,a.data,b.indice,b.semana,d.base
from func a,calendario b,abathor c,
(select codcoligada,chapa,base from aafhtfun 
where data = (select max(data) from aafhtfun where codcoligada=@codcoligada and chapa=@chapa)
and codcoligada=@codcoligada and chapa=@chapa)d
where     a.codcoligada=@codcoligada
and    a.codcoligada=b.codcoligada
and     a.chapa=b.chapa
and      a.codhorario=b.codhorario
and      a.data=b.data
and     c.codcoligada=b.codcoligada
and     c.codhorario=b.codhorario
and     c.indice=b.indice
and     a.codcoligada=d.codcoligada
and     a.chapa=d.chapa
and     c.tipo in (0)--(c.tipo<>1 and c.tipo<>3)-- and c.tipo<>4)
and     b.semana <> 'Sunday'
and     b.data not in (select gferiado.diaferiado from gferiado)
group by a.chapa,b.codhorario,a.data,b.indice,b.semana,d.base
order by a.data
end



FETCH NEXT FROM CURSOR_CHAPA INTO @CODCOLIGADA,@CHAPA,@CODSITUACAO
END
DEALLOCATE CURSOR_CHAPA



/*select * from gferiado where diaferiado='2003-07-04'
select * from abathor where codhorario='20'*/
/*select *
from FUNCHOR where data between '2003-06-16' and '2003-07-15' order by chapa , data
*/
/*
select * from abatfunam WHERE CHAPA = '0334078'

select a.codcoligada,a.chapa from pfunc a where  exists
(select 1 from aafhtfun b where a.codcoligada=b.codcoligada and a.chapa=b.chapa)
and codsituacao = 'P'

select * from gferiado
order by diaferiado

select * from abathor where  CODHORARIO='30' order by INDICE


*/
