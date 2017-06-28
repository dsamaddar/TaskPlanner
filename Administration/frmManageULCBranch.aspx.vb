
Partial Class Administration_frmManageULCBranch
    Inherits System.Web.UI.Page

    Dim ULCBranchData As New clsULCBranch()

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        Dim ULCBranch As New clsULCBranch()
        ULCBranch.ULCBranchName = txtBranchName.Text
        ULCBranch.BranchLocation = txtBranchLocation.Text

        If chkIsActive.Checked = True Then
            ULCBranch.isActive = True
        Else
            ULCBranch.isActive = False
        End If
        ULCBranch.EntryBy = Session("UserID")
        Dim check As Integer = ULCBranchData.fnInsertULCBranch(ULCBranch)

        If check = 1 Then
            MessageBox("Inserted Successfully.")
            ClearForm()
            ShowULCBranch()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "MngULCBranch~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If


        If Not IsPostBack Then
            ShowULCBranch()
            btnSubmit.Visible = True
            btnUpdate.Visible = False
        End If
    End Sub

    Protected Sub ShowULCBranch()
        grdULCBranch.DataSource = ULCBranchData.fnGetTotalULCBranch()
        grdULCBranch.DataBind()
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim ULCBranch As New clsULCBranch()

        If hdFldULCBranchID.Value = "" Then
            MessageBox("Select A Branch First.")
            Exit Sub
        End If

        ULCBranch.ULCBranchID = hdFldULCBranchID.Value
        ULCBranch.ULCBranchName = txtBranchName.Text
        ULCBranch.BranchLocation = txtBranchLocation.Text

        If chkIsActive.Checked = True Then
            ULCBranch.isActive = True
        Else
            ULCBranch.isActive = False
        End If
        ULCBranch.EntryBy = Session("LoginUserID")
        Dim check As Integer = ULCBranchData.fnUpdateULCBranch(ULCBranch)

        If check = 1 Then
            MessageBox("Updated Successfully.")
            ClearForm()
            ShowULCBranch()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()
        txtBranchName.Text = ""
        txtBranchLocation.Text = ""
        chkIsActive.Checked = False
        grdULCBranch.SelectedIndex = -1
        btnSubmit.Visible = True
        btnUpdate.Visible = False
    End Sub

    Protected Sub grdULCBranch_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdULCBranch.SelectedIndexChanged
        Dim lblULCBranchID, lblisActive, lblULCBranchName, lblBranchLocation As New Label

        lblULCBranchID = grdULCBranch.SelectedRow.FindControl("lblULCBranchID")
        lblULCBranchName = grdULCBranch.SelectedRow.FindControl("lblULCBranchName")
        lblBranchLocation = grdULCBranch.SelectedRow.FindControl("lblBranchLocation")
        lblisActive = grdULCBranch.SelectedRow.FindControl("lblisActive")

        hdFldULCBranchID.Value = lblULCBranchID.Text
        txtBranchName.Text = lblULCBranchName.Text
        txtBranchLocation.Text = lblBranchLocation.Text

        If lblisActive.Text = "YES" Then
            chkIsActive.Checked = True
        Else
            chkIsActive.Checked = False
        End If

        btnSubmit.Visible = False
        btnUpdate.Visible = True

    End Sub
End Class
