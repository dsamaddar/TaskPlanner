Imports System.Data
Imports AjaxControlToolkit
Imports System.Net.Mail

Partial Class GenerateChase_frmGenerateChase
    Inherits System.Web.UI.Page

    Dim CtrlListData As New clsControlListDataAccess()
    Dim ChaseDefData As New clsChaseDefinitionDataAccess()
    Dim EmpInfoData As New clsEmployeeInfoDataAccess()
    Dim GenChaseData As New clsGeneratedChaseDataAccess()
    Dim ChaseInputValueData As New clsChaseInputValuesDataAccess()
    Dim VoiceCollData As New clsVoiceDataCollDataAccess()
    Dim IntRepData As New clsInterestedReps()
    Dim PriorityData As New clsPriority()
    Dim ULCBranchData As New clsULCBranch()

    Shared ControlCount As Integer = 0

    Protected Sub drpChaseList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpChaseList.SelectedIndexChanged
        Try
            If drpChaseList.SelectedValue = "N\A" Then
                MessageBox("Select Proper Chase From The List.")
                Exit Sub
            Else
                ShowEmpListByChase(drpChaseList.SelectedValue, "Representative")
                drpPriority.SelectedValue = ChaseDefData.fnGetPriorityByChaseDef(drpChaseList.SelectedValue)
            End If

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

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

    Protected Sub ShowEmpListByBranch(ByVal ULCBranchID As String)
        drpRequestFor.DataTextField = "EmployeeName"
        drpRequestFor.DataValueField = "EmployeeID"
        drpRequestFor.DataSource = EmpInfoData.fnGetBranchWiseEmpList(ULCBranchID)
        drpRequestFor.DataBind()
    End Sub

    Protected Sub ShowEmpListByChase(ByVal ChaseDefinitionID As String, ByVal InterestType As String)
        drpIntRepList.DataTextField = "EmployeeName"
        drpIntRepList.DataValueField = "EmployeeID"
        drpIntRepList.DataSource = IntRepData.fnGetInterestedRepsByChaseDefID(ChaseDefinitionID, InterestType)
        drpIntRepList.DataBind()
    End Sub

    Protected Sub GetPriorityList()
        drpPriority.DataTextField = "PriorityText"
        drpPriority.DataValueField = "PriorityID"
        drpPriority.DataSource = PriorityData.fnGetActivePriorityList()
        drpPriority.DataBind()
    End Sub

    Protected Sub ShowActiveChaseList(ByVal FacilityTypeID As String)
        drpChaseList.DataTextField = "ChaseName"
        drpChaseList.DataValueField = "ChaseDefinitionID"
        drpChaseList.DataSource = ChaseDefData.fnGetChaseDefListByFacilityType(FacilityTypeID)
        drpChaseList.DataBind()

        Dim A As New ListItem()
        A.Text = "N\A"
        A.Value = "N\A"
        drpChaseList.Items.Insert(0, A)
    End Sub

    Protected Sub GenerateControlFinal(ByVal ChaseDefinitionID As String)
        Dim CtrlList As ArrayList = New ArrayList
        Dim list As New List(Of clsControlList)
        Dim ctlList As New clsControlList()
        Dim tblDynamic As New Table
        Dim tRowInitial As New TableRow()
        Dim tRowEnd As New TableRow()

        Try
            '' Get All Controls ID
            CtrlList = CtrlListData.fnGetAllCtrlIDByChaseDefID(ChaseDefinitionID)

            tblDynamic.Rows.Add(tRowInitial)
            For Each citem As ListItem In CtrlList

                ControlCount += 1
                ctlList.ChaseDefinitionID = ChaseDefinitionID
                ctlList.ControlID = citem.Text
                list = CtrlListData.fnGetCtrlDetailsByChaseDefIDAndCtrlID(ctlList)

                If citem.Value = "RadioButtonList" Then
                    Dim tRow As New TableRow()

                    Dim tCell0 As New TableCell()
                    tCell0.Width = Unit.Pixel(20)
                    tRow.Cells.Add(tCell0)

                    Dim tCell As New TableCell()

                    Dim rdbtnList = New RadioButtonList()
                    rdbtnList.RepeatDirection = list(0).DataPresentationForm
                    rdbtnList.ID = list(0).GroupControlID

                    ' Create label For Control Text
                    Dim lbl As New Label()
                    lbl.Text = list(0).GroupControlLabelInfo + ":"
                    lbl.CssClass = "label"

                    ' Create label Required Field
                    Dim lblReq As New Label()
                    lblReq.Text = "*"
                    lblReq.CssClass = "RequiredLabel"

                    ' Add to cell.
                    tCell.Width = Unit.Pixel(200)
                    tCell.Controls.Add(lbl)
                    tCell.Controls.Add(lblReq)
                    tRow.Cells.Add(tCell)

                    Dim tCell2 As New TableCell()
                    For Each item As clsControlList In list
                        rdbtnList.Items.Add(item.ControlValue)
                    Next

                    tCell2.Width = Unit.Pixel(200)
                    tCell2.Controls.Add(rdbtnList)
                    tRow.Cells.Add(tCell2)

                    Dim reqFldVal As New RequiredFieldValidator()
                    reqFldVal.ID = "reqFldValDynamic" + ControlCount.ToString()
                    reqFldVal.ControlToValidate = rdbtnList.ID
                    reqFldVal.ValidationGroup = "CheckForm"
                    reqFldVal.ErrorMessage = "Required"
                    reqFldVal.Font.Size = "10"
                    reqFldVal.CssClass = "RequiredLabel"

                    Dim tCell3 As New TableCell()
                    tCell3.Controls.Add(reqFldVal)
                    tRow.Cells.Add(tCell3)
                    tblDynamic.Rows.Add(tRow)
                End If

                If citem.Value = "CheckBoxList" Then
                    Dim tRow As New TableRow()

                    Dim tCell0 As New TableCell()
                    tCell0.Width = Unit.Pixel(20)
                    tRow.Cells.Add(tCell0)

                    Dim tCell As New TableCell()

                    Dim CheckBoxList = New CheckBoxList()
                    CheckBoxList.RepeatDirection = list(0).DataPresentationForm
                    CheckBoxList.ID = list(0).GroupControlID

                    ' Create label For Control Text
                    Dim lbl As New Label()
                    lbl.Text = list(0).GroupControlLabelInfo + ":"
                    lbl.CssClass = "label"

                    ' Create label Required Field
                    Dim lblReq As New Label()
                    lblReq.Text = "*"
                    lblReq.CssClass = "RequiredLabel"

                    ' Add to cell.
                    tCell.Width = Unit.Pixel(200)
                    tCell.Controls.Add(lbl)
                    tCell.Controls.Add(lblReq)
                    tRow.Cells.Add(tCell)

                    Dim tCell2 As New TableCell()
                    For Each item As clsControlList In list
                        CheckBoxList.Items.Add(item.ControlValue)
                    Next


                    tCell2.Width = Unit.Pixel(200)
                    tCell2.Controls.Add(CheckBoxList)
                    ' tCell2.Controls.Add(reqFldVal)
                    tRow.Cells.Add(tCell2)

                    Dim tCell3 As New TableCell()
                    tRow.Cells.Add(tCell3)

                    tblDynamic.Rows.Add(tRow)
                End If

                If citem.Value = "DropDownList" Then
                    Dim tRow As New TableRow()

                    Dim tCell0 As New TableCell()
                    tCell0.Width = Unit.Pixel(20)
                    tRow.Cells.Add(tCell0)

                    Dim tCell As New TableCell()

                    Dim drpLst = New DropDownList()
                    drpLst.ID = list(0).GroupControlID

                    ' Create label For Control Text
                    Dim lbl As New Label()
                    lbl.Text = list(0).GroupControlLabelInfo + ":"
                    lbl.CssClass = "label"

                    ' Create label Required Field
                    Dim lblReq As New Label()
                    lblReq.Text = "*"
                    lblReq.CssClass = "RequiredLabel"

                    ' Add to cell.
                    tCell.Width = Unit.Pixel(200)
                    tCell.Controls.Add(lbl)
                    tCell.Controls.Add(lblReq)
                    tRow.Cells.Add(tCell)

                    Dim tCell2 As New TableCell()
                    For Each item As clsControlList In list
                        drpLst.Items.Add(item.ControlValue)
                    Next


                    tCell2.Width = Unit.Pixel(200)
                    tCell2.Controls.Add(drpLst)
                    ' tCell2.Controls.Add(reqFldVal)
                    tRow.Cells.Add(tCell2)

                    Dim tCell3 As New TableCell()
                    tRow.Cells.Add(tCell3)

                    tblDynamic.Rows.Add(tRow)
                End If

                If citem.Value = "TextBox" Then
                    Dim tRow As New TableRow()

                    Dim tCell0 As New TableCell()
                    tCell0.Width = Unit.Pixel(20)
                    tRow.Cells.Add(tCell0)

                    Dim tCell As New TableCell()

                    Dim TextBox As New TextBox()
                    TextBox.ID = list(0).ControlID

                    ' Create label For Control Text
                    Dim lbl As New Label()
                    lbl.Text = list(0).ControlLabelInfo + ":"
                    lbl.CssClass = "label"

                    ' Create label Required Field
                    Dim lblReq As New Label()
                    lblReq.Text = "*"
                    lblReq.CssClass = "RequiredLabel"

                    ' Add to cell.
                    tCell.Width = Unit.Pixel(200)
                    tCell.Controls.Add(lbl)
                    tCell.Controls.Add(lblReq)
                    tRow.Cells.Add(tCell)

                    Dim tCell2 As New TableCell()
                    TextBox.Text = list(0).ControlValue
                    If list(0).ValueSelectionType = "MultiValued" Then
                        TextBox.Width = Unit.Pixel(250)
                        TextBox.TextMode = TextBoxMode.MultiLine
                    Else
                        TextBox.Width = Unit.Pixel(200)
                    End If


                    tCell2.Width = Unit.Pixel(300)
                    tCell2.Controls.Add(TextBox)
                    tRow.Cells.Add(tCell2)

                    Dim tCell3 As New TableCell()
                    Dim reqFldVal As New RequiredFieldValidator()
                    reqFldVal.ID = "reqFldValDynamic" + ControlCount.ToString()
                    reqFldVal.ControlToValidate = TextBox.ID
                    reqFldVal.ValidationGroup = "CheckForm"
                    reqFldVal.ErrorMessage = "Required"
                    reqFldVal.Font.Size = "10"
                    reqFldVal.CssClass = "RequiredLabel"

                    tCell3.Controls.Add(reqFldVal)
                    tRow.Cells.Add(tCell3)
                    If list(0).DataType = "DateTime" Then
                        Dim calExtender As New CalendarExtender()
                        calExtender.TargetControlID = TextBox.ID
                        tCell2.Controls.Add(calExtender)
                    End If

                    tblDynamic.Rows.Add(tRow)

                End If

                If citem.Value = "Editor" Then
                    Dim tRow As New TableRow()

                    Dim tCell0 As New TableCell()
                    tCell0.Width = Unit.Pixel(20)
                    tRow.Cells.Add(tCell0)

                    Dim tCell As New TableCell()

                    Dim Editor As New HTMLEditor.Editor()
                    Editor.ID = list(0).ControlID

                    ' Create label For Control Text
                    Dim lbl As New Label()
                    lbl.Text = list(0).ControlLabelInfo + ":"
                    lbl.CssClass = "label"

                    ' Create label Required Field
                    Dim lblReq As New Label()
                    lblReq.Text = "*"
                    lblReq.CssClass = "RequiredLabel"

                    ' Add to cell.
                    tCell.Width = Unit.Pixel(200)
                    tCell.Controls.Add(lbl)
                    tCell.Controls.Add(lblReq)
                    tRow.Cells.Add(tCell)

                    Dim tCell2 As New TableCell()
                    Editor.Content = list(0).ControlValue
                    Editor.Width = Unit.Pixel(600)

                    tCell2.Width = Unit.Pixel(300)
                    tCell2.Controls.Add(Editor)
                    tRow.Cells.Add(tCell2)

                    Dim tCell3 As New TableCell()
                    Dim reqFldVal As New RequiredFieldValidator()
                    reqFldVal.ID = "reqFldValDynamic" + ControlCount.ToString()
                    reqFldVal.ControlToValidate = Editor.ID
                    reqFldVal.ValidationGroup = "CheckForm"
                    reqFldVal.ErrorMessage = "Required"
                    reqFldVal.Font.Size = "10"
                    reqFldVal.CssClass = "RequiredLabel"

                    tCell3.Controls.Add(reqFldVal)
                    tRow.Cells.Add(tCell3)
                    tblDynamic.Rows.Add(tRow)

                End If

                If citem.Value = "FileUpload" Then
                    Dim tRow As New TableRow()

                    Dim tCell0 As New TableCell()
                    tCell0.Width = Unit.Pixel(20)
                    tRow.Cells.Add(tCell0)

                    Dim tCell As New TableCell()

                    Dim FileUpload As New FileUpload()
                    FileUpload.ID = list(0).ControlID

                    ' Create label For Control Text
                    Dim lbl As New Label()
                    lbl.Text = list(0).ControlLabelInfo + ":"
                    lbl.CssClass = "label"

                    ' Create label Required Field
                    Dim lblReq As New Label()
                    lblReq.Text = "*"
                    lblReq.CssClass = "RequiredLabel"

                    ' Add to cell.
                    tCell.Width = Unit.Pixel(200)
                    tCell.Controls.Add(lbl)
                    tCell.Controls.Add(lblReq)
                    tRow.Cells.Add(tCell)

                    Dim tCell2 As New TableCell()
                    FileUpload.Width = Unit.Pixel(200)

                    tCell2.Width = Unit.Pixel(300)
                    tCell2.Controls.Add(FileUpload)
                    tRow.Cells.Add(tCell2)

                    Dim tCell3 As New TableCell()
                    'Dim reqFldVal As New RequiredFieldValidator()
                    'reqFldVal.ID = "reqFldValDynamic" + ControlCount.ToString()
                    'reqFldVal.ControlToValidate = FileUpload.ID
                    'reqFldVal.ValidationGroup = "CheckForm"
                    'reqFldVal.ErrorMessage = "Required"

                    'tCell3.Controls.Add(reqFldVal)
                    tRow.Cells.Add(tCell3)
                    tblDynamic.Rows.Add(tRow)

                End If

            Next
            tblDynamic.Rows.Add(tRowEnd)
            tblDynamic.Width = Unit.Percentage(100)
            pnlGeneratedControls.Controls.Add(tblDynamic)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
        

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "GenerateChaseCSFDF~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then
            GetVoiceDataCollection()
            GetPriorityList()
            GetAllULCBranch()
        Else
            Try
                GenerateControlFinal(drpChaseList.SelectedValue)
            Catch ex As Exception
                MessageBox(ex.Message)
            End Try

        End If

    End Sub

    Protected Sub GetVoiceDataCollection()
        grdVoiceDataColl.DataSource = VoiceCollData.fnGetVoiceDataColl()
        grdVoiceDataColl.DataBind()
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnGenerateChase_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerateChase.Click

        Dim folder As String = ""
        Dim Title As String = ""
        Dim DocExt As String = ""
        Dim DocFullName As String = ""
        Dim DocPrefix As String = ""
        Dim FileSize As Integer = 0
        Dim DocFileName As String = ""
        Dim i As Integer = 0

        Dim GenChase As New clsGeneratedChase()
        Dim GeneratedChaseID As String = ""
        Dim CtrlList As ArrayList = New ArrayList
        Dim ChaseInputValue As New clsChaseInputValues()
        Dim result As New clsResult()
        Dim MailProp As New clsMailProperty()

        Dim lblVoiceDataCollectionID As New Label()
        lblVoiceDataCollectionID = grdVoiceDataColl.SelectedRow.FindControl("lblVoiceDataCollectionID")

        GenChase.ChaseDefinitionID = drpChaseList.SelectedValue
        GenChase.VoiceDataCollectionID = lblVoiceDataCollectionID.Text
        GenChase.ParentChaseID = "N\A"
        GenChase.InitiatorID = Session("EmployeeID")
        GenChase.InitiatorRemarks = ""
        GenChase.AssignedToID = drpIntRepList.SelectedValue
        GenChase.ULCBranchID = drpULCBranchList.SelectedValue

        If drpRequestFor.Items.Count > 0 Then
            GenChase.ContactPersonID = drpRequestFor.SelectedValue
        Else
            GenChase.ContactPersonID = "N\A"
        End If
        GenChase.ModeOfCommunication = drpModeOfCommunication.SelectedValue
        GenChase.PriorityID = drpPriority.SelectedValue
        GenChase.EntryBy = Session("UserID")

        GeneratedChaseID = GenChaseData.fnInsertGeneratedChase(GenChase)

        '' Chase Input Values..
        If GeneratedChaseID = "" Then
            MessageBox("Error Found.")
        Else
            '' Get All Controls ID
            CtrlList = CtrlListData.fnGetAllCtrlIDByChaseDefID(drpChaseList.SelectedValue)

            For Each citem As ListItem In CtrlList

                ChaseInputValue.GeneratedChaseID = GeneratedChaseID
                ChaseInputValue.ChaseDefinitionID = drpChaseList.SelectedValue
                ChaseInputValue.ControlType = citem.Value

                '' Single Valued
                If citem.Value = "RadioButtonList" Then
                    Dim rdbtnList As New RadioButtonList()
                    rdbtnList = pnlGeneratedControls.FindControl(citem.Text)


                    ChaseInputValue.ControlID = citem.Text
                    ChaseInputValue.Value = rdbtnList.SelectedValue
                    ChaseInputValue.AdditionalValue = ""
                    result = ChaseInputValueData.fnInsertChaseInputValues(ChaseInputValue)
                    rdbtnList.SelectedIndex = -1
                End If

                If citem.Value = "CheckBoxList" Then
                    Dim chkBxLst As New CheckBoxList()
                    chkBxLst = pnlGeneratedControls.FindControl(citem.Text)

                    For Each item As ListItem In chkBxLst.Items
                        If item.Selected = True Then
                            ChaseInputValue.Value = item.Text
                            ChaseInputValue.AdditionalValue = ""
                            ChaseInputValue.ControlID = citem.Text
                            result = ChaseInputValueData.fnInsertChaseInputValues(ChaseInputValue)
                            item.Selected = False
                        Else
                            '' No Need To Input This Value..
                            ChaseInputValue.Value = ""
                        End If
                    Next
                End If

                If citem.Value = "DropDownList" Then
                    Dim drpLst As New DropDownList()
                    drpLst = pnlGeneratedControls.FindControl(citem.Text)


                    ChaseInputValue.ControlID = citem.Text
                    ChaseInputValue.Value = drpLst.SelectedValue
                    ChaseInputValue.AdditionalValue = ""
                    result = ChaseInputValueData.fnInsertChaseInputValues(ChaseInputValue)
                    drpLst.SelectedIndex = -1
                End If

                If citem.Value = "TextBox" Then
                    Dim TextBox As New TextBox()
                    TextBox = pnlGeneratedControls.FindControl(citem.Text)

                    ChaseInputValue.ControlID = citem.Text
                    ChaseInputValue.Value = TextBox.Text
                    ChaseInputValue.AdditionalValue = ""
                    result = ChaseInputValueData.fnInsertChaseInputValues(ChaseInputValue)
                    TextBox.Text = ""
                End If

                If citem.Value = "Editor" Then
                    Dim Editor As New HTMLEditor.Editor()
                    Dim Str As String = ""
                    Editor = pnlGeneratedControls.FindControl(citem.Text)

                    ChaseInputValue.ControlID = citem.Text

                    Dim Arr As String() = Split(Editor.Content, "<!--")
                    For i = 0 To Arr.Length - 1

                        Dim endIndex As Integer = Arr(i).IndexOf("-->")
                        If endIndex > 0 Then
                            Arr(i) = Arr(i).Remove(0, endIndex + 3)
                            Str += ClearUnwantedTag(Arr(i))
                        End If

                    Next

                    If Str = "" Then
                        Str = ClearUnwantedTag(Editor.Content)
                    End If

                    If Str.Length > 8000 Then
                        MessageBox("Editor Lengh Exceeds Total Allocated Length")
                        Exit Sub
                    End If

                    If Str.Length > 4000 Then
                        ChaseInputValue.Value = Str.Substring(0, 3999)
                        ChaseInputValue.AdditionalValue = Str.Substring(4000, Len(Str) - 4000)
                    Else
                        ChaseInputValue.Value = Str
                        ChaseInputValue.AdditionalValue = ""
                    End If


                    result = ChaseInputValueData.fnInsertChaseInputValues(ChaseInputValue)
                    Editor.Content = ""
                End If

                If citem.Value = "FileUpload" Then
                    Dim FileUpload As New FileUpload()
                    FileUpload = pnlGeneratedControls.FindControl(citem.Text)

                    If FileUpload.HasFile = True Then

                        'folder = Server.MapPath("~/Attachments/")
                        folder = ConfigurationManager.AppSettings("InputChaserFile")
                        DocExt = System.IO.Path.GetExtension(FileUpload.FileName)
                        DocFileName = "Att_" & DateTime.Now.ToString("ddMMyyHHmmss") & DocExt
                        DocFullName = folder & DocFileName
                        FileUpload.SaveAs(DocFullName)

                        ChaseInputValue.ControlID = citem.Text
                        ChaseInputValue.Value = "<a href= " + ConfigurationManager.AppSettings("OutputChaserFile") + DocFileName + ">Attachment</a>"
                        ChaseInputValue.AdditionalValue = ""
                        result = ChaseInputValueData.fnInsertChaseInputValues(ChaseInputValue)
                    End If


                End If

            Next

            '' Send Chase GenerationMail
            MailProp = GenChaseData.fnChaseGenearationMail(GeneratedChaseID)
            SendMail(MailProp)
            MessageBox("Chase Initiated Successfully.")

        End If

    End Sub

    Protected Function ClearUnwantedTag(ByVal html As String) As String

        html = html.Replace("&" & "nbsp;", " ").Trim()

        '' start by completely removing all unwanted tags 
        html = Regex.Replace(html, "<[/]?(font|span|xml|del|ins|[ovwxp]:\w+)[^>]*?>", "", RegexOptions.IgnoreCase)

        '' then run another pass over the html (twice), removing unwanted attributes 
        html = Regex.Replace(html, "<([^>]*)(?:class|lang|style|size|face|[ovwxp]:\w+)=(?:'[^']*'|""[^""]*""|[^\s>]+)([^>]*)>", "<$1$2>", RegexOptions.IgnoreCase)
        html = Regex.Replace(html, "<([^>]*)(?:class|lang|style|size|face|[ovwxp]:\w+)=(?:'[^']*'|""[^""]*""|[^\s>]+)([^>]*)>", "<$1$2>", RegexOptions.IgnoreCase)
        Return html
    End Function

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
            Dim smtp As New SmtpClient(MailProp.SMTPServer, MailProp.SMTPPort)
            smtp.Send(mail)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub grdVoiceDataColl_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdVoiceDataColl.SelectedIndexChanged

        Dim lblFacilityTypeID As New Label()
        lblFacilityTypeID = grdVoiceDataColl.SelectedRow.FindControl("lblFacilityTypeID")
        ShowActiveChaseList(lblFacilityTypeID.Text)

    End Sub

    Protected Sub drpULCBranchList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpULCBranchList.SelectedIndexChanged
        ShowEmpListByBranch(drpULCBranchList.SelectedValue)
    End Sub

End Class
