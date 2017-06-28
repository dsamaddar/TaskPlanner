Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.UI.DataVisualization.Charting
Imports System.Drawing
Imports System.IO
Imports System.Text
Imports iTextSharp.text.pdf

Partial Class Reports_frmGraphicalView
    Inherits System.Web.UI.Page

    Public con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ChaserConnectionString").ConnectionString)
    Public con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NorthWind").ConnectionString)
    Public conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ViewChart()
        End If
    End Sub

    Protected Sub ViewChart()

        Try
            Dim ds As New DataSet()
            Dim dt As New DataTable()
            Dim da As New SqlDataAdapter()
            Dim i As Integer = 0

            con2.Open()

            Dim cmdstr As String = "select top 6 Country, COUNT(CompanyName) [Total Suppliers] from [Suppliers] group by Country"

            Dim cmd As New SqlCommand(cmdstr, con2)

            da.SelectCommand = cmd


            da.Fill(ds)

            dt = ds.Tables(0)

            Dim x(dt.Rows.Count - 1) As String
            Dim y(dt.Rows.Count - 1) As Integer

            For i = 0 To dt.Rows.Count - 1 Step 1
                x(i) = dt.Rows(i)(0).ToString()
                y(i) = Convert.ToInt32(dt.Rows(i)(1))
            Next

            crtChaser.Series(0).Points.DataBindXY(x, y)
            crtChaser.Series(0).ChartType = Convert.ToInt32(drpChartType.SelectedValue)
            crtChaser.ChartAreas("ChartArea1").Area3DStyle.Enable3D = Convert.ToBoolean(drp3DEnabled.SelectedValue)
            crtChaser.Legends(0).Enabled = True

            con2.Close()

        Catch ex As Exception
            con2.Close()
        End Try


        
    End Sub

    Protected Sub btnShowReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowReport.Click
        ViewChart()
    End Sub

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExport.Click

        '' Specify the content type. 
        'Response.ContentType = "application/pdf"
        '' Add a Content-Disposition header. 
        'Response.AddHeader("Content-Disposition", [String].Format("attachment; filename={0}.pdf", "test"))
        '' Render the chart. 
        'Utilities.DisplayChart(crtChaser)


        ''#Region "Generate the exported content and send it to the client." 
        ''Create a Document object 
        'Dim doc As New Document()


        'Try
        '    ' Create a writer to dump the contents of the Document to the Response.OutputStream stream 
        '    Dim writer As PdfWriter = PdfWriter.GetInstance(doc, Response.OutputStream)
        '    doc.Open()


        '    ' Now create the chart image and add it to the PDF 
        '    Using imgStream As New MemoryStream()
        '        ' Save the chart to a MemoryStream 
        '        crtChaser.SaveImage(imgStream, ChartImageFormat.Png)


        '        ' Create an Image object from the MemoryStream data 
        '        Dim img As Image = Image.GetInstance(imgStream.ToArray())


        '        ' Scale the Image object to fit within the boundary of the PDF document and add it 
        '        img.ScaleToFit(doc.PageSize.Width - (doc.LeftMargin + doc.RightMargin), doc.PageSize.Height - (doc.TopMargin + doc.BottomMargin))
        '        doc.Add(img)
        '    End Using
        'Finally
        '    doc.Close()
        'End Try
        ''#End Region 


        '' Indicate that the data to send to the client has ended 
        'Response.[End]()


    End Sub
End Class
