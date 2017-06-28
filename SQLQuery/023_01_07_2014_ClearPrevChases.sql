
/*
delete from tblGeneratedChase Where InitiatorID = 'EMP-00000328'

delete from tblChaseInputValues Where GeneratedChaseID In (
Select GeneratedChaseID from tblGeneratedChase Where InitiatorID = 'EMP-00000328'
)

 delete from tblChaseNotes Where GeneratedChaseID in (
Select GeneratedChaseID from tblGeneratedChase Where InitiatorID = 'EMP-00000328'
)
*/
