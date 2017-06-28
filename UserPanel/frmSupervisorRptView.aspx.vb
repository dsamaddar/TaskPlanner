Imports System.Data

Partial Class UserPanel_frmSupervisorRptView
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfoDataAccess()
    Dim GenChaseData As New clsGeneratedChaseDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("EmployeeID") = "" Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then
            GetSubordinateList(Session("EmployeeID"))
            GetSubordinateUsrChaseList(Session("EmployeeID"))
        End If
    End Sub

    Protected Sub GetSubordinateUsrChaseList(ByVal CurrentSupervisor As String)
        drpChaseList.DataTextField = "ChaseName"
        drpChaseList.DataValueField = "ChaseDefinitionID"
        drpChaseList.DataSource = EmpData.fnGetSubordinateUsrChaseList(CurrentSupervisor)
        drpChaseList.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpChaseList.Items.Insert(0, A)
    End Sub

    Protected Sub GetSubordinateList(ByVal CurrentSupervisor As String)
        drpSubordinateList.DataTextField = "EmployeeName"
        drpSubordinateList.DataValueField = "EmployeeID"
        drpSubordinateList.DataSource = EmpData.fnGetSubordinateList(CurrentSupervisor)
        drpSubordinateList.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpSubordinateList.Items.Insert(0, A)

    End Sub

    Protected Sub btnShow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShow.Click

        grdSupervisorView.DataSource = GenChaseData.fnGetSupervisorChaseView(Session("EmployeeID"), drpChaseList.SelectedValue, drpSubordinateList.SelectedValue, drpChaseStatus.SelectedValue)
        grdSupervisorView.DataBind()

    End Sub

    Protected Sub grdSupervisorView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdSupervisorView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()
        End If
    End Sub
End Class
