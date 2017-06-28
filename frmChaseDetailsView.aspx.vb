Imports System.Data
Imports System.Web.UI.DataVisualization.Charting

Partial Class frmChaseDetailsView
    Inherits System.Web.UI.Page


    Dim ChaseInputValueData As New clsChaseInputValuesDataAccess()
    Dim GenChaseData As New clsGeneratedChaseDataAccess()
    Dim ChaseNoteData As New clsChaseNotesDataAccess()
    Public TotalTimeTaken As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim GeneratedChaseID = Request.QueryString("GeneratedChaseID")
            ShowChaseInputValues(GeneratedChaseID)
            ShowChaseHistory(GeneratedChaseID)
            GetGraphicalData(GeneratedChaseID)
            GetChaseNotes(GeneratedChaseID)
            GetContactDetails(GeneratedChaseID)
            GetPriorityInfo(GeneratedChaseID)
        End If
    End Sub

    Protected Sub GetPriorityInfo(ByVal GeneratedChaseID As String)
        Dim Priority As clsPriority = GenChaseData.fnGetPriorityInfo(GeneratedChaseID)
        lblPriorityInfo.Text = Priority.PriorityText
    End Sub

    Protected Sub GetContactDetails(ByVal GeneratedChaseID As String)
        lblContactDetails.Text = GenChaseData.fnGetChaseContactDetails(GeneratedChaseID)
    End Sub

    Protected Sub ShowChaseInputValues(ByVal GeneratedChaseID As String)
        grdChaseInputValues.DataSource = ChaseInputValueData.fnGetChaseInputvalues(GeneratedChaseID)
        grdChaseInputValues.DataBind()
    End Sub

    Protected Sub ShowChaseHistory(ByVal GeneratedChaseID As String)
        grdChaseFeedBackHistory.DataSource = GenChaseData.fnGetChaseHistoryByGenChaseID(GeneratedChaseID)
        grdChaseFeedBackHistory.DataBind()
    End Sub

    Protected Sub GetGraphicalData(ByVal GeneratedChaseID As String)
        Dim i As Integer = 0
        Dim dt As New DataTable()
        Try
            dt = GenChaseData.fnGetDataForGraphicalView(GeneratedChaseID).Tables(0)

            Dim x(dt.Rows.Count - 1) As String
            Dim y(dt.Rows.Count - 1) As Integer

            For i = 0 To dt.Rows.Count - 1 Step 1
                x(i) = dt.Rows(i)(0).ToString()
                y(i) = Convert.ToInt32(dt.Rows(i)(1))
            Next

            crtChaser.Series(0).Points.DataBindXY(x, y)
            crtChaser.Series(0).ChartType = SeriesChartType.Pie
            crtChaser.Series(0).Label = "#VALY" + " min" ' "#PERCENT{P0}"
            crtChaser.Series(0).LegendText = "#AXISLABEL"
            crtChaser.ChartAreas("ChartArea1").Area3DStyle.Enable3D = True
            crtChaser.ChartAreas("ChartArea1").AxisX.Interval = 1
            crtChaser.Legends(0).Enabled = True
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

    Protected Sub grdChaseFeedBackHistory_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdChaseFeedBackHistory.RowDataBound

        Dim lblTimeTaken As New Label()

        Dim Day As Integer = 0
        Dim Hour As Integer = 0
        Dim Minute As Integer = 0

        If e.Row.RowType = DataControlRowType.DataRow Then
            lblTimeTaken = e.Row.FindControl("lblTimeTaken")

            TotalTimeTaken += Convert.ToInt32(lblTimeTaken.Text)

        End If

        If e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(6).Text = "Total Time Taken: "

            Dim minutes As Integer = TotalTimeTaken
            Dim ts As New TimeSpan(0, minutes, 0)

            If Day = Math.Round(ts.TotalDays, 0) < 0 Then
                Day = 0
            Else
                Day = Math.Round(ts.TotalDays, 0)
            End If


            If Math.Round(ts.TotalHours - Math.Round(ts.TotalDays, 0) * 24, 0) < 0 Then
                Hour = 0
            Else
                Hour = Math.Round(ts.TotalHours - Math.Round(ts.TotalDays, 0) * 24, 0)
            End If

            If Math.Round(ts.TotalMinutes - Math.Round(ts.TotalHours, 0) * 60, 0) < 0 Then
                Minute = 0
            Else
                Minute = Math.Round(ts.TotalMinutes - Math.Round(ts.TotalHours, 0) * 60, 0)
            End If

            e.Row.Cells(7).Text = String.Format("{0} d {1} h {2} m", Day, Hour, Minute)
        End If

    End Sub

    Protected Sub GetChaseNotes(ByVal MasterChaseID As String)
        grdNotesByChase.DataSource = ChaseNoteData.fnGetMasterChaseWiseNotes(MasterChaseID)
        grdNotesByChase.DataBind()
    End Sub

End Class
