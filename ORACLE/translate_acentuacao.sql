-- Oracle - Translate\Acentuação

SELECT NOME
FROM PPESSOA
WHERE upper
    (translate(nome,
    'ÁÇÉÍÓÚÀÈÌÒÙÂÊÎÔÛÃÕËÜáçéíóúàèìòùâêîôûãõëü',
    'ACEIOUAEIOUAEIOUAOEUaceiouaeiouaeiouaoeu')) =  'FÁBIO FÜMIO'