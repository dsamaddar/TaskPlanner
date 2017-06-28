
Partial Class frmMktInfoRatingPrimary
    Inherits System.Web.UI.Page

    Dim MktInfoData As New clsMarketInfoDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "PrimaryRating~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then
            GetPendingMktInfoPrimary()
        End If
    End Sub

    Protected Sub GetPendingMktInfoPrimary()
        grdMktInfo.DataSource = MktInfoData.fnGetAllPrimaryRep()
        grdMktInfo.DataBind()
    End Sub

    Protected Sub grdMktInfo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdMktInfo.SelectedIndexChanged

        Dim lblMarketInfoID As New Label
        lblMarketInfoID = grdMktInfo.SelectedRow.FindControl("lblMarketInfoID")

        hdFldMktInfoID.Value = lblMarketInfoID.Text



    End Sub

    Protected Sub btnRateVisit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRateVisit.Click

        If hdFldMktInfoID.Value = "" Then
            MessageBox("Select A Visit Report First.")
            Exit Sub
        End If

        Dim MktInfo As New clsMarketInfo()
        MktInfo.MarketInfoID = hdFldMktInfoID.Value
        MktInfo.PrimaryRating = drpRating.SelectedValue
        MktInfo.PrimaryRemarks = txtPrimaryRemarks.Text

        Dim result As clsResult = MktInfoData.fnPrimaryRatingMktInfo(MktInfo)

        If result.Success = True Then
            ClearForm()
        End If

        MessageBox(result.Message)

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
       

    End Sub

    Protected Sub ClearForm()
        grdMktInfo.SelectedIndex = -1
        txtPrimaryRemarks.Text = ""
        drpRating.SelectedIndex = -1
        hdFldMktInfoID.Value = ""
        GetPendingMktInfoPrimary()
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

End Class
