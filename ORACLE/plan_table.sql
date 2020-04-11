Oracle - Plan Table
create table PLAN_TABLE (
    statement_id     varchar2(30),
    timestamp        date,
    remarks          varchar2(80),
    operation        varchar2(30),
    options           varchar2(30),
    object_node      varchar2(128),
    object_owner     varchar2(30),
    object_name      varchar2(30),
    object_instance numeric,
    object_type     varchar2(30),
    optimizer       varchar2(255),
    search_columns  number,
    id        numeric,
    parent_id    numeric,
    position    numeric,
    cost        numeric,
    cardinality    numeric,
    bytes        numeric,
    other_tag       varchar2(255),
    partition_start varchar2(255),
      partition_stop  varchar2(255),
      partition_id    numeric,
    other        long);



explain plan set statement_id='ID1' into plan_table for
select * from IBEM;

SELECT LPAD(' ',2*(LEVEL-1))||operation operation, options, object_name, position
    FROM plan_table
    START WITH id = 0 AND statement_id = 'ID1'
    CONNECT BY PRIOR id = parent_id AND
    statement_id = 'ID1';



SELECT  LPAD(' ',2*(LEVEL-1))||operation operation,options, object_name, position
    FROM plan_table
    WHERE object_name not like 'I_%' and
    object_name <> 'USER$' and
    object_name <> 'OBJ$' and
    object_name <> 'USER$'
    START WITH id = 0 AND statement_id = 'ID1'
    CONNECT BY PRIOR id = parent_id AND
    statement_id = 'ID1';


SELECT  LPAD(' ',2*(LEVEL-1))||operation operation,options, object_name, position
    FROM plan_table
    WHERE object_name NOT IN ('USER$','OBJ$','I_OBJ2','I_IND1','I_LINK1','IND$')
    START WITH id = 0 AND statement_id = 'ID1'
    CONNECT BY PRIOR id = parent_id AND
    statement_id = 'ID1';

SELECT  LPAD(' ',2*(LEVEL-1))||operation operation,options, object_name, position
    FROM plan_table
    WHERE object_owner='RM'
    START WITH id = 0 AND statement_id = 'ID1'
    CONNECT BY PRIOR id = parent_id AND
    statement_id = 'ID1';



SELECT statement_id,
timestamp,       
remarks,         
operation,       
options,          
object_node,     
object_owner,    
object_name ,    
object_instance,
object_type,    
optimizer,      
search_columns, 
id,       
parent_id,   
position,   
cost,       
cardinality,   
bytes,       
other_tag,      
partition_start,
partition_stop, 
partition_id,   
other
FROM plan_table;