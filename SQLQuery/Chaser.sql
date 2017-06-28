----------------Stored procedure---------------------
						--------New-----

USE [CHASER]
GO
/****** Object:  StoredProcedure [dbo].[spGetTaskInitiatorList]    Script Date: 08/16/2015 12:16:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[spGetTaskAssignedToList]
as
begin
	Select distinct GC.AssignedToID,EI.EmployeeName 
	from vwMasterChaseStatus GC Left Join tblEmployeeInfo EI On GC.AssignedToID=EI.EmployeeID
	order by EI.EmployeeName
end




						------------Modified---------


USE [CHASER]
GO
/****** Object:  StoredProcedure [dbo].[spRptGeneratedChase]    Script Date: 08/16/2015 13:01:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec [spRptGeneratedChase] 'CAT-00000005','N\A','N\A','Assigned','N\A','N\A','N\A'

ALTER proc [dbo].[spRptGeneratedChase]
@CategoryID nvarchar(50),
@SubCategoryID nvarchar(50),
@ItemID nvarchar(50),
@ChaseDefinitionID nvarchar(50),
@ChaseStatus nvarchar(50),
@PriorityID nvarchar(50),
@ULCBranchID nvarchar(50),
@AssignedToID nvarchar(50),
@FinalStatus nvarchar(50),
@DateFrom datetime,
@DateTo datetime
as
begin

	Declare @PriorityIDParam as nvarchar(50) Set @PriorityIDParam = ''
	Declare @ULCBranchIDParam as nvarchar(50) Set @ULCBranchIDParam = ''
	Declare @ChaseStatusParam as nvarchar(50) Set @ChaseStatusParam = ''
	Declare @CategoryIDParam as nvarchar(50) Set @CategoryIDParam= ''
	Declare @SubCategoryIDParam as nvarchar(50) Set @SubCategoryIDParam = ''
	Declare @ItemIDParam as nvarchar(50) Set @ItemIDParam = ''
	Declare @ChaseDefinitionIDParam as nvarchar(50) Set @ChaseDefinitionIDParam = ''
	Declare @AssignedToIDParam as nvarchar(50) Set @AssignedToIDParam = ''
	Declare @FinalStatusParam as nvarchar(50) Set @FinalStatusParam = ''
	if @DateFrom ='1/1/1753 12:00:00 AM' 
	begin 
	Set @DateFrom = null 
	End
	
	Else
	begin
	SET @DateFrom=Convert(nvarchar,@DateFrom,101) + ' 12:00:01 AM'
	End
	if @DateTo='12/31/9999 11:59:59 PM'
	begin 
	Set @DateTo=null
	
	End
	ELSE
	begin
	Set @DateTo = Convert(nvarchar,@DateTo,101) + ' 11:59:01 PM'
	 END
	 
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

	if @ChaseDefinitionID = 'N\A'
		Set @ChaseDefinitionIDParam = '%'
	else
		Set @ChaseDefinitionIDParam = '%'+ @ChaseDefinitionID +'%'

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
	
	if @AssignedToID = 'N\A'
		Set @AssignedToIDParam = '%'
	else
		Set @AssignedToIDParam = '%'+ @AssignedToID +'%'


	if @FinalStatus = 'N\A'
		Set @FinalStatusParam = '%'
	else
		Set @FinalStatusParam = '%'+ @FinalStatus +'%'

	Select * from vwMasterChaseStatus MC Where 
	MC.PriorityID like @PriorityIDParam
	And (MC.CategoryID like @CategoryIDParam or MC.CategoryID is null)
	And (MC.SubCategoryID like @SubCategoryIDParam or MC.SubCategoryID is null )
	And (MC.ItemID like @ItemIDParam or MC.ItemID is null)
	And (MC.ChaseDefinitionID like @ChaseDefinitionIDParam or MC.ChaseDefinitionID is null)
	And (MC.ULCBranchID like @ULCBranchIDParam Or MC.ULCBranchID Is NULL)
	And (MC.ChaseStatus like @ChaseStatusParam Or MC.ChaseStatus Is NULL)
	And (MC.FinalStatus like @FinalStatusParam or MC.FinalStatus is null)
	AND (MC.AssignedToID like @AssignedToIDParam or MC.AssignedToID is null)
	AND	(
	((MC.InitiationDate>=@DateFrom OR @DateFrom IS NULL) AND(MC.InitiationDate<=@DateTo OR @DateTo IS NULL))
        )
	order by MC.InitiationDate
end


-------------------------SpEnd-----------



-------------------View----------------------

					----------New----------
					
					
					----------Modified------
					
					
					Alter View dbo.vwMasterChaseStatus
with schemabinding
as 

SELECT     GC.GeneratedChaseID, RIGHT(GC.MasterChaseID, 6) AS Sequence, CD.ChaseDefinitionID, GC.MasterChaseID, CD.CategoryID, C.CategoryName AS Category, 
                      CD.SubCategoryID, SC.SubCategory, CD.ItemID, I.ItemName AS Item, dbo.fnGetEmpNameByID(GC.ContactPersonID) AS ContactPerson, GC.PriorityID, P.Timing, 
                      P.PriorityText, CD.ChaseName, GC.InitiatorID, dbo.fnGetEmpNameByID(GC.InitiatorID) AS Initiator, GC.InitiatorRemarks, GC.InitiationDate, 
                      dbo.fnGetEmpNameByID(GC.AssignedToID) AS AssignedTo, GC.AssignedToID, dbo.fnGetLatestInitiationTime(GC.GeneratedChaseID) AS EndTime, 
                      dbo.fnGetLatestChaseStatus(GC.GeneratedChaseID) AS ChaseStatus, ISNULL(GC.FinalStatus, N'N\A') AS FinalStatus, GC.ULCBranchID, UB.ULCBranchName, 
                      ISNULL(GC.Description, dbo.fnGetChaseInputValuesDesc(GC.MasterChaseID)) AS Description, GC.EntryDate, ISNULL(GC.AssignmentHistory, 
                      dbo.fnGetChaseHistoryByGenChaseID(GC.MasterChaseID)) AS AssignmentHistory, dbo.fnGetLastAssignedPerson(GC.MasterChaseID) AS LastAssignedPerson, 
                      dbo.fnGetLastActionDate(GC.MasterChaseID) AS LastActionDate, dbo.fnCurrentAssignee(GC.MasterChaseID) AS CurrentAssignee
FROM         dbo.tblGeneratedChase AS GC LEFT OUTER JOIN
                      dbo.tblChaseDefinition AS CD ON GC.ChaseDefinitionID = CD.ChaseDefinitionID LEFT OUTER JOIN
                      dbo.tblPriority AS P ON GC.PriorityID = P.PriorityID LEFT OUTER JOIN
                      dbo.tblCategory AS C ON CD.CategoryID = C.CategoryID LEFT OUTER JOIN
                      dbo.tblSubCategory AS SC ON CD.SubCategoryID = SC.SubCategoryID LEFT OUTER JOIN
                      dbo.tblItems AS I ON CD.ItemID = I.ItemID LEFT OUTER JOIN
                      dbo.tblULCBranch AS UB ON GC.ULCBranchID = UB.ULCBranchID
WHERE     (GC.GeneratedChaseID = GC.MasterChaseID)
					
------------view End-------------------------					


--------------------Function-------------

USE [CHASER]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetLastAssignedPerson]    Script Date: 08/16/2015 16:35:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Alter function [dbo].[fnGetLastActionDate](@MasterChaseID nvarchar(50))
returns DateTime
WITH SCHEMABINDING
as
begin
	
	Declare @LastActionDate as datetime
	 

	if exists(Select 1 from dbo.tblGeneratedChase Where MasterChaseID=@MasterChaseID and IsTerminated = 1)
	begin
		Select @LastActionDate = MAX(TerminationDate) from dbo.tblGeneratedChase Where MasterChaseID=@MasterChaseID
	end
	else
	begin	
		Select @LastActionDate = MAX(InitiationDate) from dbo.tblGeneratedChase Where MasterChaseID=@MasterChaseID
	end
	--order by InitiationDate desc

	 

	return @LastActionDate

end

--------------EndFunction---------------