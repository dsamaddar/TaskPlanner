/*

  -- Variable that will contain the name of the table
   declare @mytable varchar(30)
   -- Creates a temp table name
   select @mytable ='TEMP'+ CONVERT(char(12), GETDATE(), 14)
   print @mytable

   -- Table cannot be created with the character  ":"  in it
   -- The following while loop strips off the colon
   declare  @pos int
   select   @pos = charindex(':',@mytable)

   while @pos > 0
      begin
           select @mytable = substring(@mytable,1,@pos - 1)   +
                             substring(@mytable,@pos + 1,30-@pos )
           select @pos = charindex(':',@mytable)
      end
   print 'Name without colon is :'
   print @mytable

   -- Create the temporary table
   execute ('create table '+ @mytable +
             '(col1 int)' )

   -- Insert two rows in the table
   execute ('insert into ' + @mytable +
                 ' values(1)')

   execute ('insert into ' + @mytable +
                 ' values(2)')

   -- Select from the temporary table
   execute ('select col1 from ' + @mytable )
   -- Drop the temporary table
   execute ('drop table ' + @mytable)


*/


Create table #MyTbl (
GeneratedChaseID nvarchar(50)
);

Declare @RptHeadTbl table (
RptHead nvarchar(200),
Taken Bit Default 0
);

Insert into @RptHeadTbl(RptHead)
Select DISTINCT ReportingHead From tblMasterReportField MRF Left Join tblChaseInputValues CIV 
ON MRF.ControlListID=CIV.ControlListID
Where MasterReportID = 'MSTR-00000004' And CIV.ReportingHead is not null

Declare @RCount as int Set @RCount=0
Declare @RNCount As int Set @RNCount = 0
Declare @RptHead as nvarchar(200) Set @RptHead = ''
Declare @ActualHead as nvarchar(200) Set @ActualHead = ''
DECLARE @Msql nvarchar(4000)

Select @RNCount = count(*) from @RptHeadTbl

While @RCount < @RNCount
begin

	Select top 1 @RptHead='['+RptHead+']',@ActualHead=RptHead from @RptHeadTbl Where Taken=0
	
	Set @Msql = 'alter table #MyTbl add ' + @RptHead + ' nvarchar(max); '

	EXEC sp_executesql @Msql
	
	update @RptHeadTbl Set Taken=1 Where RptHead=@ActualHead
	Set @RptHead = ''
	Set @ActualHead = ''
	Set @Msql = ''
	Set @RCount = @RCount + 1
end

Select * from #MyTbl

Drop table #MyTbl

