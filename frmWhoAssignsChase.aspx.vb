Imports System.Data

Partial Class frmWhoAssignsChase
    Inherits System.Web.UI.Page

    Dim GenChaseData As New clsGeneratedChaseDataAccess()

    Protected Sub btnShow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShow.Click
        Try
            grdChaserReportDetails.DataSource = GenChaseData.fnGetAssignedChaseByInitiator(drpTaskInitiator.SelectedValue, Convert.ToDateTime(txtDateFrom.Text), Convert.ToDateTime(txtDateTo.Text))
            grdChaserReportDetails.DataBind()
            grdChaserReportDetails.HeaderRow.Cells(6).Text = grdChaserReportDetails.HeaderRow.Cells(6).Text + " (" + grdChaserReportDetails.Rows.Count.ToString() + "*)"
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

    Protected Sub GetTaskInitiatorList()
        drpTaskInitiator.DataTextField = "EmployeeName"
        drpTaskInitiator.DataValueField = "InitiatorID"
        drpTaskInitiator.DataSource = GenChaseData.fnGetTaskInitiatorList
        drpTaskInitiator.DataBind()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetTaskInitiatorList()
            txtDateFrom.Text = Now.Date.Date
            txtDateTo.Text = Now.Date.Date
        End If
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

End Class
