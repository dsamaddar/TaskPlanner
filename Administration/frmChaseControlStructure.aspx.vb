
Partial Class Administration_frmChaseControlStructure
    Inherits System.Web.UI.Page

    Dim CtrlListData As New clsControlListDataAccess()
    Dim ChaseDefData As New clsChaseDefinitionDataAccess()
    Dim ChaseGroupCtrlData As New clsChaseGroupCtrlsDataAccess()
    Dim ItemData As New clsItems()

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "ChaseCtrlStructure~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then
            InitiateForm()
            ShowActiveChaseList("N\A", "N\A")
            GetCategoryList()
            btnSubmitGroup.Enabled = True
            btnUpdateGroup.Enabled = False
        End If
    End Sub

    Protected Sub GetCategoryList()
        drpCategory.DataTextField = "CategoryName"
        drpCategory.DataValueField = "CategoryID"
        drpCategory.DataSource = ItemData.fnGetActiveCategoryList()
        drpCategory.DataBind()

        Dim A As New ListItem
        A.Text = "--Select Category--"
        A.Value = "N\A"
        drpCategory.Items.Insert(0, A)
    End Sub

    Protected Sub ShowActiveChaseList(ByVal CategoryID As String, ByVal SubCategoryID As String)
        drpChaseList.DataTextField = "ChaseName"
        drpChaseList.DataValueField = "ChaseDefinitionID"
        drpChaseList.DataSource = ChaseDefData.fnGetChaseDefListActiveByCat(CategoryID, SubCategoryID)
        drpChaseList.DataBind()

        Dim A As New ListItem
        A.Text = "-- Select Chase From List --"
        A.Value = "N\A"

        drpChaseList.Items.Insert(0, A)
    End Sub

    Protected Sub InitiateForm()
        chkIsGroupControl.Enabled = False
        chkIsGroupControl.Checked = False
        drpGrpCtrlList.Enabled = False
        btnAdd.Enabled = True
        btnUpdate.Enabled = False
    End Sub

    Protected Sub ClearForm()
        'drpChaseList.SelectedIndex = -1
        drpControlType.SelectedIndex = -1
        txtControlIndex.Text = ""
        txtControlLabelInfo.Text = ""
        txtControlID.Text = ""
        txtControlValue.Text = ""
        chkIsActive.Checked = False
        chkIsGroupControl.Checked = False
        drpDataType.SelectedIndex = -1
        txtDataSource.Text = ""
        txtReportingHead.Text = ""
        txtViewOrder.Text = ""
        drpValueSelectionType.SelectedIndex = -1

        If grdControlList.Rows.Count > 0 Then
            grdControlList.SelectedIndex = -1
        End If

        btnAdd.Enabled = True
        btnUpdate.Enabled = False

    End Sub

    Protected Sub drpControlType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpControlType.SelectedIndexChanged
        If drpControlType.SelectedValue = "RadioButtonList" Or drpControlType.SelectedValue = "CheckBoxList" Or drpControlType.SelectedValue = "DropDownList" Then
            chkIsGroupControl.Checked = True
            drpGrpCtrlList.Enabled = True
            txtControlID.Enabled = False
            txtControlID.Text = ""
            txtControlLabelInfo.Enabled = False
        Else
            chkIsGroupControl.Checked = False
            drpGrpCtrlList.Enabled = False
            txtControlID.Enabled = True
            txtControlLabelInfo.Enabled = True
        End If

        GetControlID(drpChaseList.SelectedValue)
        ShowActiveGroupCtrlListByType(drpChaseList.SelectedValue, drpControlType.SelectedValue)
    End Sub

    Public Sub ShowActiveGroupCtrlListByType(ByVal ChaseDefinitionID As String, ByVal CtrlType As String)
        drpGrpCtrlList.DataTextField = "GroupName"
        drpGrpCtrlList.DataValueField = "GroupCode"
        drpGrpCtrlList.DataSource = ChaseGroupCtrlData.fnGetActiveChaseGroupCtrlsByType(ChaseDefinitionID, CtrlType)
        drpGrpCtrlList.DataBind()
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click

        Dim ControlList As New clsControlList()

        Try
            ControlList.ChaseDefinitionID = drpChaseList.SelectedValue
            ControlList.ControlIndex = Convert.ToInt32(txtControlIndex.Text)
            ControlList.ControlID = txtControlID.Text
            ControlList.ControlLabelInfo = txtControlLabelInfo.Text
            ControlList.ControlValue = txtControlValue.Text
            ControlList.ControlType = drpControlType.SelectedValue

            If chkIsGroupControl.Checked = True Then
                ControlList.IsGroupControl = True
                ControlList.GroupControlLabelInfo = drpGrpCtrlList.SelectedItem.Text
                ControlList.GroupControlID = drpGrpCtrlList.SelectedValue
            Else
                ControlList.IsGroupControl = False
                ControlList.GroupControlLabelInfo = ""
                ControlList.GroupControlID = ""
            End If

            ControlList.DataType = drpDataType.SelectedValue
            ControlList.DataSource = txtDataSource.Text
            ControlList.DataPresentationForm = drpDataPresentationForm.SelectedValue
            ControlList.ViewOrder = Convert.ToInt32(txtViewOrder.Text)
            ControlList.ReportingHead = txtReportingHead.Text
            ControlList.ValueSelectionType = drpValueSelectionType.SelectedValue

            If chkIsActive.Checked = True Then
                ControlList.IsActive = True
            Else
                ControlList.IsActive = False
            End If

            ControlList.EntryBy = Session("UserID")

            Dim Result As clsResult = CtrlListData.fnInsertControlList(ControlList)
            If Result.Success = True Then
                ShowAllControlLists(drpChaseList.SelectedValue)
                ClearForm()
            End If
            MessageBox(Result.Message)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub drpChaseList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpChaseList.SelectedIndexChanged
        ShowAllControlLists(drpChaseList.SelectedValue)
        GetControlID(drpChaseList.SelectedValue)
        ShowGroupControls(drpChaseList.SelectedValue)
        ShowActiveGroupCtrlList(drpChaseList.SelectedValue)
    End Sub

    Public Sub ShowActiveGroupCtrlList(ByVal ChaseDefinitionID As String)
        drpGrpCtrlList.DataTextField = "GroupName"
        drpGrpCtrlList.DataValueField = "GroupCode"
        drpGrpCtrlList.DataSource = ChaseGroupCtrlData.fnGetActiveChaseGroupCtrls(ChaseDefinitionID)
        drpGrpCtrlList.DataBind()
    End Sub

    Protected Sub GetControlID(ByVal ChaseDefinitionID As String)

        Dim ChaseShortCode As String = ChaseDefData.fnGetChaseShortCode(ChaseDefinitionID)

        If drpControlType.SelectedValue = "Label" Then
            txtControlID.Text = "lbl" + ChaseShortCode
            txtControlID.Text += CtrlListData.fnGetControlCounter(drpChaseList.SelectedValue, txtControlID.Text, False)
        End If

        If drpControlType.SelectedValue = "TextBox" Then
            txtControlID.Text = "txt" + ChaseShortCode
            txtControlID.Text += CtrlListData.fnGetControlCounter(drpChaseList.SelectedValue, txtControlID.Text, False)
        End If

        If drpControlType.SelectedValue = "CheckBox" Then
            txtControlID.Text = "chk" + ChaseShortCode
            txtControlID.Text += CtrlListData.fnGetControlCounter(drpChaseList.SelectedValue, txtControlID.Text, False)
        End If

        If drpControlType.SelectedValue = "DropDownList" Then
            txtControlID.Text = ""
        End If

        If drpControlType.SelectedValue = "CheckBoxList" Then
            txtControlID.Text = ""
        End If

        If drpControlType.SelectedValue = "RadioButtonList" Then
            txtControlID.Text = ""
        End If

        If drpControlType.SelectedValue = "Editor" Then
            txtControlID.Text = "edt" + ChaseShortCode
            txtControlID.Text += CtrlListData.fnGetControlCounter(drpChaseList.SelectedValue, txtControlID.Text, False)
        End If

        If drpControlType.SelectedValue = "FileUpload" Then
            txtControlID.Text = "flup" + ChaseShortCode
            txtControlID.Text += CtrlListData.fnGetControlCounter(drpChaseList.SelectedValue, txtControlID.Text, False)
        End If



    End Sub

    Protected Sub ShowAllControlLists(ByVal ChaseDefinitionID As String)
        grdControlList.DataSource = CtrlListData.fnGetAllControlListByChase(ChaseDefinitionID)
        grdControlList.DataBind()
    End Sub

    Protected Sub grdControlList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdControlList.SelectedIndexChanged
        Dim lblControlListID, lblControlIndex, lblControlID, lblControlLabelInfo, lblControlValue, lblControlType, _
        lblIsGroupControl, lblGroupControlLabelInfo, lblGroupControlID, lblDataType, lblDataSource, lblReportingHead, lblValueSelectionType, _
        lblIsActive, lblDataPresentationForm, lblViewOrder As New Label

        lblControlListID = grdControlList.SelectedRow.FindControl("lblControlListID")
        lblControlIndex = grdControlList.SelectedRow.FindControl("lblControlIndex")
        lblControlID = grdControlList.SelectedRow.FindControl("lblControlID")
        lblControlLabelInfo = grdControlList.SelectedRow.FindControl("lblControlLabelInfo")
        lblControlValue = grdControlList.SelectedRow.FindControl("lblControlValue")
        lblControlType = grdControlList.SelectedRow.FindControl("lblControlType")

        lblIsGroupControl = grdControlList.SelectedRow.FindControl("lblIsGroupControl")
        lblGroupControlLabelInfo = grdControlList.SelectedRow.FindControl("lblGroupControlLabelInfo")
        lblGroupControlID = grdControlList.SelectedRow.FindControl("lblGroupControlID")
        lblDataType = grdControlList.SelectedRow.FindControl("lblDataType")
        lblDataSource = grdControlList.SelectedRow.FindControl("lblDataSource")
        lblDataPresentationForm = grdControlList.SelectedRow.FindControl("lblDataPresentationForm")
        lblViewOrder = grdControlList.SelectedRow.FindControl("lblViewOrder")
        lblReportingHead = grdControlList.SelectedRow.FindControl("lblReportingHead")
        lblValueSelectionType = grdControlList.SelectedRow.FindControl("lblValueSelectionType")
        lblIsActive = grdControlList.SelectedRow.FindControl("lblIsActive")

        hdFldControlListID.Value = lblControlListID.Text
        txtControlIndex.Text = lblControlIndex.Text
        txtControlID.Text = lblControlID.Text
        txtControlLabelInfo.Text = lblControlLabelInfo.Text
        txtControlValue.Text = lblControlValue.Text
        drpControlType.SelectedValue = lblControlType.Text
        drpDataPresentationForm.SelectedValue = lblDataPresentationForm.Text
        txtViewOrder.Text = lblViewOrder.Text

        If lblIsGroupControl.Text = "YES" Then
            chkIsGroupControl.Checked = True
            txtControlID.Enabled = False
            txtControlLabelInfo.Enabled = False
            drpGrpCtrlList.Enabled = True
            drpGrpCtrlList.SelectedValue = lblGroupControlID.Text
        Else
            chkIsGroupControl.Checked = False
            txtControlID.Enabled = True
            txtControlLabelInfo.Enabled = True
            drpGrpCtrlList.Enabled = False
        End If

        drpDataType.SelectedValue = lblDataType.Text
        txtDataSource.Text = lblDataSource.Text
        txtReportingHead.Text = lblReportingHead.Text
        drpValueSelectionType.SelectedValue = lblValueSelectionType.Text
        If lblIsActive.Text = "YES" Then
            chkIsActive.Checked = True
        Else
            chkIsActive.Checked = False
        End If

        btnAdd.Enabled = False
        btnUpdate.Enabled = True

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        InitiateForm()
        ClearForm()
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim ControlList As New clsControlList()

        If hdFldControlListID.Value = "" Then
            MessageBox("Select A Control First.")
            Exit Sub
        End If

        Try
            ControlList.ControlListID = hdFldControlListID.Value
            ControlList.ChaseDefinitionID = drpChaseList.SelectedValue
            ControlList.ControlIndex = Convert.ToInt32(txtControlIndex.Text)
            ControlList.ControlID = txtControlID.Text
            ControlList.ControlLabelInfo = txtControlLabelInfo.Text
            ControlList.ControlValue = txtControlValue.Text
            ControlList.ControlType = drpControlType.SelectedValue

            If chkIsGroupControl.Checked = True Then
                ControlList.IsGroupControl = True
                ControlList.GroupControlLabelInfo = drpGrpCtrlList.SelectedItem.Text
                ControlList.GroupControlID = drpGrpCtrlList.SelectedValue
            Else
                ControlList.IsGroupControl = False
                ControlList.GroupControlLabelInfo = ""
                ControlList.GroupControlID = ""
            End If

            ControlList.DataType = drpDataType.SelectedValue
            ControlList.DataSource = txtDataSource.Text
            ControlList.DataPresentationForm = drpDataPresentationForm.SelectedValue
            ControlList.ViewOrder = Convert.ToInt32(txtViewOrder.Text)
            ControlList.ReportingHead = txtReportingHead.Text
            ControlList.ValueSelectionType = drpValueSelectionType.SelectedValue

            If chkIsActive.Checked = True Then
                ControlList.IsActive = True
            Else
                ControlList.IsActive = False
            End If

            ControlList.EntryBy = Session("UserID")

            Dim Result As clsResult = CtrlListData.fnUpdateControlList(ControlList)
            If Result.Success = True Then
                ShowAllControlLists(drpChaseList.SelectedValue)
                ClearForm()
            End If
            MessageBox(Result.Message)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnSubmitGroup_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmitGroup.Click

        Dim ChaseGroupCtrl As New clsChaseGroupCtrls()

        If drpChaseList.SelectedValue = "N\A" Then
            MessageBox("Select A Chase From List First.")
            Exit Sub
        End If

        If drpGrpCtrlList.SelectedValue = "N\A" Then
            MessageBox("Select A Group Ctrl First.")
            Exit Sub
        End If

        ChaseGroupCtrl.ChaseDefinitionID = drpChaseList.SelectedValue
        ChaseGroupCtrl.CtrlType = drpGrpCtrlType.SelectedValue
        ChaseGroupCtrl.GroupName = txtGroupName.Text
        ChaseGroupCtrl.GroupCode = txtGroupConrolCode.Text

        If chkIsGroupActive.Checked = True Then
            ChaseGroupCtrl.IsActive = True
        Else
            ChaseGroupCtrl.IsActive = False
        End If

        ChaseGroupCtrl.EntryBy = Session("UserID")

        Dim result As clsResult = ChaseGroupCtrlData.fnInsertChaseGroupCtrls(ChaseGroupCtrl)

        If result.Success = True Then
            ClearGroupForm()
            ShowGroupControls(drpChaseList.SelectedValue)
            ShowActiveGroupCtrlList(drpChaseList.SelectedValue)
        End If

        MessageBox(result.Message)

    End Sub

    Public Sub ShowGroupControls(ByVal ChaseDefinitionID As String)
        grdGroups.DataSource = ChaseGroupCtrlData.fnGetChaseGroupCtrlsByCDID(ChaseDefinitionID)
        grdGroups.DataBind()
    End Sub

    Protected Sub ClearGroupForm()
        hdFldChaseGroupCtrlID.Value = ""
        txtGroupName.Text = ""
        txtGroupConrolCode.Text = ""
        chkIsGroupActive.Checked = True

        If grdGroups.Rows.Count > 0 Then
            grdGroups.SelectedIndex = -1
        End If

        drpGrpCtrlType.SelectedIndex = -1

    End Sub

    Protected Sub btnUpdateGroup_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateGroup.Click
        Dim ChaseGroupCtrl As New clsChaseGroupCtrls()

        If drpChaseList.SelectedValue = "N\A" Then
            MessageBox("Select A Chase From List First.")
            Exit Sub
        End If

        If drpGrpCtrlList.SelectedValue = "N\A" Then
            MessageBox("Select A Group Ctrl First.")
            Exit Sub
        End If

        ChaseGroupCtrl.ChaseGroupCtrlID = hdFldChaseGroupCtrlID.Value
        ChaseGroupCtrl.ChaseDefinitionID = drpChaseList.SelectedValue
        ChaseGroupCtrl.CtrlType = drpGrpCtrlType.SelectedValue
        ChaseGroupCtrl.GroupName = txtGroupName.Text
        ChaseGroupCtrl.GroupCode = txtGroupConrolCode.Text

        If chkIsGroupActive.Checked = True Then
            ChaseGroupCtrl.IsActive = True
        Else
            ChaseGroupCtrl.IsActive = False
        End If

        ChaseGroupCtrl.EntryBy = Session("UserID")

        Dim result As clsResult = ChaseGroupCtrlData.fnUpdateChaseGroupCtrls(ChaseGroupCtrl)

        If result.Success = True Then
            ClearGroupForm()
            ShowGroupControls(drpChaseList.SelectedValue)
            ShowActiveGroupCtrlList(drpChaseList.SelectedValue)
        End If

        MessageBox(result.Message)
    End Sub

    Protected Sub grdGroups_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdGroups.SelectedIndexChanged
        Dim lblChaseGroupCtrlID, lblCtrlType, lblGroupName, lblGroupCode, lblIsGroupActive As New Label()

        lblChaseGroupCtrlID = grdGroups.SelectedRow.FindControl("lblChaseGroupCtrlID")
        lblGroupName = grdGroups.SelectedRow.FindControl("lblGroupName")
        lblGroupCode = grdGroups.SelectedRow.FindControl("lblGroupCode")
        lblCtrlType = grdGroups.SelectedRow.FindControl("lblCtrlType")
        lblIsGroupActive = grdGroups.SelectedRow.FindControl("lblIsGroupActive")

        hdFldChaseGroupCtrlID.Value = lblChaseGroupCtrlID.Text
        txtGroupName.Text = lblGroupName.Text
        txtGroupConrolCode.Text = lblGroupCode.Text
        drpGrpCtrlType.SelectedValue = lblCtrlType.Text

        If lblIsGroupActive.Text = "YES" Then
            chkIsGroupActive.Checked = True
        Else
            chkIsGroupActive.Checked = False
        End If

        btnUpdateGroup.Enabled = True
        btnSubmitGroup.Enabled = False

    End Sub

    Protected Sub btnCancelGroup_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelGroup.Click
        ClearGroupForm()
    End Sub

    Protected Sub drpGrpCtrlType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpGrpCtrlType.SelectedIndexChanged

        If drpChaseList.SelectedValue = "N\A" Then
            MessageBox("Select A Chase From The List Frist.")
            Exit Sub
        End If

        Dim ChaseShortCode As String = ChaseDefData.fnGetChaseShortCode(drpChaseList.SelectedValue)

        If drpGrpCtrlType.SelectedValue = "CheckBoxList" Then
            txtGroupConrolCode.Text = "chkbx" + ChaseShortCode
            txtGroupConrolCode.Text += CtrlListData.fnGetControlCounter(drpChaseList.SelectedValue, txtGroupConrolCode.Text, True)
        End If

        If drpGrpCtrlType.SelectedValue = "RadioButtonList" Then
            txtGroupConrolCode.Text = "rdbtn" + ChaseShortCode

            txtGroupConrolCode.Text += CtrlListData.fnGetControlCounter(drpChaseList.SelectedValue, txtGroupConrolCode.Text, True)
        End If

        If drpGrpCtrlType.SelectedValue = "DropDownList" Then
            txtGroupConrolCode.Text = "drp" + ChaseShortCode

            txtGroupConrolCode.Text += CtrlListData.fnGetControlCounter(drpChaseList.SelectedValue, txtGroupConrolCode.Text, True)
        End If

    End Sub

    Protected Sub drpCategory_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpCategory.SelectedIndexChanged
        Try
            GetSubCategoryListByCategory(drpCategory.SelectedValue)
            ShowActiveChaseList(drpCategory.SelectedValue, "N\A")
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
        
    End Sub

    Protected Sub GetSubCategoryListByCategory(ByVal CategoryID As String)
        drpSubCategory.DataTextField = "SubCategory"
        drpSubCategory.DataValueField = "SubCategoryID"
        drpSubCategory.DataSource = ItemData.fnGetActiveSubCatListByCategory(CategoryID)
        drpSubCategory.DataBind()

        Dim A As New ListItem
        A.Text = "--Select Sub-Category--"
        A.Value = "N\A"
        drpSubCategory.Items.Insert(0, A)
    End Sub

    Protected Sub drpSubCategory_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpSubCategory.SelectedIndexChanged
        Try
            ShowActiveChaseList(drpCategory.SelectedValue, drpSubCategory.SelectedValue)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

End Class
