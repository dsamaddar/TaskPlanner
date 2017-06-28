Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Class Reports_PDFFollowupStatusReport
    Inherits System.Web.UI.Page


    Protected Sub btnGenerateReport_Click(sender As Object, e As System.EventArgs) Handles btnGenerateReport.Click
        If txtDateFrom.Text = "" Then
            MessageBox("Please give date from")
            Exit Sub
        End If

        If txtDateTo.Text = "" Then
            MessageBox("Please give date to")
            Exit Sub
        End If

        If Convert.ToDateTime(txtDateFrom.Text) > Convert.ToDateTime(txtDateTo.Text) Then
            MessageBox("Date from can not greater than date to.")
            Exit Sub
        End If

        Dim myReport As New ReportDocument()
        Dim folder As String
        Dim f As String
        Dim repName As String

        Dim serverName As [String], uid As [String], pwd As [String], dbName As [String]

        Dim conStr = ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString
        Dim retArr As [String](), usrArr As [String](), pwdArr As [String](), serverArr As [String](), dbArr As [String]()

        Try
            f = "~/Reports/PDFFollowupStatus.rpt"
            folder = Server.MapPath(f)
            repName = folder
            myReport.Load(repName)

            retArr = conStr.Split(";")
            serverArr = retArr(0).Split("=")
            dbArr = retArr(1).Split("=")
            usrArr = retArr(2).Split("=")
            pwdArr = retArr(3).Split("=")

            serverName = serverArr(1)
            uid = usrArr(1)
            pwd = pwdArr(1)
            dbName = dbArr(1)

            myReport.SetDatabaseLogon(uid, pwd, serverName, dbName)

            Dim parameters As CrystalDecisions.Web.Parameter = New CrystalDecisions.Web.Parameter()
            myReport.SetParameterValue("@FromDate", Convert.ToDateTime(txtDateFrom.Text))
            myReport.SetParameterValue("@ToDate", Convert.ToDateTime(txtDateTo.Text))
            myReport.SetParameterValue("@FinalStatus", ddlFinalStatus.SelectedValue)
            myReport.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, True, "ExportedReport")
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

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtDateFrom.Text = Now.Date
            txtDateTo.Text = Now.Date
        End If
    End Sub
End Class
