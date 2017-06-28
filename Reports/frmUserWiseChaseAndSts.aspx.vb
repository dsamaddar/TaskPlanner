Imports System.Data

Partial Class Reports_frmUserWiseChaseAndSts
    Inherits System.Web.UI.Page

    Dim GenChaseData As New clsGeneratedChaseDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            Dim EmployeeID As String = Request.QueryString("EmployeeID")
            Dim ChaseStatus As String = Request.QueryString("ChaseStatus")
            GetAssignedChase(EmployeeID, ChaseStatus)

        End If

        If grdAssignedChase.Rows.Count > 0 Then
            'This replaces <td> with <th> and adds the scope attribute
            grdAssignedChase.UseAccessibleHeader = True
            'This will add the <thead> and <tbody> elements
            grdAssignedChase.HeaderRow.TableSection = TableRowSection.TableHeader
            'This adds the <tfoot> element.Remove if you don't have a footer row
            grdAssignedChase.FooterRow.TableSection = TableRowSection.TableFooter
        End If

    End Sub

    Protected Sub GetAssignedChase(ByVal EmployeeID As String, ByVal ChaseStatus As String)
        grdAssignedChase.DataSource = GenChaseData.fnGetAssignedChaseByUserAndSts(EmployeeID, ChaseStatus)
        grdAssignedChase.DataBind()

        If grdAssignedChase.Rows.Count > 0 Then
            'This replaces <td> with <th> and adds the scope attribute
            grdAssignedChase.UseAccessibleHeader = True
            'This will add the <thead> and <tbody> elements
            grdAssignedChase.HeaderRow.TableSection = TableRowSection.TableHeader
            'This adds the <tfoot> element.Remove if you don't have a footer row
            grdAssignedChase.FooterRow.TableSection = TableRowSection.TableFooter
        End If
    End Sub

    Protected Sub grdAssignedChase_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdAssignedChase.RowDataBound
        Dim lblFinalStatus As New Label()
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Cells(2).ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()
            e.Row.Cells(3).ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()
            e.Row.Cells(4).ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()
            e.Row.Cells(5).ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()
            e.Row.Cells(6).ToolTip = TryCast(e.Row.DataItem, DataRowView)("AssignmentHistory").ToString()
            e.Row.Cells(7).ToolTip = TryCast(e.Row.DataItem, DataRowView)("AssignmentHistory").ToString()

            lblFinalStatus = e.Row.FindControl("lblFinalStatus")

            If lblFinalStatus.Text = "Open" Then
                e.Row.Font.Bold = True
                e.Row.Cells(2).ForeColor = Drawing.Color.Green
            ElseIf lblFinalStatus.Text = "Overdue" Then
                e.Row.Font.Bold = True
                e.Row.Cells(2).ForeColor = Drawing.Color.Red
            ElseIf lblFinalStatus.Text = "Closed" Then
                e.Row.Cells(2).ForeColor = Drawing.Color.Orange
            End If

        End If

    End Sub

End Class
