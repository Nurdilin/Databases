#!/bin/bash
#To check the DBs that exist on a DB server as well as the allocated and used kb
now=$(date +"%d-%m-%Y.%H:%M:%S")
echo "
SELECT
	dbsname,
	SUM(ti_nptotal * ti_pagesize / 1024) :: INT AS kb_alloc,
	SUM(ti_npused * ti_pagesize / 1024) :: INT AS kb_used
FROM
	sysdatabases AS d,
	systabnames AS n,
	systabinfo AS i
WHERE 
	n.dbsname = d.name AND 
	ti_partnum = n.partnum
GROUP BY 1
ORDER BY 1
"| dbaccess sysmaster - 2>&1 | tee check_dbs-output-$now.log
