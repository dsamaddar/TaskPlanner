Imports System.Net.Mail
Imports System.Data

Partial Class frmGenUsrWiseChase
    Inherits System.Web.UI.Page

    Dim ChaseInputValueData As New clsChaseInputValuesDataAccess()
    Dim GenChaseData As New clsGeneratedChaseDataAccess()
    Dim EmpInfoData As New clsEmployeeInfoDataAccess()
    Dim ChaseNoteData As New clsChaseNotesDataAccess()
    Dim IntRepData As New clsInterestedReps()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("EmployeeID") = "" Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then

            If Session("EmployeeID") = "" Then
                Response.Redirect("Login.aspx")
            End If

            ShowAssignedChase(Session("EmployeeID"))
            btnViewChaseDetails.Enabled = False
            btnAddNotes.Enabled = False
        End If
    End Sub

    Protected Sub ShowUsersListByChaseDef(ByVal ChaseDefinitionID As String)
        drpEmployeeList.DataTextField = "EmployeeName"
        drpEmployeeList.DataValueField = "EmployeeID"
        drpEmployeeList.DataSource = IntRepData.fnGetInterestedRepsByChaseDefID(ChaseDefinitionID, "Representative")
        drpEmployeeList.DataBind()
    End Sub

    Protected Sub ShowAssignedChase(ByVal EmployeeID As String)
        grdAssignedChase.DataSource = GenChaseData.fnGetAssignedChaseByUser(EmployeeID)
        grdAssignedChase.DataBind()
    End Sub

    Protected Sub ShowChaseInputValues(ByVal GeneratedChaseID As String)
        grdChaseInputValues.DataSource = ChaseInputValueData.fnGetChaseInputvalues(GeneratedChaseID)
        grdChaseInputValues.DataBind()
    End Sub

    Protected Sub ShowGridValueInHTMLFormat()
        Dim lblValue As New Label
        For Each row As GridViewRow In grdChaseInputValues.Rows
            lblValue = row.FindControl("lblValue")
            lblValue.Text = Server.HtmlDecode(lblValue.Text)
        Next
    End Sub

    Protected Sub ShowChaseHistory(ByVal GeneratedChaseID As String)
        grdChaseFeedBackHistory.DataSource = GenChaseData.fnGetChaseHistoryByGenChaseID(GeneratedChaseID)
        grdChaseFeedBackHistory.DataBind()
    End Sub

    Protected Sub grdAssignedChase_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdAssignedChase.SelectedIndexChanged
        Dim lblGeneratedChaseID, lblMasterChaseID, lblChaseDefinitionID As New Label
        lblGeneratedChaseID = grdAssignedChase.SelectedRow.FindControl("lblGeneratedChaseID")
        lblMasterChaseID = grdAssignedChase.SelectedRow.FindControl("lblMasterChaseID")
        lblChaseDefinitionID = grdAssignedChase.SelectedRow.FindControl("lblChaseDefinitionID")

        hdFldGeneratedChaseID.Value = lblGeneratedChaseID.Text
        hdFldMasterChaseID.Value = lblMasterChaseID.Text

        ShowChaseInputValues(hdFldMasterChaseID.Value)
        ShowChaseHistory(hdFldMasterChaseID.Value)
        GetChaseNotes(hdFldGeneratedChaseID.Value)
        ShowUsersListByChaseDef(lblChaseDefinitionID.Text)
        btnViewChaseDetails.Enabled = True
        btnAddNotes.Enabled = True
    End Sub

    Protected Sub GetChaseNotes(ByVal MasterChaseID As String)
        grdNotesByChase.DataSource = ChaseNoteData.fnGetMasterChaseWiseNotes(MasterChaseID)
        grdNotesByChase.DataBind()
    End Sub

    Protected Sub ClearForm()

        txtRemarks.Text = ""
        drpEmployeeList.SelectedIndex = -1
        drpChaseProgress.SelectedIndex = -1

        grdChaseFeedBackHistory.DataSource = ""
        grdChaseFeedBackHistory.DataBind()

        grdChaseInputValues.DataSource = ""
        grdChaseInputValues.DataBind()

        hdFldGeneratedChaseID.Value = ""

        ShowAssignedChase(Session("EmployeeID"))

        btnViewChaseDetails.Enabled = False

        grdAssignedChase.SelectedIndex = -1

    End Sub

    Protected Sub btnTerminateChase_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTerminateChase.Click
        Dim GenChase As New clsGeneratedChase()
        Dim result As New clsResult()
        Dim MailProp As New clsMailProperty()

        Dim folder As String = ""
        Dim DocExt As String = ""
        Dim DocFullName As String = ""
        Dim DocPrefix As String = ""
        Dim FileSize As Integer = 0
        Dim DocFileName As String = ""
        Dim DocumentCategory As String = "Document"

        If Trim(txtRemarks.Text) = "" Then
            MessageBox("Remarks Required")
            Exit Sub
        End If

        GenChase.MasterChaseID = hdFldMasterChaseID.Value
        GenChase.ParentChaseID = hdFldGeneratedChaseID.Value
        GenChase.InitiatorID = Session("EmployeeID")
        GenChase.AssignedToID = drpEmployeeList.SelectedValue
        GenChase.Remarks = txtRemarks.Text
        GenChase.ChaseProgress = drpChaseProgress.SelectedValue
        GenChase.ChaseStatus = "Terminated"
        GenChase.IsTerminated = True
        GenChase.EntryBy = Session("UserID")

        If flupChaserAssignment.HasFile Then

            'folder = Server.MapPath("~/Attachments/")
            folder = ConfigurationManager.AppSettings("InputChaserFile")

            FileSize = flupChaserAssignment.PostedFile.ContentLength()
            If FileSize > 4194304 Then
                MessageBox("File size should be within 4MB")
                Exit Sub
            End If

            DocExt = System.IO.Path.GetExtension(flupChaserAssignment.FileName)
            DocFileName = "Chase_Doc_" & DateTime.Now.ToString("ddMMyyHHmmss") & DocExt
            DocFullName = folder & DocFileName
            flupChaserAssignment.SaveAs(DocFullName)
            GenChase.UploadedFile = DocFileName
        Else
            GenChase.UploadedFile = ""
        End If

        result = GenChaseData.fnUpdateChaseStatus(GenChase)

        If result.Success = True Then
            ClearForm()
            '' Send Chase Forward Mail
            MailProp = GenChaseData.fnChaseTerminateMail(GenChase)
            SendMail(MailProp)
            ShowAssignedChase(Session("EmployeeID"))
        End If

        MessageBox(result.Message)

    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnForwardChase_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnForwardChase.Click
        Dim GenChase As New clsGeneratedChase()
        Dim result As New clsResult()
        Dim MailProp As New clsMailProperty()

        Dim folder As String = ""
        Dim DocExt As String = ""
        Dim DocFullName As String = ""
        Dim DocPrefix As String = ""
        Dim FileSize As Integer = 0
        Dim DocFileName As String = ""
        Dim DocumentCategory As String = "Document"

        If Trim(txtRemarks.Text) = "" Then
            MessageBox("Remarks Required")
            Exit Sub
        End If

        Try
            GenChase.MasterChaseID = hdFldMasterChaseID.Value
            GenChase.ParentChaseID = hdFldGeneratedChaseID.Value
            GenChase.InitiatorID = Session("EmployeeID")
            GenChase.AssignedToID = drpEmployeeList.SelectedValue
            GenChase.Remarks = txtRemarks.Text
            GenChase.ChaseProgress = drpChaseProgress.SelectedValue
            GenChase.ChaseStatus = "Forwarded"
            GenChase.IsTerminated = False
            GenChase.EntryBy = Session("UserID")

            If flupChaserAssignment.HasFile Then

                'folder = Server.MapPath("~/Attachments/")
                folder = ConfigurationManager.AppSettings("InputChaserFile")
                FileSize = flupChaserAssignment.PostedFile.ContentLength()
                If FileSize > 4194304 Then
                    MessageBox("File size should be within 4MB")
                    Exit Sub
                End If

                DocExt = System.IO.Path.GetExtension(flupChaserAssignment.FileName)
                DocFileName = "Chase_Doc_" & DateTime.Now.ToString("ddMMyyHHmmss") & DocExt
                DocFullName = folder & DocFileName
                flupChaserAssignment.SaveAs(DocFullName)
                GenChase.UploadedFile = DocFileName
            Else
                GenChase.UploadedFile = ""
            End If

            result = GenChaseData.fnUpdateChaseStatus(GenChase)

            If result.Success = True Then
                ClearForm()
                '' Send Chase Forward Mail
                MailProp = GenChaseData.fnChaseForwardMail(GenChase)
                SendMail(MailProp)
                ShowAssignedChase(Session("EmployeeID"))
            End If

            MessageBox(result.Message)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

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

            If MailProp.Attachment <> "" Then
                Dim at As Attachment = New Attachment(ConfigurationManager.AppSettings("OutputChaserFile") + MailProp.Attachment)
                mail.Attachments.Add(at)
            End If

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

            'folder = Server.MapPath("~/Attachments/")
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
            ShowAssignedChase(Session("EmployeeID"))
        End If

        MessageBox(result.Message)

    End Sub

    Protected Sub ClearNotes()
        txtNotes.Text = ""
    End Sub

    Protected Sub grdAssignedChase_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdAssignedChase.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()
        End If
    End Sub
End Class
