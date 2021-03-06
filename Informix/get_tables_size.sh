#!/bin/bash

now=$(date +"%d-%m-%Y.%H:%M:%S")
echo "
select
    dbsname,
    tabname,
    sum(size) as size
from
    sysextents
where
    dbsname = 'db_name'
group by
    1, 2
order by
    3;
"| dbaccess sysmaster - 2>&1 | tee get_tables_size-$now.log

#group by
# dbsname, tabname


