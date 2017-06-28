Imports System.Data

Partial Class frmUsrDepartmentalChaseRpt
    Inherits System.Web.UI.Page

    Dim GenChaseData As New clsGeneratedChaseDataAccess()
    Dim Pending, Forwarded, Terminated As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("EmployeeID") = "" Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then
            GetGlobalViewByDept()
            drpYear.SelectedValue = Now.Year

        End If
        If grdGlobalView.SelectedIndex <> -1 Then
            ShowGraphDataByUser()
        End If
    End Sub

    Protected Sub GetGlobalViewByDept()
        Dim EmployeeID As String = Session("EmployeeID")
        grdGlobalView.DataSource = GenChaseData.fnGetGlobalChaseViewByDept(EmployeeID)
        grdGlobalView.DataBind()
    End Sub

    Protected Sub ShowGraphDataByUser()
        Dim lblAssignedToID As New Label()

        lblAssignedToID = grdGlobalView.SelectedRow.FindControl("lblAssignedToID")
        'GetGraphicalDataByUser(lblAssignedToID.Text)
    End Sub

    'Protected Sub GetGraphicalDataByUser(ByVal EmployeeID As String)

    '    Dim dt As New DataTable()
    '    Try
    '        dt = GenChaseData.fnGetChaseViewGraphByUser(EmployeeID).Tables(0)

    '        Dim x(dt.Rows.Count - 1) As String
    '        Dim y(dt.Rows.Count - 1) As Integer

    '        For i = 0 To dt.Rows.Count - 1 Step 1
    '            x(i) = dt.Rows(i)(0).ToString()
    '            y(i) = Convert.ToInt32(dt.Rows(i)(1))
    '        Next

    '        crtChaserByUser.Series(0).Points.DataBindXY(x, y)
    '        crtChaserByUser.Series(0).ChartType = Convert.ToInt32(drpChartType.SelectedValue)
    '        crtChaserByUser.Series(0).Label = "#VALY" ' "#PERCENT{P0}"
    '        crtChaserByUser.Series(0).LegendText = "#AXISLABEL"
    '        crtChaserByUser.ChartAreas("ChartArea1").Area3DStyle.Enable3D = Convert.ToBoolean(drp3DEnabled.SelectedValue)
    '        crtChaserByUser.Legends(0).Enabled = True
    '    Catch ex As Exception
    '        MessageBox(ex.Message)
    '    End Try

    'End Sub

    Protected Sub grdGlobalView_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdGlobalView.SelectedIndexChanged
        ShowGraphDataByUser()
    End Sub

    Protected Sub grdGlobalView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdGlobalView.RowDataBound
        Dim lnkbtnPending, lnkbtnForwarded, lnkbtnTerminated As New LinkButton()

        If e.Row.RowType = DataControlRowType.DataRow Then
            lnkbtnPending = e.Row.FindControl("lnkbtnPending")
            lnkbtnForwarded = e.Row.FindControl("lnkbtnForwarded")
            lnkbtnTerminated = e.Row.FindControl("lnkbtnTerminated")

            Pending += Convert.ToInt32(lnkbtnPending.Text)
            Forwarded += Convert.ToInt32(lnkbtnForwarded.Text)
            Terminated += Convert.ToInt32(lnkbtnTerminated.Text)

        End If

        If e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(2).Text = "Total : "
            e.Row.Cells(3).Text = Pending.ToString()
            e.Row.Cells(4).Text = Forwarded.ToString()
            e.Row.Cells(5).Text = Terminated.ToString()
        End If
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnShow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShow.Click
        If grdGlobalView.SelectedIndex <> -1 Then
            ShowGraphDataByUser()
        End If

    End Sub

End Class
