Imports System.Data
Imports AjaxControlToolkit
Imports System.Net.Mail

Imports System.Data.DataTable

Partial Class frmChaseEditView
    Inherits System.Web.UI.Page

    Shared ControlCount As Integer = 0
    Dim CtrlListData As New clsControlListDataAccess()
    Dim GenChaseData As New clsGeneratedChaseDataAccess()
    Dim InputValueData As New clsChaseInputValuesDataAccess()
    Dim EmpInfoData As New clsEmployeeInfoDataAccess()
    Dim ULCBranchData As New clsULCBranch()
    Dim PriorityData As New clsPriority()

    Public dt As New DataTable()

    Protected Function FormatEmployeeTable() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("ControlType", System.Type.GetType("System.String"))
        dt.Columns.Add("ControlID", System.Type.GetType("System.String"))
        dt.Columns.Add("Value", System.Type.GetType("System.String"))
        Return dt
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("EmployeeID") = "" Then
            Response.Redirect("~\Login.aspx")
        End If

        Dim MasterChaseID As String = Request.QueryString("MasterChaseID")
        Dim ChaseDefinitionID As String = GenChaseData.fnGetGenChaseInfoByID(MasterChaseID)
        GenerateControlFinal(ChaseDefinitionID)

        If Not IsPostBack Then
            dt = FormatEmployeeTable()
            dt = InputValueData.fnGetInputValuesByGenChase(MasterChaseID).Tables(0)
            GetControlData(dt)
            GetAllULCBranch()
            GetPriorityList()
            ShowContactPersonInfo(MasterChaseID)
            GetPriorityInfo(MasterChaseID)
        End If

    End Sub

    Protected Sub GetPriorityInfo(ByVal GeneratedChaseID As String)
        Try
            Dim Priority As clsPriority = GenChaseData.fnGetPriorityInfo(GeneratedChaseID)
            drpPriority.SelectedValue = Priority.PriorityID
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub GetPriorityList()
        drpPriority.DataTextField = "PriorityText"
        drpPriority.DataValueField = "PriorityID"
        drpPriority.DataSource = PriorityData.fnGetActivePriorityList()
        drpPriority.DataBind()
    End Sub

    Protected Sub ShowContactPersonInfo(ByVal MasterChaseID As String)

        Dim GenChase As New clsGeneratedChase()
        GenChase = GenChaseData.fnGetContactInfoByMasterID(MasterChaseID)

        If GenChase.ULCBranchID <> "N\A" Then
            drpULCBranchList.SelectedValue = GenChase.ULCBranchID
            ShowEmpListByBranch(drpULCBranchList.SelectedValue)

            If GenChase.ContactPersonID <> "N\A" Then
                drpRequestFor.SelectedValue = GenChase.ContactPersonID
            End If
        End If
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

    Protected Sub GetControlData(ByVal dt As DataTable)

        Dim ControlType As String = ""
        Dim txt As New TextBox
        Dim rdbtn As New RadioButtonList
        Dim drp As New DropDownList
        Dim edt As New HTMLEditor.Editor()
        Dim lnkbtn As New LinkButton()
        Dim chklst As New CheckBoxList

        For Each dr As DataRow In dt.Rows
            ControlType = dr.Item("ControlType")

            If ControlType = "TextBox" Then
                txt = pnlGeneratedControls.FindControl(dr.Item("ControlID"))
                txt.Text = dr.Item("Value")
            ElseIf ControlType = "Editor" Then
                edt = pnlGeneratedControls.FindControl(dr.Item("ControlID"))
                edt.Content = dr.Item("Value")
            ElseIf ControlType = "RadioButtonList" Then
                rdbtn = pnlGeneratedControls.FindControl(dr.Item("ControlID"))
                rdbtn.SelectedValue = dr.Item("Value")
            ElseIf ControlType = "DropDownList" Then
                drp = pnlGeneratedControls.FindControl(dr.Item("ControlID"))
                drp.SelectedValue = dr.Item("Value")
            ElseIf ControlType = "FileUpload" Then
                lnkbtn.Text = dr.Item("Value")
                pnlGeneratedControls.Controls.Add(lnkbtn)
            ElseIf ControlType = "CheckBoxList" Then
                chklst = pnlGeneratedControls.FindControl(dr.Item("ControlID"))

                For Each itm As ListItem In chklst.Items
                    If itm.Value = dr.Item("Value") Then
                        itm.Selected = True
                    End If
                Next

            End If
        Next

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
                    ' Add to cell.
                    tCell.Width = Unit.Pixel(200)
                    tCell.Controls.Add(lbl)
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
                    ' Add to cell.
                    tCell.Width = Unit.Pixel(200)
                    tCell.Controls.Add(lbl)
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
                    ' Add to cell.
                    tCell.Width = Unit.Pixel(200)
                    tCell.Controls.Add(lbl)
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
                    ' Add to cell.
                    tCell.Width = Unit.Pixel(200)
                    tCell.Controls.Add(lbl)
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
                    ' Add to cell.
                    tCell.Width = Unit.Pixel(200)
                    tCell.Controls.Add(lbl)
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
                    ' Add to cell.
                    tCell.Width = Unit.Pixel(200)
                    tCell.Controls.Add(lbl)
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

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim folder As String = ""
        Dim Title As String = ""
        Dim DocExt As String = ""
        Dim DocFullName As String = ""
        Dim DocPrefix As String = ""
        Dim FileSize As Integer = 0
        Dim DocFileName As String = ""
        Dim i As Integer = 0

        Dim GenChase As New clsGeneratedChase()
        Dim CtrlList As ArrayList = New ArrayList
        Dim ChaseInputValue As New clsChaseInputValues()
        Dim result As New clsResult()
        Dim MailProp As New clsMailProperty()

        Dim MasterChaseID As String = Request.QueryString("MasterChaseID")
        Dim ChaseDefinitionID As String = GenChaseData.fnGetGenChaseInfoByID(MasterChaseID)

        Try

            '' Chase Input Values..
            If MasterChaseID = "" Then
                MessageBox("Error Found.")
            Else
                '' Get All Controls ID
                CtrlList = CtrlListData.fnGetAllCtrlIDByChaseDefID(ChaseDefinitionID)

                For Each citem As ListItem In CtrlList

                    ChaseInputValue.GeneratedChaseID = MasterChaseID
                    ChaseInputValue.ChaseDefinitionID = ChaseDefinitionID
                    ChaseInputValue.ControlType = citem.Value

                    '' Single Valued
                    If citem.Value = "RadioButtonList" Then
                        Dim rdbtnList As New RadioButtonList()
                        rdbtnList = pnlGeneratedControls.FindControl(citem.Text)


                        ChaseInputValue.ControlID = citem.Text
                        ChaseInputValue.Value = rdbtnList.SelectedValue
                        ChaseInputValue.AdditionalValue = ""
                        result = InputValueData.fnUpdateChaseInputValues(ChaseInputValue)
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
                                result = InputValueData.fnUpdateChaseInputValues(ChaseInputValue)
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
                        result = InputValueData.fnUpdateChaseInputValues(ChaseInputValue)
                        drpLst.SelectedIndex = -1
                    End If

                    If citem.Value = "TextBox" Then
                        Dim TextBox As New TextBox()
                        TextBox = pnlGeneratedControls.FindControl(citem.Text)

                        ChaseInputValue.ControlID = citem.Text
                        ChaseInputValue.Value = TextBox.Text
                        ChaseInputValue.AdditionalValue = ""
                        result = InputValueData.fnUpdateChaseInputValues(ChaseInputValue)
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


                        result = InputValueData.fnUpdateChaseInputValues(ChaseInputValue)
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
                            ChaseInputValue.Value = "<a href=" + ConfigurationManager.AppSettings("OutputChaserFile") + DocFileName + ">Attachment</a>"
                            ChaseInputValue.AdditionalValue = ""
                            result = InputValueData.fnUpdateChaseInputValues(ChaseInputValue)
                        End If


                    End If

                Next

                '' Send Chase GenerationMail
                MailProp = GenChaseData.fnChaseGenearationMail(MasterChaseID)
                SendMail(MailProp)
                MessageBox("Chase Updated Successfully.")
                btnUpdate.Enabled = False
            End If
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

    Protected Function ClearUnwantedTag(ByVal html As String) As String

        html = html.Replace("&" & "nbsp;", " ").Trim()

        '' start by completely removing all unwanted tags 
        html = Regex.Replace(html, "<[/]?(font|span|xml|del|ins|[ovwxp]:\w+)[^>]*?>", "", RegexOptions.IgnoreCase)

        '' then run another pass over the html (twice), removing unwanted attributes 
        html = Regex.Replace(html, "<([^>]*)(?:class|lang|style|size|face|[ovwxp]:\w+)=(?:'[^']*'|""[^""]*""|[^\s>]+)([^>]*)>", "<$1$2>", RegexOptions.IgnoreCase)
        html = Regex.Replace(html, "<([^>]*)(?:class|lang|style|size|face|[ovwxp]:\w+)=(?:'[^']*'|""[^""]*""|[^\s>]+)([^>]*)>", "<$1$2>", RegexOptions.IgnoreCase)
        Return html
    End Function

    Protected Sub drpULCBranchList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpULCBranchList.SelectedIndexChanged
        ShowEmpListByBranch(drpULCBranchList.SelectedValue)
        btnUpdateContactInfo.Enabled = True
    End Sub

    Protected Sub ShowEmpListByBranch(ByVal ULCBranchID As String)
        drpRequestFor.DataTextField = "EmployeeName"
        drpRequestFor.DataValueField = "EmployeeID"
        drpRequestFor.DataSource = EmpInfoData.fnGetBranchWiseEmpList(ULCBranchID)
        drpRequestFor.DataBind()
    End Sub

    Protected Sub btnUpdateContactInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateContactInfo.Click
        Dim GenChase As New clsGeneratedChase()
        GenChase.MasterChaseID = Request.QueryString("MasterChaseID")
        GenChase.ULCBranchID = drpULCBranchList.SelectedValue

        If drpRequestFor.Items.Count = 0 Then
            GenChase.ContactPersonID = "N\A"
        Else
            GenChase.ContactPersonID = drpRequestFor.SelectedValue
        End If

        Dim result As clsResult = GenChaseData.fnUpdateContactInfoByMasterID(GenChase)

        If result.Success = True Then
            btnUpdateContactInfo.Enabled = False
        End If

        MessageBox(result.Message)

    End Sub

    Protected Sub btnUpdatePriority_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdatePriority.Click
        Try
            Dim result As clsResult = GenChaseData.fnUpdatePriorityInfo(Request.QueryString("MasterChaseID"), drpPriority.SelectedValue)
            If result.Success = True Then
                btnUpdatePriority.Enabled = False
            End If
            MessageBox(result.Message)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

End Class
