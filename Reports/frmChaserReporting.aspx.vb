Imports System.Data

Partial Class Reports_frmChaserReporting
    Inherits System.Web.UI.Page

    Dim ItemData As New clsItems()
    Dim PriorityData As New clsPriority()
    Dim ULCBranchData As New clsULCBranch()
    Dim GenChaseData As New clsGeneratedChaseDataAccess()
    Dim ChaseDefData As New clsChaseDefinitionDataAccess()

    Protected Sub btnGenerateReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerateReport.Click

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

            GenChase.ChaseDefinitionID = drpChaseList.SelectedValue
            GenChase.ChaseStatus = drpChaseStatus.SelectedValue
            GenChase.PriorityID = drpPriority.SelectedValue
            GenChase.ULCBranchID = drpULCBranchList.SelectedValue
            GenChase.FinalStatus = drpFinalStatus.SelectedValue
            GenChase.AssignedToID = drpAssignedTo.SelectedValue
            If Not String.IsNullOrEmpty(txtDateFrom.Text.Trim()) Then

                GenChase.InitiationDateFrom = CType(txtDateFrom.Text.Trim(), Date)
            Else
                GenChase.InitiationDateFrom = CType("1/1/1753 12:00:00 AM", Date)
            End If
            If Not String.IsNullOrEmpty(txtDateTo.Text.Trim()) Then
                GenChase.InitiationDateTo = CType(txtDateTo.Text.Trim(), Date)
            Else
                GenChase.InitiationDateTo = CType("12/31/9999 11:59:59 PM", Date)
            End If

            grdChaserReportDetails.DataSource = GenChaseData.fnRptGeneratedChase(GenChase).Tables(0)
            grdChaserReportDetails.DataBind()

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub ClearChaseList()
        drpChaseList.DataSource = ""
        drpChaseList.DataBind()
    End Sub

    Protected Sub ShowActiveChaseList(ByVal CategoryID As String, ByVal SubCategoryID As String, ByVal EmployeeID As String)
        drpChaseList.DataTextField = "ChaseName"
        drpChaseList.DataValueField = "ChaseDefinitionID"
        drpChaseList.DataSource = ChaseDefData.fnGetChaseDefListActiveByCatByUsr(CategoryID, SubCategoryID, EmployeeID)
        drpChaseList.DataBind()

        Dim A As New ListItem
        A.Text = "-- Select Chase From List --"
        A.Value = "N\A"

        drpChaseList.Items.Insert(0, A)
    End Sub

    Protected Sub drpSubCategoryList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpSubCategoryList.SelectedIndexChanged
        GetItemsBySubCategory(drpSubCategoryList.SelectedValue)
        ClearChaseList()
        ShowActiveChaseList(drpCategoryList.SelectedValue, drpSubCategoryList.SelectedValue, Session("EmployeeID"))
    End Sub

    Protected Sub drpCategoryList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpCategoryList.SelectedIndexChanged
        GetSubCategoryListByCategory(drpCategoryList.SelectedValue)
        drpItemList.DataSource = ""
        drpItemList.DataBind()
    End Sub

    Protected Sub GetCategoryList()
        drpCategoryList.DataTextField = "CategoryName"
        drpCategoryList.DataValueField = "CategoryID"
        drpCategoryList.DataSource = ItemData.fnGetActiveCategoryList()
        drpCategoryList.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpCategoryList.Items.Insert(0, A)
    End Sub

    Protected Sub GetSubCategoryListByCategory(ByVal CategoryID As String)
        drpSubCategoryList.DataTextField = "SubCategory"
        drpSubCategoryList.DataValueField = "SubCategoryID"
        drpSubCategoryList.DataSource = ItemData.fnGetActiveSubCatListByCategory(CategoryID)
        drpSubCategoryList.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
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
    Protected Sub GetTaskAssignedToList()
        drpAssignedTo.DataTextField = "EmployeeName"
        drpAssignedTo.DataValueField = "AssignedToID"
        drpAssignedTo.DataSource = GenChaseData.fnGetTaskAssignedToList()
        drpAssignedTo.DataBind()
        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpAssignedTo.Items.Insert(0, A)
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetPriorityList()
            GetAllULCBranch()
            GetCategoryList()
            GetTaskAssignedToList()
        End If
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

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExport.Click

    End Sub

    Protected Sub grdChaserReportDetails_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdChaserReportDetails.RowDataBound

        Dim lblFinalStatus As New Label()

        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()

            lblFinalStatus = e.Row.FindControl("lblFinalStatus")

            If lblFinalStatus.Text = "Open" Then
                e.Row.Cells(6).ForeColor = Drawing.Color.Green
                e.Row.Cells(7).ForeColor = Drawing.Color.Green
                e.Row.Cells(8).ForeColor = Drawing.Color.Green
                e.Row.Cells(9).ForeColor = Drawing.Color.Green
            ElseIf lblFinalStatus.Text = "Overdue" Then
                e.Row.Font.Bold = True
                e.Row.Cells(6).ForeColor = Drawing.Color.Red
                e.Row.Cells(7).ForeColor = Drawing.Color.Red
                e.Row.Cells(8).ForeColor = Drawing.Color.Red
                e.Row.Cells(9).ForeColor = Drawing.Color.Red
            ElseIf lblFinalStatus.Text = "Closed" Then
                e.Row.Cells(6).ForeColor = Drawing.Color.Orange
                e.Row.Cells(7).ForeColor = Drawing.Color.Orange
                e.Row.Cells(8).ForeColor = Drawing.Color.Orange
                e.Row.Cells(9).ForeColor = Drawing.Color.Orange

            End If

        End If
    End Sub
End Class
