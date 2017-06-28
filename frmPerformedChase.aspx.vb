Imports System.Data
Imports System.Net.Mail

Partial Class frmPerformedChase
    Inherits System.Web.UI.Page

    Dim GenChaseData As New clsGeneratedChaseDataAccess()
    Dim ChaseNoteData As New clsChaseNotesDataAccess()

    

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            'GetPerformedChase(Session("EmployeeID"))
            btnAddNotes.Enabled = False
        End If
    End Sub

    'Protected Sub GetPerformedChase(ByVal AssignedToID As String)
    '    grdChaserReportDetails.DataSource = GenChaseData.fnGetPerformedChase(AssignedToID)
    '    grdChaserReportDetails.DataBind()
    'End Sub

    Protected Sub GetPerformedChase(ByVal AssignedToID As String, ByVal DateFrom As datetime, ByVal DateTo As datetime)
        grdChaserReportDetails.DataSource = GenChaseData.fnGetPerformedChase(AssignedToID, DateFrom, DateTo)
        grdChaserReportDetails.DataBind()
    End Sub

    Protected Sub grdChaserReportDetails_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdChaserReportDetails.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()
        End If
    End Sub

    Protected Sub grdChaserReportDetails_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdChaserReportDetails.SelectedIndexChanged
        Dim lblGeneratedChaseID, lblMasterChaseID, lblChaseDefinitionID As New Label
        lblGeneratedChaseID = grdChaserReportDetails.SelectedRow.FindControl("lblGeneratedChaseID")
        lblMasterChaseID = grdChaserReportDetails.SelectedRow.FindControl("lblMasterChaseID")
        lblChaseDefinitionID = grdChaserReportDetails.SelectedRow.FindControl("lblChaseDefinitionID")

        hdFldGeneratedChaseID.Value = lblGeneratedChaseID.Text
        hdFldMasterChaseID.Value = lblMasterChaseID.Text

        GetChaseNotes(hdFldGeneratedChaseID.Value)

        btnAddNotes.Enabled = True
    End Sub

    Protected Sub GetChaseNotes(ByVal MasterChaseID As String)
        grdNotesByChase.DataSource = ChaseNoteData.fnGetMasterChaseWiseNotes(MasterChaseID)
        grdNotesByChase.DataBind()
    End Sub


    Protected Sub btnSubmitNote_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmitNote.Click

        Dim Notes As New clsChaseNotes()
        Dim MailProp As New clsMailProperty()
        Dim folder As String = ""
        Dim DocExt As String = ""
        Dim DocFullName As String = ""
        Dim DocPrefix As String = ""
        Dim FileSize As Integer = 0
        Dim DocFileName As String = ""


        Notes.MasterChaseID = hdFldMasterChaseID.Value
        Notes.GeneratedChaseID = hdFldGeneratedChaseID.Value
        Notes.Notes = txtNotes.Text


        If flupNoteAttachment.HasFile Then

            ' folder = Server.MapPath("~/Attachments/")
            folder = ConfigurationManager.AppSettings("InputChaserFile")
            FileSize = flupNoteAttachment.PostedFile.ContentLength()
            If FileSize > 4194304 Then
                MessageBox("File size should be within 4MB")
                Exit Sub
            End If

            DocExt = System.IO.Path.GetExtension(flupNoteAttachment.FileName)
            DocFileName = "Chase_Note_" & DateTime.Now.ToString("ddMMyyHHmmss") & DocExt
            DocFullName = folder & DocFileName
            flupNoteAttachment.SaveAs(DocFullName)
            Notes.Attachments = DocFileName
        Else
            Notes.Attachments = ""
        End If

        Notes.EntryBy = Session("UserID")


        Dim result As clsResult = ChaseNoteData.fnInsertChaseNotes(Notes)

        If result.Success = True Then
            ClearNotes()
            MailProp = ChaseNoteData.fnChaseAddNotesMail(Notes)
            SendMail(MailProp)
        End If

        MessageBox(result.Message)

    End Sub

    Protected Sub ClearNotes()
        txtNotes.Text = ""
    End Sub

    Protected Sub SendMail(ByVal MailProp As clsMailProperty)
        Dim mail As New Net.Mail.MailMessage()
        Dim TestArray() As String

        Try
            mail.From = New MailAddress(MailProp.MailFrom)

            TestArray = Split(MailProp.MailTo, ";")
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    mail.To.Add(TestArray(i))
                End If
            Next
            TestArray = Nothing

            TestArray = Split(MailProp.MailCC, ";")
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    mail.CC.Add(TestArray(i))
                End If
            Next
            TestArray = Nothing

            TestArray = Split(MailProp.MailBCC, ";")
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    mail.Bcc.Add(TestArray(i))
                End If
            Next
            TestArray = Nothing

            mail.Subject = MailProp.MailSubject
            mail.Body = MailProp.MailBody
            mail.IsBodyHtml = True
            mail.Priority = MailPriority.High
            Dim smtp As New SmtpClient("192.168.1.232", 25)
            smtp.Send(mail)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub


    Protected Sub btnPerformedChase_Click(sender As Object, e As System.EventArgs) Handles btnPerformedChase.Click
        Try
            Dim DateFrom, DateTo As DateTime
            DateFrom = CType(txtDateFrom.Text.Trim(), Date)
            DateTo = CType(txtDateTo.Text.Trim(), Date)

            If DateFrom > DateTo Then
                MessageBox("Date From Can not Greater Than Date To")
                Exit Sub
            End If

            GetPerformedChase(Session("EmployeeID"), DateFrom, DateTo)


        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub
End Class
