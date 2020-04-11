RM - Coligada Corrente
select ultimacoligada as coligadacorrente
from gusuario
where codusuario = (select username
                    from glogin
                    where computername = (select distinct hostname
                                          from master..sysprocesses
                                          where spid = (select @@spid))
                    and datepart(yyyy,logintime) = (select distinct datepart(yyyy, getdate()) from gcoligada)
                    and datepart(mm,logintime) = (select distinct datepart(mm, getdate()) from gcoligada)
                    and datepart(dd,logintime) = (select distinct datepart(dd, getdate()) from gcoligada))

