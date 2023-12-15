----ukázka procedury pro odeslání emailu 


USE [PG-MAINTENANCE-T]
GO
/****** Object:  StoredProcedure [dbo].[proc_emailForAdminService]    Script Date: 12.12.2023 10:55:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[proc_emailForAdminService] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	declare @q nvarchar(max), @bodytext nvarchar(max), @sub nvarchar(max)
	DECLARE @xml NVARCHAR(MAX)
	DECLARE @body NVARCHAR(MAX)
    declare @count int
	declare @email nvarchar(100)
	
	begin
		set @email= 'jmeno.projmeni@cz.rheinmetall.com; jmeno2.prijmeni2@cz.rheinmetall.com'

		set @q = N'<html><head></head><body>Dobrý den,<br/>máte nevyřízené servisní úkoly. <br/>'
		set @q=@q+N'<a href="http://10.11.0.60:8101/Maintenance/task/list-service">Servisní úkoly</a><br/>'
		set @q=@q+N'<br />Tento e-mail je automaticky generován, <b>neodpovídejte!</b>'

		select @count=COUNT(Task.id_task) from view_Task as Task join General_task on general_task=id_gen_task 
		where service=1 and (is_completed=0 or is_completed is null) 
			and (General_task.is_deleted =0 or General_task.is_deleted is null) and ( Task.dateDiff = 30)		
		
		if (@count=0)
		begin
			EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'SMTP_default',
			@recipients = @email,
			@subject = 'Preventivní údržba - servisní úkoly',
			@body = @q,
			@body_format = 'HTML' ;
		end
	END
end
--------------------
USE [PG-MAINTENANCE-T]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_getActiveLocationWithTasks]    Script Date: 12.12.2023 11:02:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO