SQL - Execute Plain

Para gerar "Execute Plain" em formato devemos:

1) Executar o Query Analyzer;
2) Executar a linha de comando:

  set showplan_text on
  go

  select *
  from pfunc (query de exemplo)
  go

  set showplan_text off
  go