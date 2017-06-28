Imports System.Net.Mail
Imports System.Data

Partial Class frmAssignedChase
    Inherits System.Web.UI.Page

    Dim GenChaseData As New clsGeneratedChaseDataAccess()
    Dim ChaseNoteData As New clsChaseNotesDataAccess()
    Dim ItemData As New clsItems()
    Dim PriorityData As New clsPriority()
    Dim ULCBranchData As New clsULCBranch()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            GetPriorityList()
            GetAllULCBranch()
            GetCategoryList()
            'GetAllAssignedByChases(Session("EmployeeID"))
            btnAddNotes.Enabled = False
        End If
    End Sub

    Protected Sub GetCategoryList()
        drpCategoryList.DataTextField = "CategoryName"
        drpCategoryList.DataValueField = "CategoryID"
        drpCategoryList.DataSource = ItemData.fnGetActiveCategoryList()
        drpCategoryList.DataBind()

        Dim A As New ListItem
        A.Text = "--Select Category--"
        A.Value = "N\A"
        drpCategoryList.Items.Insert(0, A)
    End Sub

    Protected Sub GetPriorityList()
        drpPriority.DataTextField = "PriorityText"
        drpPriority.DataValueField = "PriorityID"
        drpPriority.DataSource = PriorityData.fnGetActivePriorityList()
        drpPriority.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpPriority.Items.Insert(0, A)

    End Sub

    Protected Sub GetAllULCBranch()
        drpULCBranchList.DataTextField = "ULCBranchName"
        drpULCBranchList.DataValueField = "ULCBranchID"
        drpULCBranchList.DataSource = ULCBranchData.fnGetULCBranch()
        drpULCBranchList.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpULCBranchList.Items.Insert(0, A)

    End Sub

    Protected Sub GetSubCategoryListByCategory(ByVal CategoryID As String)
        drpSubCategoryList.DataTextField = "SubCategory"
        drpSubCategoryList.DataValueField = "SubCategoryID"
        drpSubCategoryList.DataSource = ItemData.fnGetActiveSubCatListByCategory(CategoryID)
        drpSubCategoryList.DataBind()

        Dim A As New ListItem
        A.Text = "--Select Sub-Category--"
        A.Value = "N\A"
        drpSubCategoryList.Items.Insert(0, A)
    End Sub

    Protected Sub GetItemsBySubCategory(ByVal SubCategoryID As String)
        drpItemList.DataTextField = "ItemName"
        drpItemList.DataValueField = "ItemID"
        drpItemList.DataSource = ItemData.fnGetItemsBySubCategory(SubCategoryID)
        drpItemList.DataBind()

        Dim A As New ListItem
        A.Text = "--Select Items--"
        A.Value = "N\A"
        drpItemList.Items.Insert(0, A)
    End Sub

    Protected Sub drpSubCategoryList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpSubCategoryList.SelectedIndexChanged
        GetItemsBySubCategory(drpSubCategoryList.SelectedValue)
    End Sub

    Protected Sub drpCategoryList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpCategoryList.SelectedIndexChanged
        GetSubCategoryListByCategory(drpCategoryList.SelectedValue)
        drpItemList.DataSource = ""
        drpItemList.DataBind()
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

            '  folder = Server.MapPath("~/Attachments/")
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

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
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

    Protected Sub grdChaserReportDetails_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdChaserReportDetails.RowDataBound
        Dim lblFinalStatus As New Label()
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Cells(6).ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()
            e.Row.Cells(7).ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()
            e.Row.Cells(8).ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()
            e.Row.Cells(9).ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()
            e.Row.Cells(10).ToolTip = TryCast(e.Row.DataItem, DataRowView)("AssignmentHistory").ToString()
            e.Row.Cells(11).ToolTip = TryCast(e.Row.DataItem, DataRowView)("AssignmentHistory").ToString()
            e.Row.Cells(12).ToolTip = TryCast(e.Row.DataItem, DataRowView)("AssignmentHistory").ToString()

            lblFinalStatus = e.Row.FindControl("lblFinalStatus")

            If lblFinalStatus.Text = "Open" Then
                e.Row.Cells(6).ForeColor = Drawing.Color.Green
            ElseIf lblFinalStatus.Text = "Overdue" Then
                e.Row.Font.Bold = True
                e.Row.Cells(6).ForeColor = Drawing.Color.Red
            ElseIf lblFinalStatus.Text = "Closed" Then
                e.Row.Cells(6).ForeColor = Drawing.Color.Orange
            End If

        End If

    End Sub

    Protected Sub btnShowChaseList_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowChaseList.Click
        Dim GenChase As New clsGeneratedChase()

        Try
            GenChase.CategoryID = drpCategoryList.SelectedValue

            If drpSubCategoryList.Items.Count = 0 Then
                GenChase.SubCategoryID = "N\A"
            Else
                GenChase.SubCategoryID = drpSubCategoryList.SelectedValue
            End If

            If drpItemList.Items.Count = 0 Then
                GenChase.ItemID = "N\A"
            Else
                GenChase.ItemID = drpItemList.SelectedValue
            End If

            GenChase.ChaseStatus = drpChaseStatus.SelectedValue
            GenChase.PriorityID = drpPriority.SelectedValue
            GenChase.ULCBranchID = drpULCBranchList.SelectedValue
            GenChase.FinalStatus = drpFinalStatus.SelectedValue
            GenChase.InitiatorID = Session("EmployeeID")

            grdChaserReportDetails.DataSource = GenChaseData.fnGetAssignedChase(GenChase)
            grdChaserReportDetails.DataBind()

            If grdChaserReportDetails.Rows.Count <> 0 Then
                Dim Str As String = grdChaserReportDetails.HeaderRow.Cells(6).Text
                grdChaserReportDetails.HeaderRow.Cells(6).Text = Str + " (" + grdChaserReportDetails.Rows.Count.ToString() + "*)"
            End If
           

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub
End Class
