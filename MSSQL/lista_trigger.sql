SQL - Lista Trigger
select TB.name 'table', TR.name 'trigger'
from sysobjects TR, sysobjects TB
where tr.type = 'TR'
and TR.parent_obj = TB.ID
