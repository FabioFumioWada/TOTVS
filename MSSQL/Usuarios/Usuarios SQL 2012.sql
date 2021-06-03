SP_DROPUSER SYSDBA
GO

IF NOT EXISTS(SELECT * FROM MASTER.DBO.SYSLOGINS WHERE NAME = 'rm')
   CREATE LOGIN rm WITH PASSWORD = 'rm',CHECK_POLICY=OFF
GO


EXEC SP_CHANGEDBOWNER rm
GO

IF NOT EXISTS(SELECT * FROM MASTER.DBO.SYSLOGINS WHERE NAME = 'sysdba')
   CREATE LOGIN sysdba WITH PASSWORD = 'masterkey',CHECK_POLICY=OFF 
GO
 
sp_adduser sysdba,sysdba
GO

GRANT SELECT ON GPARAMS TO sysdba
GO
GRANT SELECT , UPDATE ON GUSUARIO TO sysdba
GO
GRANT SELECT ON GPERMIS  TO sysdba
GO
GRANT SELECT ON GACESSO  TO sysdba
GO
GRANT SELECT ON GSISTEMA  TO sysdba
GO
GRANT SELECT ON GCOLIGADA  TO sysdba
GO
GRANT SELECT ON GUSRPERFIL TO sysdba
GO
GRANT SELECT ON GSERVICO TO sysdba
GO
GRANT SELECT ON GPARAMETROSSISTEMA TO sysdba
GO
GRANT SELECT,INSERT ON GDATALOG TO sysdba
GO
GRANT SELECT ON GSECPROVIDER TO sysdba
GO
GRANT SELECT ON GMAILPARAMS TO sysdba
GO
GRANT SELECT ON GUPGATUALIZACAO TO sysdba
GO
GRANT SELECT,INSERT,DELETE,UPDATE ON GSESSAOFLUIG TO sysdba
GO
GRANT SELECT,INSERT,DELETE,UPDATE ON GULTIMOCONTEXTOUSUARIO TO sysdba
GO

SP_DEFAULTLANGUAGE 'RM','ENGLISH'
GO
SP_DEFAULTLANGUAGE 'SYSDBA','ENGLISH'
GO


