
---tato malá funkce vrací informaci zda daná linka vyrábí 

USE [PG-MAINTENANCE-T]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_isLocationWorking]    Script Date: 12.12.2023 11:09:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[fun_isLocationWorking]
(
	@location_id int
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @working BIT, @prodLine varchar(50)

	SELECT @prodLine=ProdLine 
	FROM Promon_data WHERE ProdLine = (SELECT name from Location WHERE id_location=@location_id)

	if (@prodLine is NUll)
		set @working=0
	if (@prodLine is not NUll)
		set @working=1

	RETURN @working

END
