Oracle - Cursor (Exemplo)
set outputline on;
begin
declare CODIGO VARCHAR2(150);
CURSOR C_TESTE IS SELECT chapa FROM PFUNC where chapa like '00%' group by chapa;
BEGIN
  OPEN C_TESTE;
  FETCH  C_TESTE INTO  CODIGO;
  LOOP  Exit when c_teste%NOTFOUND;
      dbms_output.put_line (codigo);
      FETCH  C_TESTE INTO  CODIGO;
 END LOOP;
       CLOSE  C_TESTE;
END;
END;