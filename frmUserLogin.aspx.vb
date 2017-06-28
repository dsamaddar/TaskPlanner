
Partial Class frmUserLogin
    Inherits System.Web.UI.Page

    Dim EmpInfoData As New clsEmployeeInfoDataAccess()

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.Click
        Dim EmpInfo As New clsEmployeeInfo()
        EmpInfo.UserID = txtUserID.Text
        EmpInfo.UserPassword = txtPassword.Text

        EmpInfo = EmpInfoData.fnCheckUserLogin(EmpInfo)

        If EmpInfo.EmployeeID = "" Or EmpInfo.EmployeeID = Nothing Then
            MessageBox("Provide Correct Credentials")
            txtPassword.Text = ""
            txtUserID.Text = ""
        Else
            FormsAuthentication.RedirectFromLoginPage(EmpInfo.UserID, False)
            Session("EmployeeID") = EmpInfo.EmployeeID
            Session("UserID") = EmpInfo.UserID
            Session("UserType") = EmpInfo.UserType
            Session("EmployeeName") = EmpInfo.EmployeeName

            Response.Redirect("~/Administration/frmEmployeeInfo.aspx")

        End If

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        txtPassword.Text = ""
        txtUserID.Text = ""
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Session("EmployeeID") = ""
            Session("UserID") = ""
            Session("UserType") = ""
            Session("EmployeeName") = ""
        End If
    End Sub
End Class
