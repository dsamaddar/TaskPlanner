Imports System.Data
Imports AjaxControlToolkit
Imports System.Net.Mail

Partial Class Administration_frmChngPrimarySupport
    Inherits System.Web.UI.Page

    Dim ChaseDefData As New clsChaseDefinitionDataAccess()
    Dim EmpData As New clsEmployeeInfoDataAccess()


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "chngSupRep~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then
            ShowAllPrimaryReps()
            ShowAllReps()
            SelectRepresentative(Session("EmployeeID"))
        End If
    End Sub

    Protected Sub SelectRepresentative(ByVal EmployeeID As String)

        Dim Exists As Boolean = False

        For Each itm As ListItem In drpRepresentatives.Items
            If itm.Value = EmployeeID Then
                Exists = True
                Exit For
            End If
        Next

        If Exists = True Then
            drpRepresentatives.SelectedValue = EmployeeID
            GetAllChaseListByPrimaryRep(drpRepresentatives.SelectedValue)
        Else
            drpRepresentatives.SelectedIndex = -1
        End If

    End Sub

    Protected Sub GetAllChaseListByPrimaryRep(ByVal PrimarySupportRep As String)
        grdChaseList.DataSource = ChaseDefData.fnGetAllChasesByPrimaryRep(PrimarySupportRep)
        grdChaseList.DataBind()
    End Sub

    Protected Sub ShowAllPrimaryReps()
        drpRepresentatives.DataTextField = "EmployeeName"
        drpRepresentatives.DataValueField = "PrimarySupportRep"
        drpRepresentatives.DataSource = ChaseDefData.fnGetAllPrimaryRep()
        drpRepresentatives.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpRepresentatives.Items.Insert(0, A)

    End Sub

    Protected Sub ShowAllReps()
        drpChangedRepresentative.DataTextField = "EmployeeName"
        drpChangedRepresentative.DataValueField = "EmployeeID"
        drpChangedRepresentative.DataSource = EmpData.fnGetEmployeeList()
        drpChangedRepresentative.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpChangedRepresentative.Items.Insert(0, A)

    End Sub

    Protected Sub grdChaseList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdChaseList.SelectedIndexChanged

        Dim lblChaseDefinitionID, lblPrimarySupportRep, lblChaseInstruction As New Label

        lblChaseDefinitionID = grdChaseList.SelectedRow.FindControl("lblChaseDefinitionID")
        lblPrimarySupportRep = grdChaseList.SelectedRow.FindControl("lblPrimarySupportRep")
        lblChaseInstruction = grdChaseList.SelectedRow.FindControl("lblChaseInstruction")
        Try
            drpChangedRepresentative.SelectedValue = lblPrimarySupportRep.Text
            hdFldChaseDefinitionID.Value = lblChaseDefinitionID.Text
            txtChaseInstruction.Text = lblChaseInstruction.Text
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub


    Protected Sub btnChange_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnChange.Click

        Dim ChaseDef As New clsChaseDefinition()
        Dim MailProp As New clsMailProperty()

        If hdFldChaseDefinitionID.Value = "" Then
            MessageBox("Select A Chase First.")
            Exit Sub
        End If

        ChaseDef.ChaseDefinitionID = hdFldChaseDefinitionID.Value
        ChaseDef.PrimarySupportRep = drpChangedRepresentative.SelectedValue
        ChaseDef.ChaseInstruction = txtChaseInstruction.Text

        Dim result As clsResult = ChaseDefData.fnChngSupRep(ChaseDef)

        If result.Success = True Then
            MailProp = ChaseDefData.fnRespChngMail(hdFldChaseDefinitionID.Value, drpRepresentatives.SelectedValue, drpChangedRepresentative.SelectedValue)
            SendMail(MailProp)
            ClearForm()
            GetAllChaseListByPrimaryRep(drpRepresentatives.SelectedValue)
        End If

        MessageBox(result.Message)


    End Sub

    Protected Sub ClearForm()
        txtChaseInstruction.Text = ""
        drpChangedRepresentative.SelectedIndex = -1

        hdFldChaseDefinitionID.Value = ""
        If grdChaseList.Rows.Count > 0 Then
            grdChaseList.SelectedIndex = -1
        End If
    End Sub


    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub drpRepresentatives_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpRepresentatives.SelectedIndexChanged
        GetAllChaseListByPrimaryRep(drpRepresentatives.SelectedValue)
    End Sub

    Protected Sub SendMail(ByVal MailProp As clsMailProperty)
        Dim mail As New Net.Mail.MailMessage()
        Dim TestArray() As String

        Try
            mail.From = New MailAddress(MailProp.MailFrom)

            TestArray = Split(MailProp.MailTo, ";")
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    mail.To.Add(TestArray(i))
                End If
            Next
            TestArray = Nothing

            TestArray = Split(MailProp.MailCC, ";")
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    mail.CC.Add(TestArray(i))
                End If
            Next
            TestArray = Nothing

            TestArray = Split(MailProp.MailBCC, ";")
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    mail.Bcc.Add(TestArray(i))
                End If
            Next
            TestArray = Nothing

            mail.Subject = MailProp.MailSubject
            mail.Body = MailProp.MailBody
            mail.IsBodyHtml = True
            mail.Priority = MailPriority.High
            Dim smtp As New SmtpClient("192.168.1.232", 25)
            smtp.Send(mail)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

End Class
