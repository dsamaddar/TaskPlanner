
Partial Class Administration_frmPrioritySettings
    Inherits System.Web.UI.Page

    Dim PriorityData As New clsPriority()

    Protected Sub ClearPriorityForm()
        txtPriorityText.Text = ""
        chkIsActive.Checked = False
        drpTiming.SelectedIndex = -1

        btnSave.Enabled = True
        btnUpdate.Enabled = False

        grdPrirityDetails.SelectedIndex = -1
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim Priority As New clsPriority()

        Priority.PriorityText = txtPriorityText.Text
        Priority.Timing = Convert.ToInt32(drpTiming.SelectedValue)
        If chkIsActive.Checked = True Then
            Priority.IsActive = True
        Else
            Priority.IsActive = False
        End If

        Priority.EntryBy = Session("UserID")

        Dim res As clsResult = PriorityData.fnInsertPriority(Priority)

        If res.Success = True Then
            ClearPriorityForm()
            GetPriorityDetails()
        End If

        MessageBox(res.Message)

    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim Priority As New clsPriority()

        Priority.PriorityID = hdFldPriorityID.Value
        Priority.PriorityText = txtPriorityText.Text
        Priority.Timing = Convert.ToInt32(drpTiming.SelectedValue)
        If chkIsActive.Checked = True Then
            Priority.IsActive = True
        Else
            Priority.IsActive = False
        End If

        Priority.EntryBy = Session("UserID")

        Dim res As clsResult = PriorityData.fnUpdatePriority(Priority)

        If res.Success = True Then
            ClearPriorityForm()
            GetPriorityDetails()
        End If

        MessageBox(res.Message)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearPriorityForm()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "PrioritySett~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If


        If Not IsPostBack Then
            GetPriorityDetails()

            btnSave.Enabled = True
            btnUpdate.Enabled = False
        End If
    End Sub

    Protected Sub GetPriorityDetails()
        grdPrirityDetails.DataSource = PriorityData.fnGetPriorityDetails()
        grdPrirityDetails.DataBind()
    End Sub

    Protected Sub grdPrirityDetails_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdPrirityDetails.SelectedIndexChanged
        Dim lblPriorityID, lblPriorityText, lblTiming, lblIsActive, lblEntryBy As Label

        lblPriorityID = grdPrirityDetails.SelectedRow.FindControl("lblPriorityID")
        lblPriorityText = grdPrirityDetails.SelectedRow.FindControl("lblPriorityText")
        lblTiming = grdPrirityDetails.SelectedRow.FindControl("lblTiming")
        lblIsActive = grdPrirityDetails.SelectedRow.FindControl("lblIsActive")
        lblEntryBy = grdPrirityDetails.SelectedRow.FindControl("lblEntryBy")

        hdFldPriorityID.Value = lblPriorityID.Text
        txtPriorityText.Text = lblPriorityText.Text
        drpTiming.SelectedValue = lblTiming.Text

        If lblIsActive.Text = "YES" Then
            chkIsActive.Checked = True
        Else
            chkIsActive.Checked = False
        End If

        btnSave.Enabled = False
        btnUpdate.Enabled = True

    End Sub

End Class
