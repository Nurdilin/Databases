#!/bin/bash
#isplay information about chunks
now=$(date +"%d-%m-%Y.%H:%M:%S")
echo "
select
	name dbspace,           -- dbspace name
	is_mirrored,            -- dbspace is mirrored 1=Yes 0=No
	is_blobspace,           -- dbspace is blobspace 1=Yes 0=No
	is_temp,                -- dbspace is temp 1=Yes 0=No
	chknum chunknum,        -- chunk number
	fname  device,          -- dev path
	offset dev_offset,      -- dev offset
	is_offline,             -- Offline 1=Yes 0=No
	is_recovering,          -- Recovering 1=Yes 0=No
	is_blobchunk,           -- Blobspace 1=Yes 0=No
	is_inconsistent,        -- Inconsistent 1=Yes 0=No
	chksize Pages_size,     -- chunk size in pages
	(chksize - nfree) Pages_used, -- chunk pages used
	nfree Pages_free,       -- chunk free pages
	round ((nfree / chksize) * 100, 2) percent_free, -- free
	mfname mirror_device,   -- mirror dev path
	moffset mirror_offset,  -- mirror dev offset
	mis_offline ,           -- mirror offline 1=Yes 0=No
	mis_recovering          -- mirror recovering  1=Yes 0=No
from    
	sysdbspaces d, 
	syschunks c
where 
	d.dbsnum = c.dbsnum
order by dbspace, chunknum;
"| dbaccess sysmaster - 2>&1 | tee check_chunk-output-$now.log
