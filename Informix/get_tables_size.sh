#!/bin/bash

now=$(date +"%d-%m-%Y.%H:%M:%S")
echo "
select
    dbsname,
    tabname,
    sum(size)*2 as size
from
    sysextents
where
    dbsname = 'db_name'
group by
    1, 2
having
    sum(size)*2 > 131072
order by
    3;
"| dbaccess sysmaster - 2>&1 | tee check_chunk-output-$now.log
