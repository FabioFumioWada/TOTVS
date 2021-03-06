GRANT SELECT ON RM.GSISTEMA  TO ACESSO_RM;
GRANT SELECT ON RM.GACESSO  TO ACESSO_RM;
GRANT SELECT ON RM.GPARAMS  TO ACESSO_RM;
GRANT SELECT ON RM.GCOLIGADA  TO ACESSO_RM;
GRANT SELECT ON RM.GPERMIS  TO ACESSO_RM;
GRANT SELECT,UPDATE ON RM.GUSUARIO  TO ACESSO_RM;
GRANT SELECT ON RM.GUSRPERFIL TO ACESSO_RM;
GRANT SELECT ON RM.GSERVICO TO ACESSO_RM;
GRANT SELECT, INSERT ON RM.GDATALOG TO ACESSO_RM;
GRANT SELECT ON RM.GPARAMETROSSISTEMA TO ACESSO_RM;
GRANT SELECT ON RM.GSECPROVIDER TO SYSDBA;
GRANT SELECT ON RM.GMAILPARAMS TO ACESSO_RM;

CREATE PUBLIC SYNONYM GPARAMS 
FOR RM.GPARAMS 
;
CREATE PUBLIC SYNONYM GPERMIS 
FOR RM.GPERMIS 
;
CREATE PUBLIC SYNONYM GUSUARIO 
FOR RM.GUSUARIO 
;
CREATE PUBLIC SYNONYM GACESSO
FOR RM.GACESSO
;
CREATE PUBLIC SYNONYM GCOLIGADA
FOR RM.GCOLIGADA
;
CREATE PUBLIC SYNONYM GSISTEMA
FOR RM.GSISTEMA
;
CREATE PUBLIC SYNONYM GUSRPERFIL
FOR RM.GUSRPERFIL
;
CREATE PUBLIC SYNONYM GSERVICO
FOR RM.GSERVICO
;
CREATE PUBLIC SYNONYM GDATALOG
FOR RM.GDATALOG
;
CREATE PUBLIC SYNONYM GPARAMETROSSISTEMA
FOR RM.GPARAMETROSSISTEMA
;
CREATE PUBLIC SYNONYM GSECPROVIDER
FOR RM.GSECPROVIDER
;
CREATE PUBLIC SYNONYM GMAILPARAMS
FOR RM.GMAILPARAMS
;