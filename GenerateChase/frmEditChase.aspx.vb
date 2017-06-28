Imports System.Data

Partial Class GenerateChase_frmEditChase
    Inherits System.Web.UI.Page

    Dim GenChaseData As New clsGeneratedChaseDataAccess()

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        SearchChase(txtChaseOrID.Text)
    End Sub

    Protected Sub SearchChase(ByVal ChaseNameOrID As String)
        grdChaserReportDetails.DataSource = GenChaseData.fnSearchChaseByIDorName(ChaseNameOrID)
        grdChaserReportDetails.DataBind()
    End Sub

    Protected Sub grdChaserReportDetails_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdChaserReportDetails.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()
        End If
    End Sub
End Class
