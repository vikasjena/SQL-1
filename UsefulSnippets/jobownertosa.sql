Declare @Job varchar(128)
Declare @cmd varchar(1024)

DECLARE job_csr CURSOR FOR select distinct JobName from dbamaint.dbo.jobs_report WHERE owner != 'sa'
		order by JobName

OPEN job_csr
FETCH NEXT FROM job_csr INTO @Job

	WHILE (@@fetch_status <> -1)

	BEGIN

	print '------------------------------------'
	print '-- Job = ' + @Job

	select @cmd =	'EXEC msdb.dbo.sp_update_job @job_name=N''' + @Job + ''', @owner_login_name=N''sa''' 

	print @cmd
	--exec(@cmd)

	FETCH NEXT FROM job_csr INTO @Job

	END

CLOSE job_csr
DEALLOCATE job_csr

--exec dbamaint.dbo.dbm_JobsReport