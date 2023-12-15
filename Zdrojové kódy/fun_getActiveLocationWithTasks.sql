--- tato funkce slouží k počítání úkolů a vrací jejich počet s příslušnou barvou a lokací
ALTER FUNCTION [dbo].[fun_getActiveLocationWithTasks]
(	
	-- Add the parameters for the function here
)
RETURNS @vysl TABLE
(
	[id] int,
	[name] nvarchar(200),
	[red] int,
	[yellow] int,
	[green] int,
	[active] int,
	[is_working] int,
	[priority] bit
) 
AS
begin
	declare @location int, @name nvarchar(200),@red int=0, @yellow int=0, @green int=0, 
			@active int=0, @is_working int=0, @priority bit
	declare @tmpTable table(locationID int, name nvarchar(200))

	insert into @tmpTable
		Select id_location, name from view_Location

	while(1=1)
	begin
		set @location= null

		select top(1) @location=locationID, @name=name from @tmpTable

		if(@location is null)
			break;

		Select @red=red, @yellow=yellow, @green=green, @active=active, @is_working=is_working, @priority=priority 
		from fun_getTaskCountByLocation(@location)

		insert into @vysl
			select @location, @name, @red, @yellow, @green, @active, @is_working, @priority

		DELETE top(1) from @tmpTable
	end
	return
end