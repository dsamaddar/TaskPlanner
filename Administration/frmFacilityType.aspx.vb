
Partial Class Administration_frmFacilityType
    Inherits System.Web.UI.Page

    Dim FacilityTypeData As New clsFacilityTypeDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "FacilityType~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then
            GetAllFacilityType()
            btnSubmit.Enabled = True
            btnUpdate.Enabled = False
        End If
    End Sub

    Protected Sub GetAllFacilityType()
        grdFacilityType.DataSource = FacilityTypeData.fnGetFacilityType()
        grdFacilityType.DataBind()
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        Dim FacilityType As New clsFacilityType()
        FacilityType.FacilityType = txtFacilityType.Text
        If chkIsActive.Checked = True Then
            FacilityType.IsActive = True
        Else
            FacilityType.IsActive = False
        End If
        FacilityType.EntryBy = Session("UserID")

        Dim Result As clsResult = FacilityTypeData.fnInsertFacilityType(FacilityType)

        If Result.Success = True Then
            ClearForm()
            GetAllFacilityType()
        End If

        MessageBox(Result.Message)

    End Sub

    Protected Sub ClearForm()
        txtFacilityType.Text = ""
        chkIsActive.Checked = False

        If grdFacilityType.Rows.Count > 0 Then
            grdFacilityType.SelectedIndex = -1
        End If

        btnSubmit.Enabled = True
        btnUpdate.Enabled = False

    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click

        If hdFldFacilityTypeID.Value = "" Then
            MessageBox("Select An Item from the First.")
            Exit Sub
        End If

        Dim FacilityType As New clsFacilityType()

        FacilityType.FacilityTypeID = hdFldFacilityTypeID.Value
        FacilityType.FacilityType = txtFacilityType.Text
        If chkIsActive.Checked = True Then
            FacilityType.IsActive = True
        Else
            FacilityType.IsActive = False
        End If
        FacilityType.EntryBy = Session("UserID")

        Dim Result As clsResult = FacilityTypeData.fnUpdateFacilityType(FacilityType)

        If Result.Success = True Then
            ClearForm()
            GetAllFacilityType()
        End If

        MessageBox(Result.Message)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub grdFacilityType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdFacilityType.SelectedIndexChanged
        Dim lblFacilityTypeID, lblFacilityType, lblIsActive As New Label

        lblFacilityTypeID = grdFacilityType.SelectedRow.FindControl("lblFacilityTypeID")
        lblFacilityType = grdFacilityType.SelectedRow.FindControl("lblFacilityType")
        lblIsActive = grdFacilityType.SelectedRow.FindControl("lblIsActive")

        hdFldFacilityTypeID.Value = lblFacilityTypeID.Text
        txtFacilityType.Text = lblFacilityType.Text

        If lblIsActive.Text = "YES" Then
            chkIsActive.Checked = True
        Else
            chkIsActive.Checked = False
        End If

        btnSubmit.Enabled = False
        btnUpdate.Enabled = True

    End Sub

End Class
