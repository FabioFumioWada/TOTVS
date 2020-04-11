Oracle - Function (Retira Acentuação)

Criei uma função para alterar os caracteres acentuados de um texto/string, facilitando assim algumas consultas/pesquisas que temos de realizar, uma vez que o Oracle diferencia caracteres acentuados dos não acentuados.
O nome da função é: FNC_RETIRA_ACENTUACAO, e a sua utilização é feita da seguinte forma:

FNC_RETIRA_ACENTUACAO( “Texto a ser alterado”)

Ex:          SELECT FNC_RETIRA_ACENTUACAO('ÁÇÉÍÓÚÀÈÌÒÙÂÊÎÔÛÃÕËÜáçéíóúàèìòùâêîôûãõëü')
FROM DUAL;

Resultado:  ACEIOUAEIOUAEIOUAOEUaceiouaeiouaeiouaoeu



CREATE OR REPLACE FUNCTION FNC_RETIRA_ACENTUACAO(V_TEXTO_I IN VARCHAR2)
RETURN VARCHAR2
IS V_TEXTO_O VARCHAR2(100);
BEGIN
  V_TEXTO_O := translate(V_TEXTO_I,'ÁÇÉÍÓÚÀÈÌÒÙÂÊÎÔÛÃÕËÜáçéíóúàèìòùâêîôûãõëü',
                                   'ACEIOUAEIOUAEIOUAOEUaceiouaeiouaeiouaoeu'); 
  RETURN (V_TEXTO_O);
END;



SELECT FNC_RETIRA_ACENTUACAO('ÁÇÉÍÓÚÀÈÌÒÙÂÊÎÔÛÃÕËÜáçéíóúàèìòùâêîôûãõëü')
FROM DUAL
