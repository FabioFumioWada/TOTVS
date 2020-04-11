Oracle - ORA-20000
Executando a instrução DBMS_OUTPUT.PUT_LINE(v_linha), após gerar uma certa quantidade de linhas, eu obtenho o seguinte erro:

ERRO na linha 1:
ORA-20000: ORU-10027: buffer overflow, limit of 2000 bytes
ORA-06512: at "SYS.DBMS_OUTPUT", line 106
ORA-06512: at "SYS.DBMS_OUTPUT", line 65
ORA-06512: at line 9

Para solucionarmos este erro basta aumentarmos o limite de Buffer. Devemos executar o seguinte comando antes da execução da procedure:
SET SERVEROUTPUT ON SIZE <tamanho> ;
