Imports System.Data

Public Class X
    Inherits System.Web.UI.Page

    Public Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub
End Class

Partial Class frmChangeAssignedPerson
    Inherits X

    Dim GenChaseData As New clsGeneratedChaseDataAccess()
    Dim EmpInfoData As New clsEmployeeInfoDataAccess()

    Protected Sub drpAssignmentPendUsers_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpAssignmentPendUsers.SelectedIndexChanged
        GetChasePendingAtUser(drpAssignmentPendUsers.SelectedValue)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetAssignmentPendingUsers()
            GetAllEmployees()
        End If
    End Sub

    Protected Sub GetChasePendingAtUser(ByVal AssignedToID As String)
        grdChasePendingAtUser.DataSource = GenChaseData.fnGetChasePendingAtUser(AssignedToID)
        grdChasePendingAtUser.DataBind()
    End Sub

    Protected Sub GetAllEmployees()

        drpAllEmpList.DataTextField = "EmployeeName"
        drpAllEmpList.DataValueField = "EmployeeID"
        drpAllEmpList.DataSource = EmpInfoData.fnGetEmployeeList()
        drpAllEmpList.DataBind()

    End Sub

    Protected Sub GetAssignmentPendingUsers()

        drpAssignmentPendUsers.DataTextField = "AssignedTo"
        drpAssignmentPendUsers.DataValueField = "AssignedToID"
        drpAssignmentPendUsers.DataSource = GenChaseData.fnGetAssignmentPendingUsr()
        drpAssignmentPendUsers.DataBind()

        Dim A As New ListItem
        A.Text = "All"
        A.Value = "All"

        drpAssignmentPendUsers.Items.Insert(0, A)
    End Sub

    Protected Sub grdChasePendingAtUser_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdChasePendingAtUser.RowDataBound
        If e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(1).Text = "Total"
            e.Row.Cells(5).Text = grdChasePendingAtUser.Rows.Count.ToString()
        End If

        Dim lblFinalStatus As New Label()
        If e.Row.RowType = DataControlRowType.DataRow Then
             e.Row.ToolTip = TryCast(e.Row.DataItem, DataRowView)("Description").ToString()

            lblFinalStatus = e.Row.FindControl("lblFinalStatus")

            If lblFinalStatus.Text = "Open" Or lblFinalStatus.Text = "N\A" Then
                e.Row.Font.Bold = True
                e.Row.Cells(6).ForeColor = Drawing.Color.Green
                e.Row.Cells(7).ForeColor = Drawing.Color.Green
                e.Row.Cells(8).ForeColor = Drawing.Color.Green
            ElseIf lblFinalStatus.Text = "Overdue" Then
                e.Row.Font.Bold = True
                e.Row.Cells(6).ForeColor = Drawing.Color.Red
                e.Row.Cells(7).ForeColor = Drawing.Color.Red
                e.Row.Cells(8).ForeColor = Drawing.Color.Red
            ElseIf lblFinalStatus.Text = "Closed" Then
                e.Row.Cells(6).ForeColor = Drawing.Color.Orange
                e.Row.Cells(7).ForeColor = Drawing.Color.Orange
                e.Row.Cells(8).ForeColor = Drawing.Color.Orange
            End If

        End If


    End Sub

    Protected Sub btnChange_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnChange.Click

        Dim IsChecked As Boolean = False
        Dim lblGeneratedChaseID As New Label
        Dim chkSelectChase As New CheckBox
        For Each rw As GridViewRow In grdChasePendingAtUser.Rows
            chkSelectChase = rw.FindControl("chkSelectChase")

            If chkSelectChase.Checked = True Then
                IsChecked = True
                Exit For
            End If
        Next

        If IsChecked = False Then
            MessageBox("Select At Least One Chase To Change Surrport Person.")
            Exit Sub
        End If

        Dim ChaseIDList As String = ""
        For Each rw As GridViewRow In grdChasePendingAtUser.Rows
            chkSelectChase = rw.FindControl("chkSelectChase")

            If chkSelectChase.Checked = True Then
                lblGeneratedChaseID = rw.FindControl("lblGeneratedChaseID")

                ChaseIDList = ChaseIDList + lblGeneratedChaseID.Text + ","

            End If
        Next

        If ChaseIDList <> "" Then
            ChaseIDList = ChaseIDList.Remove(Len(ChaseIDList) - 1, 1)
        Else
            MessageBox("String Empty")
            Exit Sub
        End If


        Dim GenChase As New clsGeneratedChase()

        GenChase.ChaseIDList = ChaseIDList
        GenChase.AssignedToID = drpAllEmpList.SelectedValue

        Dim result As clsResult = GenChaseData.fnChangeSupportPerson(GenChase)

        If result.Success = True Then
            GetAssignmentPendingUsers()
            GetChasePendingAtUser(drpAssignmentPendUsers.SelectedValue)
        End If

        MessageBox(result.Message)


    End Sub

    'Private Sub MessageBox(ByVal strMsg As String)
    '    Dim lbl As New System.Web.UI.WebControls.Label
    '    lbl.Text = "<script language='javascript'>" & Environment.NewLine _
    '               & "window.alert(" & "'" & strMsg & "'" & ")</script>"
    '    Page.Controls.Add(lbl)
    'End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()

        Dim chkSelectChase As New CheckBox
        For Each rw As GridViewRow In grdChasePendingAtUser.Rows
            chkSelectChase = rw.FindControl("chkSelectChase")

            If chkSelectChase.Checked = True Then
                chkSelectChase.Checked = False
            End If
        Next

        drpAllEmpList.SelectedIndex = -1

    End Sub
End Class
