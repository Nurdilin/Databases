#!/bin/bash

now=$(date +"%d-%m-%Y.%H:%M:%S")
echo "
select
	idxname,		-- index name
	levels			--index level
from
	sysindexes si
where
	si.levels > 5
order by
	2 DESC;
"| dbaccess sysmaster - 2>&1 | tee get-exreme-index-levels-$now.log
