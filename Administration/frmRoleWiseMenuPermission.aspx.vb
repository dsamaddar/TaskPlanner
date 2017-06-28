
Partial Class Administration_frmRoleWiseMenuPermission
    Inherits System.Web.UI.Page

    Dim MenuData As New clsMenuDataAccess()
    Dim RoleData As New clsRoleDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "RoleWiseMenu~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then

            ShowRoleList()

            ShowMenuList(grdAdministrationMenu, "Administration")
            ShowMenuList(grdVoiceDataCollection, "VoiceData")
            ShowMenuList(grdGenerateChase, "GenerateChase")
            ShowMenuList(grdUserWiseChase, "UserWiseChase")
            ShowMenuList(grdReports, "Reports")
            ShowMenuList(grdMarketInfoMenu, "MarketInfo")
        End If
    End Sub

    Protected Sub ShowMenuList(ByVal grd As GridView, ByVal MenuGroupID As String)
        grd.DataSource = MenuData.fnGetMenuListByGroup(MenuGroupID)
        grd.DataBind()
    End Sub

    Protected Sub ShowRoleList()
        drpRoleList.DataTextField = "RoleName"
        drpRoleList.DataValueField = "RoleID"
        drpRoleList.DataSource = RoleData.fnGetRoleList()
        drpRoleList.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpRoleList.Items.Insert(0, A)
    End Sub

    Protected Sub GetMenuPermission(ByVal MenuIDList As String)

        Dim chkSelectAdminMenu, chkSelectVoiceDataCollMenu, chkSelectGenerateChaseMenu, chkSelectUserWiseChaseMenu, chkSelectReports, chkSelectMarketInfo As New CheckBox()
        Dim lblAdminMenuID, lblVoiceDataMenuID, lblGenerateChaseMenuID, lblUserWiseChaseMenuID, lblReportsID, lblMarketInfoMenuID As New Label()

        For Each rw As GridViewRow In grdAdministrationMenu.Rows
            lblAdminMenuID = rw.FindControl("lblAdminMenuID")
            If MenuIDList.Contains(lblAdminMenuID.Text) Then
                chkSelectAdminMenu = rw.FindControl("chkSelectAdminMenu")
                chkSelectAdminMenu.Checked = True
                rw.ForeColor = Drawing.Color.Green
                rw.Font.Bold = True
            End If
        Next

        For Each rw As GridViewRow In grdVoiceDataCollection.Rows
            lblVoiceDataMenuID = rw.FindControl("lblVoiceDataMenuID")
            If MenuIDList.Contains(lblVoiceDataMenuID.Text) Then
                chkSelectVoiceDataCollMenu = rw.FindControl("chkSelectVoiceDataCollMenu")
                chkSelectVoiceDataCollMenu.Checked = True
                rw.ForeColor = Drawing.Color.Green
                rw.Font.Bold = True
            End If
        Next

        For Each rw As GridViewRow In grdGenerateChase.Rows
            lblGenerateChaseMenuID = rw.FindControl("lblGenerateChaseMenuID")
            If MenuIDList.Contains(lblGenerateChaseMenuID.Text) Then
                chkSelectGenerateChaseMenu = rw.FindControl("chkSelectGenerateChaseMenu")
                chkSelectGenerateChaseMenu.Checked = True
                rw.ForeColor = Drawing.Color.Green
                rw.Font.Bold = True
            End If
        Next

        For Each rw As GridViewRow In grdUserWiseChase.Rows
            lblUserWiseChaseMenuID = rw.FindControl("lblUserWiseChaseMenuID")
            If MenuIDList.Contains(lblUserWiseChaseMenuID.Text) Then
                chkSelectUserWiseChaseMenu = rw.FindControl("chkSelectUserWiseChaseMenu")
                chkSelectUserWiseChaseMenu.Checked = True
                rw.ForeColor = Drawing.Color.Green
                rw.Font.Bold = True
            End If
        Next

        For Each rw As GridViewRow In grdReports.Rows
            lblReportsID = rw.FindControl("lblReportsID")
            If MenuIDList.Contains(lblReportsID.Text) Then
                chkSelectReports = rw.FindControl("chkSelectReports")
                chkSelectReports.Checked = True
                rw.ForeColor = Drawing.Color.Green
                rw.Font.Bold = True
            End If
        Next

        For Each rw As GridViewRow In grdMarketInfoMenu.Rows
            lblMarketInfoMenuID = rw.FindControl("lblMarketInfoMenuID")
            If MenuIDList.Contains(lblMarketInfoMenuID.Text) Then
                chkSelectMarketInfo = rw.FindControl("chkSelectMarketInfo")
                chkSelectMarketInfo.Checked = True
                rw.ForeColor = Drawing.Color.Green
                rw.Font.Bold = True
            End If
        Next

    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        If drpRoleList.SelectedValue = "N\A" Then
            MessageBox("Select Proper Role")
            Exit Sub
        End If

        Dim MenuIDList As String = ""

        Dim chkSelectAdminMenu, chkSelectVoiceDataCollMenu, chkSelectGenerateChaseMenu, chkSelectUserWiseChaseMenu, chkSelectReports, chkSelectMarketInfo As New CheckBox()
        Dim lblAdminMenuID, lblVoiceDataMenuID, lblGenerateChaseMenuID, lblUserWiseChaseMenuID, lblReportsID, lblMarketInfoMenuID As New Label()

        For Each rw As GridViewRow In grdAdministrationMenu.Rows
            chkSelectAdminMenu = rw.FindControl("chkSelectAdminMenu")

            If chkSelectAdminMenu.Checked = True Then
                lblAdminMenuID = rw.FindControl("lblAdminMenuID")
                MenuIDList += lblAdminMenuID.Text & "~"
            End If
        Next

        For Each rw As GridViewRow In grdVoiceDataCollection.Rows
            chkSelectVoiceDataCollMenu = rw.FindControl("chkSelectVoiceDataCollMenu")

            If chkSelectVoiceDataCollMenu.Checked = True Then
                lblVoiceDataMenuID = rw.FindControl("lblVoiceDataMenuID")
                MenuIDList += lblVoiceDataMenuID.Text & "~"
            End If
        Next

        For Each rw As GridViewRow In grdGenerateChase.Rows
            chkSelectGenerateChaseMenu = rw.FindControl("chkSelectGenerateChaseMenu")

            If chkSelectGenerateChaseMenu.Checked = True Then
                lblGenerateChaseMenuID = rw.FindControl("lblGenerateChaseMenuID")
                MenuIDList += lblGenerateChaseMenuID.Text & "~"
            End If
        Next

        For Each rw As GridViewRow In grdUserWiseChase.Rows
            chkSelectUserWiseChaseMenu = rw.FindControl("chkSelectUserWiseChaseMenu")

            If chkSelectUserWiseChaseMenu.Checked = True Then
                lblUserWiseChaseMenuID = rw.FindControl("lblUserWiseChaseMenuID")
                MenuIDList += lblUserWiseChaseMenuID.Text & "~"
            End If
        Next

        For Each rw As GridViewRow In grdReports.Rows
            chkSelectReports = rw.FindControl("chkSelectReports")

            If chkSelectReports.Checked = True Then
                lblReportsID = rw.FindControl("lblReportsID")
                MenuIDList += lblReportsID.Text & "~"
            End If
        Next

        For Each rw As GridViewRow In grdMarketInfoMenu.Rows()
            chkSelectMarketInfo = rw.FindControl("chkSelectMarketInfo")

            If chkSelectMarketInfo.Checked = True Then
                lblMarketInfoMenuID = rw.FindControl("lblMarketInfoMenuID")
                MenuIDList += lblMarketInfoMenuID.Text & "~"
            End If
        Next

        Dim Role As New clsRole()

        Role.RoleID = drpRoleList.SelectedValue
        Role.MenuIDList = MenuIDList
        Role.LastUpdatedBy = Session("UserID")

        Dim Check As Integer = RoleData.fnUpdateRolePermission(Role)

        If Check = 1 Then
            MessageBox("Successfully Inserted.")
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub ClearMenuSelection()

        Dim chkSelectAdminMenu, chkSelectVoiceDataCollMenu, chkSelectGenerateChaseMenu, chkSelectUserWiseChaseMenu, chkSelectReports, chkSelectMarketInfo As New CheckBox()

        For Each rw As GridViewRow In grdAdministrationMenu.Rows
            chkSelectAdminMenu = rw.FindControl("chkSelectAdminMenu")
            If chkSelectAdminMenu.Checked = True Then
                chkSelectAdminMenu.Checked = False
                rw.ForeColor = Drawing.Color.Black
                rw.Font.Bold = False
            End If
        Next

        For Each rw As GridViewRow In grdVoiceDataCollection.Rows
            chkSelectVoiceDataCollMenu = rw.FindControl("chkSelectVoiceDataCollMenu")
            If chkSelectVoiceDataCollMenu.Checked = True Then
                chkSelectVoiceDataCollMenu.Checked = False
                rw.ForeColor = Drawing.Color.Black
                rw.Font.Bold = False
            End If
        Next

        For Each rw As GridViewRow In grdGenerateChase.Rows
            chkSelectGenerateChaseMenu = rw.FindControl("chkSelectGenerateChaseMenu")
            If chkSelectGenerateChaseMenu.Checked = True Then
                chkSelectGenerateChaseMenu.Checked = False
                rw.ForeColor = Drawing.Color.Black
                rw.Font.Bold = False
            End If
        Next

        For Each rw As GridViewRow In grdUserWiseChase.Rows
            chkSelectUserWiseChaseMenu = rw.FindControl("chkSelectUserWiseChaseMenu")
            If chkSelectUserWiseChaseMenu.Checked = True Then
                chkSelectUserWiseChaseMenu.Checked = False
                rw.ForeColor = Drawing.Color.Black
                rw.Font.Bold = False
            End If
        Next

        For Each rw As GridViewRow In grdReports.Rows
            chkSelectReports = rw.FindControl("chkSelectReports")
            If chkSelectReports.Checked = True Then
                chkSelectReports.Checked = False
                rw.ForeColor = Drawing.Color.Black
                rw.Font.Bold = False
            End If
        Next

        For Each rw As GridViewRow In grdMarketInfoMenu.Rows()
            chkSelectMarketInfo = rw.FindControl("chkSelectMarketInfo")
            If chkSelectMarketInfo.Checked = True Then
                chkSelectMarketInfo.Checked = False
                rw.ForeColor = Drawing.Color.Black
                rw.Font.Bold = False
            End If
        Next

    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub drpRoleList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpRoleList.SelectedIndexChanged
        ClearMenuSelection()
        If drpRoleList.SelectedValue <> "N\A" Then

            Dim MenuIDList As String = RoleData.fnGetRoleWiseMenuIDs(drpRoleList.SelectedValue)
            GetMenuPermission(MenuIDList)
        Else

            MessageBox("Select Role Properly.")
            Exit Sub
        End If

    End Sub

End Class
