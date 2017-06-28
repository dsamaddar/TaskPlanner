

exec spGetAssignedChase  'N\A','N\A','N\A','N\A','N\A','N\A','N\A','EMP-00000020'

alter proc spGetAssignedChase
@CategoryID nvarchar(50),
@SubCategoryID nvarchar(50),
@ItemID nvarchar(50),
@ChaseStatus nvarchar(50),
@PriorityID nvarchar(50),
@ULCBranchID nvarchar(50),
@FinalStatus nvarchar(50),
@InitiatorID nvarchar(50)
as
begin

	Declare @PriorityIDParam as nvarchar(50) Set @PriorityIDParam = ''
	Declare @ULCBranchIDParam as nvarchar(50) Set @ULCBranchIDParam = ''
	Declare @ChaseStatusParam as nvarchar(50) Set @ChaseStatusParam = ''
	Declare @CategoryIDParam as nvarchar(50) Set @CategoryIDParam= ''
	Declare @SubCategoryIDParam as nvarchar(50) Set @SubCategoryIDParam = ''
	Declare @ItemIDParam as nvarchar(50) Set @ItemIDParam = ''
	Declare @FinalStatusParam as nvarchar(50) Set @FinalStatusParam = ''

	if @CategoryID = 'N\A'
		Set @CategoryIDParam = '%'
	else
		Set @CategoryIDParam = '%'+ @CategoryID +'%'

	if @SubCategoryID = 'N\A'
		Set @SubCategoryIDParam = '%'
	else
		Set @SubCategoryIDParam = '%'+ @SubCategoryID +'%'

	if @ItemID = 'N\A'
		Set @ItemIDParam = '%'
	else
		Set @ItemIDParam = '%'+ @ItemID +'%'

	if @ChaseStatus = 'N\A'
		Set @ChaseStatusParam = '%'
	else
		Set @ChaseStatusParam = '%'+ @ChaseStatus +'%'

	if @PriorityID='N\A'
		Set @PriorityIDParam = '%'
	else
		Set @PriorityIDParam = '%'+ @PriorityID +'%'

	if @ULCBranchID = 'N\A'
		Set @ULCBranchIDParam = '%'
	else
		Set @ULCBranchIDParam = '%'+ @ULCBranchID +'%'

	if @FinalStatus = 'N\A'
		Set @FinalStatusParam = '%'
	else
		Set @FinalStatusParam = '%'+ @FinalStatus +'%'

	Select * from vwMasterChaseStatus MC Where 
	MC.InitiatorID=@InitiatorID 
	And MC.PriorityID like @PriorityIDParam
	And (MC.CategoryID like @CategoryIDParam or MC.CategoryID is null)
	And (MC.SubCategoryID like @SubCategoryIDParam or MC.SubCategoryID is null )
	And (MC.ItemID like @ItemIDParam or MC.ItemID is null)
	And MC.ULCBranchID like @ULCBranchIDParam
	And MC.ChaseStatus like @ChaseStatusParam
	And (MC.FinalStatus like @FinalStatusParam or MC.FinalStatus is null)
	order by MC.InitiationDate
end



GO

Create proc spGetPerformedChase
@AssignedToID nvarchar(50)
as
begin
	Select * from vwAllChaseStatus Where AssignedToID=@AssignedToID
end

Select * from tblGeneratedChase