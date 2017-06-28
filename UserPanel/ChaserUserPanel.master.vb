
Partial Class UserPanel_ChaserUserPanel
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblEmpName.Text = "Welcome " + Session("EmployeeName") + " ! "
        End If
    End Sub
End Class

