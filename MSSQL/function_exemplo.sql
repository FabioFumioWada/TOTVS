SQL - Functions (modelo)

CREATE Function AchaDescricaoConta(var_codcoligada number,
var_contafolha varchar,
var_codigointegracao varchar)
return varchar

as

VAR_CONTACONTABIL varchar2(40);
VAR_DESCRICAO varchar2(40);

begin


select contasaldus into VAR_CONTACONTABIL
from pcontas       
where codcoligada=var_codcoligada
and codcolconta=var_codcoligada
and grpconta=var_contafolha
and integrcfunc=var_codigointegracao;


select descricao into VAR_DESCRICAO
from cconta
where codcoligada=var_codcoligada
and codconta=VAR_CONTACONTABIL ;

return(VAR_DESCRICAO);

end;