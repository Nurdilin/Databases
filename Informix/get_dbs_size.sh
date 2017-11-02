#!/bin/bash

now=$(date +"%d-%m-%Y.%H:%M:%S")
echo "
select
    dbsname,
    SUM(ti_nptotal * ti_pagesize / 1024) :: INT AS kb_alloc,
    SUM(ti_npused * ti_pagesize / 1024) :: INT AS kb_used
from
    sysdatabases AS d,
    systabnames AS n,
    systabinfo AS i
where
    n.dbsname = d.name
AND
    ti_partnum = n.partnum
group by 1
order by 1;
"| dbaccess sysmaster - 2>&1 | tee check_chunk-output-$now.log
