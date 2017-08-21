#!/bin/bash
echo "
select  
	sysdatabases.name database,	-- Database Name
	syssessions.username,		-- User Name
	syssessions.hostname,		-- Workstation
	syslocks.owner sid		-- Informix Session ID
from
	syslocks, sysdatabases, outer syssessions
where  
	syslocks.tabname = \"sysdatabases\"	-- Find locks on sysdatabases
and     syslocks.rowidlk = sysdatabases.rowid	-- Join rowid to database
and     syslocks.owner = syssessions.sid	-- Session ID to get user info
order by 1;
"| dbaccess sysmaster - 2>&1 | tee who-output.log
