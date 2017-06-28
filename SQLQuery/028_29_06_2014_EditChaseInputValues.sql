

Select * from tblChaseInputValues

alter proc spGetInputValuesByGenChase
@GeneratedChaseID nvarchar(50)
as
begin

	Select CL.ControlType,
	Case CL.ControlID When '' Then CL.GroupControlID Else CL.ControlID End as 'ControlID',
	CI.Value + CI.AdditionalValue as 'Value'
	from tblChaseInputValues CI Left Join tblControlList CL On CI.ControlListID=CL.ControlListID
	Where CI.GeneratedChaseID=@GeneratedChaseID And CL.IsActive=1

end

exec spGetInputValuesByGenChase 'GEN-C-00000042'

Select distinct ControlType  from tblControlList


Select * from tblChaseInputValues