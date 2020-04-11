Conversão de Decimal\Horas - RM
Cálculo/Conversão de Decimais e Horas de acordo com as tabelas do RMChronus/Totvs:


-- (690/11:30)
select    690 decimal,
        floor(convert(decimal,(690))/60) horas,       
        (((convert(decimal,(690))/60) - floor(convert(decimal,(690))/60))*60) minutos
from GCOLIGADA
where CODCOLIGADA = 0


-- (681/11:21)
select    681 decimal,
        floor(convert(decimal,(681))/60) horas,       
        (((convert(decimal,(681))/60) - floor(convert(decimal,(681))/60))*60) minutos
from GCOLIGADA
where CODCOLIGADA = 0