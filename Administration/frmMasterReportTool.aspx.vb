Imports System.Data

Partial Class Administration_frmMasterReportTool
    Inherits System.Web.UI.Page

    Dim ChaseDefData As New clsChaseDefinitionDataAccess()
    Dim CtrlData As New clsControlListDataAccess()
    Dim MasterRptData As New clsMasterReportDataAccess()

    Protected Function FormatTable() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("ControlListID", System.Type.GetType("System.String"))
        dt.Columns.Add("ReportingHead", System.Type.GetType("System.String"))
        Return dt
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "MasterRptTool~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then
            ShowActiveChaseList()
            GetMasterRptLstDetails()

            Dim dtChosenItems As New DataTable
            dtChosenItems = FormatTable()
            Session("dtChosenItems") = dtChosenItems

            btnSave.Enabled = False
            btnUpdate.Enabled = False

        End If
    End Sub

    Protected Sub ShowActiveChaseList()
        drpChaseList.DataTextField = "ChaseName"
        drpChaseList.DataValueField = "ChaseDefinitionID"
        drpChaseList.DataSource = ChaseDefData.fnGetChaseDefListActive()
        drpChaseList.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpChaseList.Items.Insert(0, A)

    End Sub

    Protected Sub GetRptHeader(ByVal ChaseDefinitionID As String)
        lstbxReportHeader.DataTextField = "ReportingHead"
        lstbxReportHeader.DataValueField = "ControlListID"
        lstbxReportHeader.DataSource = CtrlData.fnGetRptHeaderByChaseDefID(ChaseDefinitionID)
        lstbxReportHeader.DataBind()
    End Sub

    Protected Sub drpChaseList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpChaseList.SelectedIndexChanged
        If drpChaseList.SelectedValue = "N\A" Then
            btnSave.Enabled = False
            ClearList()
        Else
            GetRptHeader(drpChaseList.SelectedValue)
            btnSave.Enabled = True
        End If

        btnUpdate.Enabled = False

    End Sub

    Protected Sub ClearList()
        lstbxReportHeader.DataSource = ""
        lstbxReportHeader.DataBind()

        lstbxChosenItems.DataSource = ""
        lstbxChosenItems.DataBind()
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        If lstbxReportHeader.SelectedIndex = -1 Then
            MessageBox("Select An Item First.")
            Exit Sub
        End If

        If CheckForExisting(lstbxReportHeader.SelectedValue) = True Then
            MessageBox("Item Already Exists In The List.")
            Exit Sub
        Else
            lstbxChosenItems.DataTextField = "ReportingHead"
            lstbxChosenItems.DataValueField = "ControlListID"

            lstbxChosenItems.DataSource = InsertRep(lstbxReportHeader.SelectedValue, lstbxReportHeader.SelectedItem.Text)
            lstbxChosenItems.DataBind()
        End If
    End Sub

    Protected Function InsertRep(ByVal ControlListID As String, ByVal ReportingHead As String) As DataTable
        Dim dtChosenItems As DataTable = New DataTable()
        dtChosenItems = Session("dtChosenItems")

        Dim dr As DataRow
        dr = dtChosenItems.NewRow()
        dr("ControlListID") = ControlListID
        dr("ReportingHead") = ReportingHead

        dtChosenItems.Rows.Add(dr)
        dtChosenItems.AcceptChanges()

        Session("dtChosenItems") = dtChosenItems

        Return dtChosenItems
    End Function

    Protected Function CheckForExisting(ByVal ControlListID As String) As Boolean
        Dim IsExists As Boolean = False
        For Each itm As ListItem In lstbxChosenItems.Items
            If itm.Value = ControlListID Then
                IsExists = True
                Exit For
            End If
        Next

        Return IsExists
    End Function

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnRemove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRemove.Click
        If lstbxChosenItems.SelectedIndex = -1 Then
            MessageBox("Select An Item First.")
            Exit Sub
        End If

        lstbxChosenItems.DataTextField = "ReportingHead"
        lstbxChosenItems.DataValueField = "ControlListID"
        lstbxChosenItems.DataSource = RemoveRep(lstbxChosenItems.SelectedIndex)
        lstbxChosenItems.DataBind()
    End Sub

    Protected Function RemoveRep(ByVal Index As Integer) As DataTable
        Dim dtChosenItems As DataTable = New DataTable()
        dtChosenItems = Session("dtChosenItems")

        dtChosenItems.Rows(Index).Delete()
        dtChosenItems.AcceptChanges()

        Return dtChosenItems
    End Function


    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        Dim MasterReport As New clsMasterReport()


        Dim dtChosenItems As New DataTable
        dtChosenItems = Session("dtChosenItems")

        Dim ControlListIDLst As String = ""
        For Each itm As DataRow In dtChosenItems.Rows
            ControlListIDLst += itm("ControlListID") + ","
        Next

        If ControlListIDLst = "" Then
            MessageBox("Report Field Can't Be Empty")
            Exit Sub
        Else
            ControlListIDLst = ControlListIDLst.Remove(Len(ControlListIDLst) - 1, 1)
        End If

        MasterReport.ChaseDefinitionID = drpChaseList.SelectedValue
        MasterReport.ReportName = txtReportHeaderName.Text

        If chkIsActive.Checked = True Then
            MasterReport.IsActive = True
        Else
            MasterReport.IsActive = False
        End If

        MasterReport.ControlListIDLst = ControlListIDLst
        MasterReport.EntryBy = Session("UserID")

        Dim result As clsResult = MasterRptData.fnInsertMasterReport(MasterReport)

        If result.Success = True Then
            ClearList()
            ClearAll()
            GetMasterRptLstDetails()
        End If

        MessageBox(result.Message)

    End Sub

    Protected Sub ClearAll()
        txtReportHeaderName.Text = ""
        chkIsActive.Checked = False
        drpChaseList.Enabled = True

        If grdMasterReports.Rows.Count > 0 Then
            grdMasterReports.SelectedIndex = -1
        End If

        btnSave.Enabled = True
        btnUpdate.Enabled = False
        drpChaseList.Enabled = True

    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim MasterReport As New clsMasterReport()


        Dim dtChosenItems As New DataTable
        dtChosenItems = Session("dtChosenItems")

        Dim ControlListIDLst As String = ""
        For Each itm As DataRow In dtChosenItems.Rows
            ControlListIDLst += itm("ControlListID") + ","
        Next

        If ControlListIDLst = "" Then
            MessageBox("Report Field Can't Be Empty")
            Exit Sub
        Else
            ControlListIDLst = ControlListIDLst.Remove(Len(ControlListIDLst) - 1, 1)
        End If

        MasterReport.MasterReportID = hdFldMasterReportID.Value
        MasterReport.ChaseDefinitionID = drpChaseList.SelectedValue
        MasterReport.ReportName = txtReportHeaderName.Text

        If chkIsActive.Checked = True Then
            MasterReport.IsActive = True
        Else
            MasterReport.IsActive = False
        End If

        MasterReport.ControlListIDLst = ControlListIDLst
        MasterReport.EntryBy = Session("UserID")

        Dim result As clsResult = MasterRptData.fnUpdateMasterReport(MasterReport)

        If result.Success = True Then
            ClearList()
            ClearAll()
            GetMasterRptLstDetails()
        End If

        MessageBox(result.Message)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearList()
        ClearAll()
    End Sub

    Protected Sub GetMasterRptLstDetails()
        grdMasterReports.DataSource = MasterRptData.fnGetMasterRportLstDetails()
        grdMasterReports.DataBind()
    End Sub

    Protected Sub GetReportHeaderByMasterID(ByVal MasterReportID As String)
        lstbxChosenItems.DataTextField = "ReportingHead"
        lstbxChosenItems.DataValueField = "ControlListID"
        lstbxChosenItems.DataSource = MasterRptData.fnGetReportHeaderByMasterID(MasterReportID)
        lstbxChosenItems.DataBind()

        Dim dtChosenItems As New DataTable
        dtChosenItems = FormatTable()
        dtChosenItems = MasterRptData.fnGetReportHeaderByMasterID(MasterReportID).Tables(0)
        Session("dtChosenItems") = dtChosenItems

    End Sub

    Protected Sub grdMasterReports_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdMasterReports.SelectedIndexChanged
        Dim lblMasterReportID, lblChaseDefinitionID, lblReportName, lblIsActive As New Label

        lblMasterReportID = grdMasterReports.SelectedRow.FindControl("lblMasterReportID")
        lblChaseDefinitionID = grdMasterReports.SelectedRow.FindControl("lblChaseDefinitionID")
        lblReportName = grdMasterReports.SelectedRow.FindControl("lblReportName")
        lblIsActive = grdMasterReports.SelectedRow.FindControl("lblIsActive")

        hdFldMasterReportID.Value = lblMasterReportID.Text
        txtReportHeaderName.Text = lblReportName.Text

        If lblIsActive.Text = "YES" Then
            chkIsActive.Checked = True
        Else
            chkIsActive.Checked = False
        End If

        GetReportHeaderByMasterID(lblMasterReportID.Text)
        drpChaseList.SelectedValue = lblChaseDefinitionID.Text
        GetRptHeader(drpChaseList.SelectedValue)

        drpChaseList.Enabled = False
        btnUpdate.Enabled = True
        btnSave.Enabled = False
    End Sub


End Class
