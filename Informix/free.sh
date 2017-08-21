#!/bin/bash
now=$(date +"%d-%m-%Y.%H:%M:%S")
echo "
select  
	name[1,16] Dbspace,						-- name truncated to 16 characters
	sum(chksize) Pages_size,					-- sum of all chunks size pages
	sum(chksize) - sum(nfree) Pages_used,
	sum(nfree) Pages_free,						-- sum of all chunks free pages
	round ((sum(nfree)) / (sum(chksize)) * 100, 2) Percent_free
from    
	sysdbspaces d, 
	syschunks c
where   
	d.dbsnum = c.dbsnum
group by 1
order by 1;
"| dbaccess sysmaster - 2>&1 | tee free-output-$now.log
