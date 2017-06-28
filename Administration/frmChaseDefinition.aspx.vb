Imports System.Data

Partial Class Administration_frmChaseDefinition
    Inherits System.Web.UI.Page

    Dim ChaseDefData As New clsChaseDefinitionDataAccess()
    Dim FacilityTypeData As New clsFacilityTypeDataAccess()
    Dim PriorityData As New clsPriority()
    Dim ItemData As New clsItems()
    Dim EmpData As New clsEmployeeInfoDataAccess()
    Dim IntRepData As New clsInterestedReps()
    Dim DeptData As New clsDepartmentDataAccess()
    Dim ChaseOpenForDeptData As New clsChaseOpenForDeptDataAccess()

    Protected Function FormatEmployeeTable() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("EmployeeID", System.Type.GetType("System.String"))
        dt.Columns.Add("EmployeeName", System.Type.GetType("System.String"))
        Return dt
    End Function

    Protected Function FormatDeptTable() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("DepartmentID", System.Type.GetType("System.String"))
        Return dt
    End Function

    Protected Sub ShowAllUsers()
        drpAllUsers.DataTextField = "EmployeeName"
        drpAllUsers.DataValueField = "EmployeeID"
        drpAllUsers.DataSource = EmpData.fnGetEmployeeList()
        drpAllUsers.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"

        drpAllUsers.Items.Insert(0, A)

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetChaseDefinitionList()
            GetActiveFacilityType()
            GetActivePriorityList()
            GetCategoryList()
            GetActiveEmployeeList()
            GetDeptList()
            ShowAllUsers()

            Dim dtInterestedRep As New DataTable
            dtInterestedRep = FormatEmployeeTable()
            Session("dtInterestedRep") = dtInterestedRep

            Dim dtInformedParties As New DataTable
            dtInformedParties = FormatEmployeeTable()
            Session("dtInformedParties") = dtInformedParties

            Dim dtDeptList As New DataTable
            dtDeptList = FormatDeptTable()
            Session("dtDeptList") = dtDeptList

            btnSubmit.Enabled = True
            btnUpdate.Enabled = False

            chkIsOpenChase.Checked = False
            chkBxLstDepartments.Enabled = False

        End If
    End Sub

    Protected Sub GetDeptList()
        chkBxLstDepartments.DataTextField = "DeptName"
        chkBxLstDepartments.DataValueField = "DepartmentID"
        chkBxLstDepartments.DataSource = DeptData.fnGetDeptList()
        chkBxLstDepartments.DataBind()
    End Sub

    Protected Sub GetActiveEmployeeList()
        lstBxAllEmployees.DataTextField = "EmployeeName"
        lstBxAllEmployees.DataValueField = "EmployeeID"
        lstBxAllEmployees.DataSource = EmpData.fnGetActiveEmpList()
        lstBxAllEmployees.DataBind()
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

    Protected Sub GetActivePriorityList()
        drpPriorityList.DataTextField = "PriorityText"
        drpPriorityList.DataValueField = "PriorityID"
        drpPriorityList.DataSource = PriorityData.fnGetActivePriorityList()
        drpPriorityList.DataBind()

        Dim A As New ListItem
        A.Text = "--Select Priority--"
        A.Value = "N\A"
        drpPriorityList.Items.Insert(0, A)
    End Sub

    Protected Sub GetActiveFacilityType()
        drpFacilityType.DataTextField = "FacilityType"
        drpFacilityType.DataValueField = "FacilityTypeID"
        drpFacilityType.DataSource = FacilityTypeData.fnGetActiveFacilityTypeList()
        drpFacilityType.DataBind()
    End Sub

    Protected Sub GetChaseDefinitionList()
        grdChaseDefList.DataSource = ChaseDefData.fnGetChaseDefListAll()
        grdChaseDefList.DataBind()
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub ClearForm()
        drpFacilityType.SelectedIndex = -1
        txtChaseName.Text = ""
        txtShortCode.Text = ""
        chkIsActive.Checked = True
        chkIsOpenChase.Checked = True

        If grdChaseDefList.Rows.Count > 0 Then
            grdChaseDefList.SelectedIndex = -1
        End If

        btnSubmit.Enabled = True
        btnUpdate.Enabled = False

        drpItemList.DataSource = ""
        drpItemList.DataBind()

        drpSubCategoryList.DataSource = ""
        drpSubCategoryList.DataBind()

        drpCategoryList.SelectedIndex = -1

        lstBxAllEmployees.SelectedIndex = -1

        lstBxInterestedEmployees.DataSource = ""
        lstBxInterestedEmployees.DataBind()

        lstBxInformedParties.DataSource = ""
        lstBxInformedParties.DataBind()

        Session("dtInterestedRep") = ""
        Session("dtInformedParties") = ""

        Dim dtInterestedRep As New DataTable
        dtInterestedRep = FormatEmployeeTable()
        Session("dtInterestedRep") = dtInterestedRep

        Dim dtInformedParties As New DataTable
        dtInformedParties = FormatEmployeeTable()
        Session("dtInformedParties") = dtInformedParties

        For Each itm As ListItem In chkBxLstDepartments.Items
            If itm.Selected = True Then
                itm.Selected = False
            End If
        Next

        chkBxSelectAllDept.Checked = False
        txtChaseInstruction.Text = ""
        drpAllUsers.SelectedIndex = -1
        chkUserCanChange.Checked = True

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub grdChaseDefList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdChaseDefList.SelectedIndexChanged
        Dim lblChaseDefinitionID, lblFacilityTypeID, lblChaseName, lblChaseShortCode, lblCategoryID, lblSubCategoryID, lblItemID, lblPriorityID, _
        lblIsOpenChase, lblIsActive, lblPrimarySupportRep, lblChaseInstruction, lblUserChangePrimarySupPerson As New Label()

        lblChaseDefinitionID = grdChaseDefList.SelectedRow.FindControl("lblChaseDefinitionID")
        lblFacilityTypeID = grdChaseDefList.SelectedRow.FindControl("lblFacilityTypeID")
        lblChaseName = grdChaseDefList.SelectedRow.FindControl("lblChaseName")
        lblChaseShortCode = grdChaseDefList.SelectedRow.FindControl("lblChaseShortCode")
        lblCategoryID = grdChaseDefList.SelectedRow.FindControl("lblCategoryID")
        lblSubCategoryID = grdChaseDefList.SelectedRow.FindControl("lblSubCategoryID")
        lblItemID = grdChaseDefList.SelectedRow.FindControl("lblItemID")
        lblPriorityID = grdChaseDefList.SelectedRow.FindControl("lblPriorityID")
        lblIsActive = grdChaseDefList.SelectedRow.FindControl("lblIsActive")
        lblIsOpenChase = grdChaseDefList.SelectedRow.FindControl("lblIsOpenChase")
        lblPrimarySupportRep = grdChaseDefList.SelectedRow.FindControl("lblPrimarySupportRep")
        lblChaseInstruction = grdChaseDefList.SelectedRow.FindControl("lblChaseInstruction")
        lblUserChangePrimarySupPerson = grdChaseDefList.SelectedRow.FindControl("lblUserChangePrimarySupPerson")
        Try
            Dim dtInterestedRep As New DataTable
            dtInterestedRep = IntRepData.fnGetInterestedRepsByChaseDefID(lblChaseDefinitionID.Text, "Representative").Tables(0)

            Dim dtInformedParties As New DataTable
            dtInformedParties = IntRepData.fnGetInterestedRepsByChaseDefID(lblChaseDefinitionID.Text, "Informed").Tables(0)

            Dim dtDeptList As New DataTable
            dtDeptList = ChaseOpenForDeptData.fnGetOpenForDeptByChaseID(lblChaseDefinitionID.Text).Tables(0)

            lstBxInterestedEmployees.DataTextField = "EmployeeName"
            lstBxInterestedEmployees.DataValueField = "EmployeeID"
            lstBxInterestedEmployees.DataSource = dtInterestedRep
            lstBxInterestedEmployees.DataBind()
            Session("dtInterestedRep") = dtInterestedRep

            lstBxInformedParties.DataTextField = "EmployeeName"
            lstBxInformedParties.DataValueField = "EmployeeID"
            lstBxInformedParties.DataSource = dtInformedParties
            lstBxInformedParties.DataBind()
            Session("dtInformedParties") = dtInformedParties

            hdChaseDefID.Value = lblChaseDefinitionID.Text
            drpFacilityType.SelectedValue = lblFacilityTypeID.Text
            txtChaseName.Text = lblChaseName.Text
            txtShortCode.Text = lblChaseShortCode.Text
            drpCategoryList.SelectedValue = lblCategoryID.Text

            GetSubCategoryListByCategory(drpCategoryList.SelectedValue)
            drpSubCategoryList.SelectedValue = lblSubCategoryID.Text

            GetItemsBySubCategory(drpSubCategoryList.SelectedValue)
            drpItemList.SelectedValue = lblItemID.Text

            drpPriorityList.SelectedValue = lblPriorityID.Text

            ''''''Added by tajnin
            Dim FlagPrimarySup As Integer
            FlagPrimarySup = 0
            For Each item As ListItem In drpAllUsers.Items
                If item.Value = lblPrimarySupportRep.Text Then
                    FlagPrimarySup = 1
                    Exit For
                End If
            Next

            If FlagPrimarySup = 1 Then
                drpAllUsers.SelectedValue = lblPrimarySupportRep.Text
            Else
                drpAllUsers.SelectedIndex = 0
            End If

            ''''''''''''''''''''''
            txtChaseInstruction.Text = lblChaseInstruction.Text

            If lblIsActive.Text = "YES" Then
                chkIsActive.Checked = True
            Else
                chkIsActive.Checked = False
            End If

            If lblIsOpenChase.Text = "YES" Then
                chkIsOpenChase.Checked = True
                chkBxLstDepartments.Enabled = True
                For Each itm As ListItem In chkBxLstDepartments.Items
                    For Each ditem As DataRow In dtDeptList.Rows
                        If ditem("DepartmentID") = itm.Value Then
                            itm.Selected = True
                        End If
                    Next
                Next

            Else
                chkIsOpenChase.Checked = False

            End If

            If lblUserChangePrimarySupPerson.Text = "Yes" Then
                chkUserCanChange.Checked = True
            Else
                chkUserCanChange.Checked = False
            End If



            btnSubmit.Enabled = False
            btnUpdate.Enabled = True
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try


    End Sub

    Protected Sub drpCategoryList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpCategoryList.SelectedIndexChanged
        GetSubCategoryListByCategory(drpCategoryList.SelectedValue)
    End Sub

    Protected Sub drpSubCategoryList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpSubCategoryList.SelectedIndexChanged
        GetItemsBySubCategory(drpSubCategoryList.SelectedValue)
    End Sub


    Protected Function InsertRep(ByVal EmployeeID As String, ByVal EmployeeName As String) As DataTable
        Dim dtInterestedRep As DataTable = New DataTable()
        dtInterestedRep = Session("dtInterestedRep")

        Dim dr As DataRow
        dr = dtInterestedRep.NewRow()
        dr("EmployeeID") = EmployeeID
        dr("EmployeeName") = EmployeeName

        dtInterestedRep.Rows.Add(dr)
        dtInterestedRep.AcceptChanges()

        Session("dtInterestedRep") = dtInterestedRep

        Return dtInterestedRep
    End Function

    Protected Function CheckForExisting(ByVal EmployeeID As String) As Boolean
        Dim IsExists As Boolean = False
        For Each itm As ListItem In lstBxInterestedEmployees.Items
            If itm.Value = EmployeeID Then
                IsExists = True
                Exit For
            End If
        Next

        Return IsExists
    End Function

    Protected Function RemoveRep(ByVal Index As Integer) As DataTable
        Dim dtInterestedRep As DataTable = New DataTable()
        dtInterestedRep = Session("dtInterestedRep")

        dtInterestedRep.Rows(Index).Delete()
        dtInterestedRep.AcceptChanges()

        Return dtInterestedRep
    End Function

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        Dim ChaseDef As New clsChaseDefinition()
        Dim DepartmentIDList As String = ""

        If drpCategoryList.SelectedValue = "N\A" Then
            MessageBox("Select A Category")
            Exit Sub
        End If

        If drpPriorityList.SelectedValue = "N\A" Then
            MessageBox("Select Priority")
            Exit Sub
        End If

        ChaseDef.FacilityTypeID = drpFacilityType.SelectedValue
        ChaseDef.ChaseName = txtChaseName.Text
        ChaseDef.ChaseShortCode = txtShortCode.Text
        ChaseDef.CategoryID = drpCategoryList.SelectedValue

        If drpSubCategoryList.Items.Count > 0 Then
            ChaseDef.SubCategoryID = drpSubCategoryList.SelectedValue
        Else
            ChaseDef.SubCategoryID = "N\A"
        End If

        If drpItemList.Items.Count > 0 Then
            ChaseDef.ItemID = drpItemList.SelectedValue
        Else
            ChaseDef.ItemID = "N\A"
        End If

        ChaseDef.PriorityID = drpPriorityList.SelectedValue

        '' Start Of Interested Reps
        Dim dtInterestedRep As New DataTable
        dtInterestedRep = Session("dtInterestedRep")

        Dim EmpStr As String = ""
        For Each itm As DataRow In dtInterestedRep.Rows
            EmpStr += itm("EmployeeID") + ","
        Next

        If EmpStr = "" Then
            MessageBox("Responsible Person Can't Be Empty")
            Exit Sub
        Else
            EmpStr = EmpStr.Remove(Len(EmpStr) - 1, 1)
        End If

        ChaseDef.EmployeeList = EmpStr
        '' End Of Interested Reps

        '' Start Of Informed Parties
        Dim dtInformedParties As New DataTable
        dtInformedParties = Session("dtInformedParties")

        EmpStr = ""
        For Each itm As DataRow In dtInformedParties.Rows
            EmpStr += itm("EmployeeID") + ","
        Next

        If EmpStr <> "" Then
            EmpStr = EmpStr.Remove(Len(EmpStr) - 1, 1)
        End If

        ChaseDef.InformedParties = EmpStr
        '' End Of Informed Parties

        If chkIsOpenChase.Checked = True Then
            ChaseDef.IsOpenChase = True

            For Each itm As ListItem In chkBxLstDepartments.Items
                If itm.Selected = True Then
                    DepartmentIDList += itm.Value + ","
                End If
            Next

            If DepartmentIDList <> "" Then
                DepartmentIDList = DepartmentIDList.Remove(Len(DepartmentIDList) - 1, 1)
            End If

            ChaseDef.DepartmentIDList = DepartmentIDList

        Else
            ChaseDef.IsOpenChase = False
            ChaseDef.DepartmentIDList = ""
            chkBxLstDepartments.Enabled = False

            For Each itm As ListItem In chkBxLstDepartments.Items
                If itm.Selected = True Then
                    itm.Selected = False
                End If
            Next
        End If



        If chkIsActive.Checked = True Then
            ChaseDef.IsActive = True
        Else
            ChaseDef.IsActive = False
        End If

        ChaseDef.PrimarySupportRep = drpAllUsers.SelectedValue
        ChaseDef.ChaseInstruction = txtChaseInstruction.Text
        ChaseDef.EntryBy = Session("UserID")
        ChaseDef.UserCanChange = chkUserCanChange.Checked

        Dim Result As clsResult = ChaseDefData.fnInsertChaseDefinition(ChaseDef)

        If Result.Success = True Then
            ClearForm()
            GetChaseDefinitionList()
        End If

        MessageBox(Result.Message)

    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim ChaseDef As New clsChaseDefinition()
        Dim DepartmentIDList As String = ""

        If drpCategoryList.SelectedValue = "N\A" Then
            MessageBox("Select A Category")
            Exit Sub
        End If

        If drpPriorityList.SelectedValue = "N\A" Then
            MessageBox("Select Priority")
            Exit Sub
        End If

        Try
            ChaseDef.ChaseDefinitionID = hdChaseDefID.Value
            ChaseDef.FacilityTypeID = drpFacilityType.SelectedValue
            ChaseDef.ChaseName = txtChaseName.Text
            ChaseDef.ChaseShortCode = txtShortCode.Text
            ChaseDef.CategoryID = drpCategoryList.SelectedValue

            If drpSubCategoryList.Items.Count > 0 Then
                ChaseDef.SubCategoryID = drpSubCategoryList.SelectedValue
            Else
                ChaseDef.SubCategoryID = "N\A"
            End If

            If drpItemList.Items.Count > 0 Then
                ChaseDef.ItemID = drpItemList.SelectedValue
            Else
                ChaseDef.ItemID = "N\A"
            End If

            ChaseDef.PriorityID = drpPriorityList.SelectedValue

            '' Start Of Interested Reps
            Dim dtInterestedRep As New DataTable
            dtInterestedRep = Session("dtInterestedRep")

            Dim EmpStr As String = ""
            For Each itm As DataRow In dtInterestedRep.Rows
                EmpStr += itm("EmployeeID") + ","
            Next

            If EmpStr = "" Then
                MessageBox("Responsible Person Can't Be Empty")
                Exit Sub
            Else
                EmpStr = EmpStr.Remove(Len(EmpStr) - 1, 1)
            End If

            ChaseDef.EmployeeList = EmpStr
            '' End Of Interested Reps

            '' Start Of Informed Parties
            Dim dtInformedParties As New DataTable
            dtInformedParties = Session("dtInformedParties")

            EmpStr = ""
            For Each itm As DataRow In dtInformedParties.Rows
                EmpStr += itm("EmployeeID") + ","
            Next

            If EmpStr <> "" Then
                EmpStr = EmpStr.Remove(Len(EmpStr) - 1, 1)
            End If

            ChaseDef.InformedParties = EmpStr
            '' End Of Informed Parties

            If chkIsOpenChase.Checked = True Then
                ChaseDef.IsOpenChase = True

                For Each itm As ListItem In chkBxLstDepartments.Items
                    If itm.Selected = True Then
                        DepartmentIDList += itm.Value + ","
                    End If
                Next

                If DepartmentIDList <> "" Then
                    DepartmentIDList = DepartmentIDList.Remove(Len(DepartmentIDList) - 1, 1)
                End If

                ChaseDef.DepartmentIDList = DepartmentIDList

            Else
                ChaseDef.IsOpenChase = False
                ChaseDef.DepartmentIDList = ""
                chkBxLstDepartments.Enabled = False

                For Each itm As ListItem In chkBxLstDepartments.Items
                    If itm.Selected = True Then
                        itm.Selected = False
                    End If
                Next
            End If

            If chkIsActive.Checked = True Then
                ChaseDef.IsActive = True
            Else
                ChaseDef.IsActive = False
            End If

            ChaseDef.PrimarySupportRep = drpAllUsers.SelectedValue
            ChaseDef.ChaseInstruction = txtChaseInstruction.Text
            ChaseDef.EntryBy = Session("UserID")
            ChaseDef.UserCanChange = chkUserCanChange.Checked

            Dim Result As clsResult = ChaseDefData.fnUpdateChaseDefinition(ChaseDef)

            If Result.Success = True Then
                ClearForm()
                GetChaseDefinitionList()
            End If

            MessageBox(Result.Message)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub


    Protected Function InsertInfParties(ByVal EmployeeID As String, ByVal EmployeeName As String) As DataTable
        Dim dtInformedParties As DataTable = New DataTable()
        dtInformedParties = Session("dtInformedParties")

        Dim dr As DataRow
        dr = dtInformedParties.NewRow()
        dr("EmployeeID") = EmployeeID
        dr("EmployeeName") = EmployeeName

        dtInformedParties.Rows.Add(dr)
        dtInformedParties.AcceptChanges()

        Session("dtInformedParties") = dtInformedParties

        Return dtInformedParties
    End Function

    Protected Function CheckForExistingInfParties(ByVal EmployeeID As String) As Boolean
        Dim IsExists As Boolean = False
        For Each itm As ListItem In lstBxInformedParties.Items
            If itm.Value = EmployeeID Then
                IsExists = True
                Exit For
            End If
        Next

        Return IsExists
    End Function

    Protected Function RemoveInfParties(ByVal Index As Integer) As DataTable
        Dim dtInformedParties As DataTable = New DataTable()
        dtInformedParties = Session("dtInformedParties")

        dtInformedParties.Rows(Index).Delete()
        dtInformedParties.AcceptChanges()

        Return dtInformedParties
    End Function

    Protected Sub chkIsOpenChase_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkIsOpenChase.CheckedChanged

        If chkIsOpenChase.Checked = True Then

            chkBxLstDepartments.Enabled = True
        Else
            chkBxLstDepartments.Enabled = False

            For Each itm As ListItem In chkBxLstDepartments.Items
                If itm.Selected = True Then
                    itm.Selected = False
                End If
            Next

        End If

    End Sub

    Protected Sub chkBxSelectAllDept_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkBxSelectAllDept.CheckedChanged
        If chkBxSelectAllDept.Checked = True Then
            For Each itm As ListItem In chkBxLstDepartments.Items
                itm.Selected = True
            Next
        Else
            For Each itm As ListItem In chkBxLstDepartments.Items
                itm.Selected = False
            Next
        End If
    End Sub

    Protected Sub imgBtnAddIntReps_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnAddIntReps.Click

        If lstBxAllEmployees.SelectedIndex = -1 Then
            MessageBox("Select An Employee First.")
            Exit Sub
        End If

        If CheckForExisting(lstBxAllEmployees.SelectedValue) = True Then
            MessageBox("Item Already Exists In The List.")
            Exit Sub
        Else
            lstBxInterestedEmployees.DataTextField = "EmployeeName"
            lstBxInterestedEmployees.DataValueField = "EmployeeID"

            lstBxInterestedEmployees.DataSource = InsertRep(lstBxAllEmployees.SelectedValue, lstBxAllEmployees.SelectedItem.Text)
            lstBxInterestedEmployees.DataBind()
        End If
    End Sub

    Protected Sub imgBtnRemoveIntReps_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnRemoveIntReps.Click
        If lstBxInterestedEmployees.SelectedIndex = -1 Then
            MessageBox("Select An Item First.")
            Exit Sub
        End If

        lstBxInterestedEmployees.DataTextField = "EmployeeName"
        lstBxInterestedEmployees.DataValueField = "EmployeeID"
        lstBxInterestedEmployees.DataSource = RemoveRep(lstBxInterestedEmployees.SelectedIndex)
        lstBxInterestedEmployees.DataBind()
    End Sub

    Protected Sub imgBtnAddInfParties_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnAddInfParties.Click
        If lstBxAllEmployees.SelectedIndex = -1 Then
            MessageBox("Select An Employee First.")
            Exit Sub
        End If

        If CheckForExistingInfParties(lstBxAllEmployees.SelectedValue) = True Then
            MessageBox("Item Already Exists In The List.")
            Exit Sub
        Else
            lstBxInformedParties.DataTextField = "EmployeeName"
            lstBxInformedParties.DataValueField = "EmployeeID"

            lstBxInformedParties.DataSource = InsertInfParties(lstBxAllEmployees.SelectedValue, lstBxAllEmployees.SelectedItem.Text)
            lstBxInformedParties.DataBind()
        End If
    End Sub

    Protected Sub imgBtnRemoveInfParties_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnRemoveInfParties.Click
        If lstBxInformedParties.SelectedIndex = -1 Then
            MessageBox("Select An Item First.")
            Exit Sub
        End If

        lstBxInformedParties.DataTextField = "EmployeeName"
        lstBxInformedParties.DataValueField = "EmployeeID"
        lstBxInformedParties.DataSource = RemoveInfParties(lstBxInformedParties.SelectedIndex)
        lstBxInformedParties.DataBind()
    End Sub
End Class
