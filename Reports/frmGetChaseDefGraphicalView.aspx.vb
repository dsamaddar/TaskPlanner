Imports System.Data

Partial Class Reports_frmGetChaseDefGraphicalView
    Inherits System.Web.UI.Page

    Dim GenChaseData As New clsGeneratedChaseDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim CategoryID As String = Request.QueryString("CategoryID")


            grdCDGraphData.DataSource = GenChaseData.fnGetChaseDefWiseGraphicalData(CategoryID)
            grdCDGraphData.DataBind()

            GetGraphicalData(CategoryID)

        End If
    End Sub

    Protected Sub GetGraphicalData(ByVal CategoryID As String)
        Dim i As Integer = 0
        Dim dt As New DataTable()
        Try
            dt = GenChaseData.fnGetChaseDefWiseGraphicalData(CategoryID).Tables(0)

            Dim x(dt.Rows.Count - 1) As String
            Dim y(dt.Rows.Count - 1) As Integer

            For i = 0 To dt.Rows.Count - 1 Step 1
                x(i) = dt.Rows(i)(0).ToString()
                y(i) = Convert.ToInt32(dt.Rows(i)(1))
            Next

            crtChaserCategoryWiseview.Series(0).Points.DataBindXY(x, y)
            crtChaserCategoryWiseview.Series(0).ChartType = Convert.ToInt32(drpChartType.SelectedValue)
            crtChaserCategoryWiseview.Series(0).Label = "#VALY" ' "#PERCENT{P0}"
            crtChaserCategoryWiseview.Series(0).LegendText = "#AXISLABEL"
            crtChaserCategoryWiseview.ChartAreas("ChartArea1").Area3DStyle.Enable3D = Convert.ToBoolean(drp3DEnabled.SelectedValue)
            crtChaserCategoryWiseview.Legends(0).Enabled = True
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

    Protected Sub drp3DEnabled_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drp3DEnabled.SelectedIndexChanged
        Dim CategoryID As String = Request.QueryString("CategoryID")
        GetGraphicalData(CategoryID)
    End Sub

    Protected Sub drpChartType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpChartType.SelectedIndexChanged
        Dim CategoryID As String = Request.QueryString("CategoryID")
        GetGraphicalData(CategoryID)
    End Sub

End Class
