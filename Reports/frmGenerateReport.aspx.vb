Imports System.Configuration
Imports System.IO
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.text.html.simpleparser

Partial Class Reports_frmGenerateReport
    Inherits System.Web.UI.Page

    Dim MasterReportData As New clsMasterReportDataAccess()
    Dim GenChaseData As New clsGeneratedChaseDataAccess()

    Protected Sub btnProcessReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcessReport.Click
        GetGeneratedReport()
    End Sub

    Protected Sub GetGeneratedReport()
        Try
            grdGeneratedReport.DataSource = GenChaseData.fnGenFormattedReport(drpReportFormat.SelectedValue, Convert.ToDateTime(txtDateFrom.Text), Convert.ToDateTime(txtDateTo.Text))
            grdGeneratedReport.DataBind()

            ShowGridValueInHTMLFormat()
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub ShowGridValueInHTMLFormat()

        Dim i As Integer = 0

        For Each row As GridViewRow In grdGeneratedReport.Rows
            For i = 0 To row.Cells.Count - 1
                If row.Cells(i).Text = "&nbsp;" Then
                    row.Cells(i).Text = ""
                Else
                    row.Cells(i).Text = Server.HtmlDecode(row.Cells(i).Text)
                End If

            Next
        Next

    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetActiveMasterReportList()
        End If
    End Sub

    Protected Sub GetActiveMasterReportList()
        drpReportFormat.DataTextField = "ReportName"
        drpReportFormat.DataValueField = "MasterReportID"
        drpReportFormat.DataSource = MasterReportData.fnGetActiveMasterRptList()
        drpReportFormat.DataBind()
    End Sub

    Protected Sub btnImgExportToXL_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnImgExportToXL.Click
        Try
            Dim sw As New StringWriter()
            Dim hw As New System.Web.UI.HtmlTextWriter(sw)
            Dim frm As HtmlForm = New HtmlForm()

            Page.Response.AddHeader("content-disposition", "attachment;filename=ChaseReports.xls")
            Page.Response.ContentType = "application/vnd.ms-excel"
            Page.Response.Charset = ""
            Page.EnableViewState = False
            frm.Attributes("runat") = "server"
            Controls.Add(frm)
            frm.Controls.Add(grdGeneratedReport)
            frm.RenderControl(hw)
            Response.Write(sw.ToString())
            Response.End()
        Catch ex As Exception

        End Try
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

End Class
