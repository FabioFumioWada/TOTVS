-- TOTVS RM - CONVERTENDO CAMPO HORA (PFFINANC) PARA FORMATO DE TELA

select   
        codcoligada,
        chapa,
        anocomp,
        mescomp,
        nroperiodo,
        ref,
        hora,
        valor,

        (hora/60.0) hora_base_calc,

        floor(hora/(60.0)) hora_oficial,

        (hora/60.0) - floor(hora/(60.0)) minutos_base_calc,

        (((hora/60.0) - floor(hora/(60.0))) * 60) minutos_base_calc2,

        round((((hora/60.0) - floor(hora/(60.0))) * 60),1) minutos_oficial,

        floor(hora/(60.0)) +
        (round((((hora/60.0) - floor(hora/(60.0))) * 60),1))/100 HORA_TELA

from pffinanc
where hora > 0
