
Partial Class frmViewContactDetails
    Inherits System.Web.UI.Page

    Dim EmpInfoData As New clsEmployeeInfoDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim EmployeeID As String = Request.QueryString("EmployeeID")

            Try
                Dim EmpInfo As clsEmployeeInfo = EmpInfoData.fnGetEmpDetailsByID(EmployeeID)

                lblEmpName.Text = EmpInfo.EmployeeName
                lblBranch.Text = EmpInfo.ULCBranchName
                lblDepartment.Text = EmpInfo.Department
                lblDesignation.Text = EmpInfo.Designation
                lblEmail.Text = EmpInfo.MailAddress
                lblEmpCode.Text = EmpInfo.EmpCode
                lblMobileNo.Text = EmpInfo.MobileNo
                lblSupervisor.Text = EmpInfo.Supervisor
                lblUserID.Text = EmpInfo.UserID
            Catch ex As Exception
                MessageBox(ex.Message)
            End Try
        End If
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

End Class
