SQL - Importação de Arquivo Texto
Prezados,

para a importação de arquivos textos em uma determinada tabela de Banco de Dados:

SQL Server:

Devemos habilitar o seguinte parâmetro no Query Analyzer:

    sp_dboption <Nome da Database>, 'select into/bulkcopy', 'true'

Comando para importação:

BULK INSERT <Nome da Database>..<Nome da Tabela> FROM '<Endereço do arquivo texto>'
WITH (
    DATAFILETYPE = 'char',
    FIELDTERMINATOR = '#',
    ROWTERMINATOR = '\n'
)

** O campos dentro do arquivo texto deverão ter o mesmo tamanho do campo correspondente a ser importado, e deverá estar separado pelo caracter "#".
