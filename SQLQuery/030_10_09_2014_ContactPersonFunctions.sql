

Create function fnGetContactPersonIDByMasterChaseID(@MasterChaseID as nvarchar(50))
returns nvarchar(50)
as
begin
	Declare @ContactPersonID as nvarchar(50) Set @ContactPersonID = ''
	Select @ContactPersonID = ContactPersonID from tblGeneratedChase Where GeneratedChaseID=@MasterChaseID
	return @ContactPersonID
end

GO

Create function fnGetMasterChaseID(@GeneratedChaseID as nvarchar(50))
returns nvarchar(50)
as
begin
	Declare @MasterChaseID as nvarchar(50) Set @MasterChaseID = ''
	Select @MasterChaseID = MasterChaseID from tblGeneratedChase Where GeneratedChaseID=@GeneratedChaseID
	return @MasterChaseID
end

Select * from tblGeneratedChase Where GeneratedChaseID <> MasterChaseID

select dbo.fnGetMasterChaseID('GEN-C-00000090')