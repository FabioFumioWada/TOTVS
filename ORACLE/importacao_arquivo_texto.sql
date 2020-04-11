SQL - Importação de Arquivo Texto
Prezados,

para a importação de arquivos textos em uma determinada tabela de Banco de Dados:

O Oracle possui alguns tipos de importação de arquivos textos, por exemplo:

1) Importação com um único arquivo de dados e de controle:

Arquivo de dados e controle, conteúdo:

    LOAD DATA
    INFILE *
    APPEND INTO TABLE <Nome da Tabela> Ex: TabelaTemp
    FIELDS TERMINATED BY '$'
    <(Campos a serem atualizados)> Ex: (Codcoligada,Chapa)
    BEGINDATA
    <Dados a serem importados, separados pelo caracter "$"> Ex:1$00001

Após criado este arquivo, devemos no prompt do MS-DOS no diretório de instalação do Oracle\Bin, os arquivos "sqlldr.exe ou sqlldr80.exe" e executar o seguinte comando:

SQLLDR USERID=<USER/PASSWORD) Ex:RM/RM
CONTROL = <Caminho do arquivo criado acima> Ex:c:\temp\repres.txt

2) Importação com os arquivos de controles e de dados separados:

Arquivo de controle:

    LOAD DATA
    INFILE <Caminho do "Arquivo de Dados"> Ex: "C:\Windows\Temp\Teste.txt"
    APPEND
    INTO TABLE <Nome da Tabela> Ex: TabelaTemp
    FIELDS TERMINMATED BY "," OPITIONALLY ENCLOSED BY ' " '
            <Campos da tabela a serem populados>
    (campo0, campo1, campo2, campo3, campo4 DATE(20) "DD-Month-YYYY",
             campo5 CHAR TERMINATED BY ':')

Após criado este arquivo, devemos no prompt do MS-DOS no diretório de instalação do Oracle\Bin, os arquivos "sqlldr.exe ou sqlldr80.exe" e executar o seguinte comando:

SQLLDR USERID=<USER/PASSWORD) Ex:RM/RM
CONTROL = <Caminho do "arquivo de controle" criado acima> Ex:c:\temp\controle.ctl

** A possibilidade de utilizar o arquivo de controle separado do arquivo de dados, possibilita a formatação dos dados antes da importação na tabela, nem o trabalho de tratarmos as informações no arquivo texto, como no exemplo acima.
