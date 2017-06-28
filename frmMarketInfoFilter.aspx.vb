
Partial Class frmMarketInfoFilter
    Inherits System.Web.UI.Page

    Dim MktInfoData As New clsMarketInfoDataAccess()

    Protected Sub btnShowReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowReport.Click

        Dim MktInfo As New clsMarketInfo()

        If txtDateFrom.Text = "" Then
            MktInfo.DateFrom = "1/1/1900"
        Else
            MktInfo.DateFrom = Convert.ToDateTime(txtDateFrom.Text)
        End If

        If txtDateTo.Text = "" Then
            MktInfo.DateTo = "1/1/1900"
        Else
            MktInfo.DateTo = Convert.ToDateTime(txtDateTo.Text)
        End If

        MktInfo.CPDesignation = drpContactType.SelectedValue
        MktInfo.DataStatus = drpPurpose.SelectedValue
        MktInfo.Status = drpRatingType.SelectedValue


        grdMktInfoFilter.DataSource = MktInfoData.fnMktInfoFilterReport(MktInfo)
        grdMktInfoFilter.DataBind()

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "AllMktInfo~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then

        End If
    End Sub



End Class
