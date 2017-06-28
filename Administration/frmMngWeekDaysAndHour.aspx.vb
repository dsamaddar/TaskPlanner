Imports System
Imports System.Web.UI.WebControls

Partial Class Administration_frmMngWeekDaysAndHour
    Inherits System.Web.UI.Page

    Dim MngWeekDaysData As New clsManageWeekDaysDataAccess()

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        Dim MngWeekDays As New clsManageWeekDays()

        Dim DateFrom As String = Now.Month.ToString() + "/" + Now.Day.ToString() + "/" + Now.Year.ToString() + " " + drpFromHour.SelectedValue + ":" + drpFromMin.SelectedValue + " " + drpFromMeridiem.SelectedValue
        Dim DateTo As String = Now.Month.ToString() + "/" + Now.Day.ToString() + "/" + Now.Year.ToString() + " " + drpToHour.SelectedValue + ":" + drpToMin.SelectedValue + " " + drpToMeridiem.SelectedValue

        If Convert.ToDateTime(DateFrom) >= Convert.ToDateTime(DateTo) Then
            MessageBox("Select Proper Time Frame")
            Exit Sub
        End If

        Try
            MngWeekDays.WeekDays = drpWorkingDays.SelectedValue
            MngWeekDays.FromHour = drpFromHour.SelectedValue
            MngWeekDays.FromMinute = drpFromMin.SelectedValue
            MngWeekDays.FromMeridiem = drpFromMeridiem.SelectedValue

            MngWeekDays.ToHour = drpToHour.SelectedValue
            MngWeekDays.ToMinute = drpToMin.SelectedValue
            MngWeekDays.ToMeridiem = drpToMeridiem.SelectedValue
            MngWeekDays.EntryBy = Session("UserID")


            Dim result As clsResult = MngWeekDaysData.fnInsertManageWeekdays(MngWeekDays)
            If result.Success = True Then
                GetWeekDaysDetails()
                ClearForm()
            End If

            MessageBox(result.Message)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try


    End Sub

    Protected Sub ClearForm()
        drpWorkingDays.SelectedIndex = -1
        drpFromHour.SelectedIndex = -1
        drpFromMin.SelectedIndex = -1

        drpToHour.SelectedIndex = -1
        drpToMin.SelectedIndex = -1
        drpToMeridiem.SelectedIndex = -1

        btnSubmit.Enabled = True
        btnUpdate.Enabled = False

        If grdMngWeekDays.Rows.Count > 0 Then
            grdMngWeekDays.SelectedIndex = -1
        End If

    End Sub

    Protected Sub GetWeekDaysDetails()
        grdMngWeekDays.DataSource = MngWeekDaysData.fnGetWeekDaysDetails()
        grdMngWeekDays.DataBind()
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim MngWeekDays As New clsManageWeekDays()

        Dim DateFrom As String = Now.Month.ToString() + "/" + Now.Day.ToString() + "/" + Now.Year.ToString() + " " + drpFromHour.SelectedValue + ":" + drpFromMin.SelectedValue + " " + drpFromMeridiem.SelectedValue
        Dim DateTo As String = Now.Month.ToString() + "/" + Now.Day.ToString() + "/" + Now.Year.ToString() + " " + drpToHour.SelectedValue + ":" + drpToMin.SelectedValue + " " + drpToMeridiem.SelectedValue

        If Convert.ToDateTime(DateFrom) >= Convert.ToDateTime(DateTo) Then
            MessageBox("Select Proper Time Frame")
            Exit Sub
        End If

        If hdFldMngWeekDayID.Value = "" Then
            MessageBox("Select A Row To Update.")
            Exit Sub
        End If

        Try
            MngWeekDays.MngWeekDayID = hdFldMngWeekDayID.Value
            MngWeekDays.WeekDays = drpWorkingDays.SelectedValue
            MngWeekDays.FromHour = drpFromHour.SelectedValue
            MngWeekDays.FromMinute = drpFromMin.SelectedValue
            MngWeekDays.FromMeridiem = drpFromMeridiem.SelectedValue

            MngWeekDays.ToHour = drpToHour.SelectedValue
            MngWeekDays.ToMinute = drpToMin.SelectedValue
            MngWeekDays.ToMeridiem = drpToMeridiem.SelectedValue
            MngWeekDays.EntryBy = Session("UserID")


            Dim result As clsResult = MngWeekDaysData.fnUpdateManageWeekDays(MngWeekDays)
            If result.Success = True Then
                GetWeekDaysDetails()
                ClearForm()
            End If

            MessageBox(result.Message)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "MngWeekDays~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then
            GetWeekDaysDetails()

            btnSubmit.Enabled = True
            btnUpdate.Enabled = False
        End If
    End Sub

    Protected Sub grdMngWeekDays_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdMngWeekDays.SelectedIndexChanged
        Dim lblMngWeekDayID, lblWeekDays, lblFromHour, lblFromMinute, lblFromMeridiem, lblToHour, lblToMinute, lblToMeridiem As New Label

        lblMngWeekDayID = grdMngWeekDays.SelectedRow.FindControl("lblMngWeekDayID")
        lblWeekDays = grdMngWeekDays.SelectedRow.FindControl("lblWeekDays")
        lblFromHour = grdMngWeekDays.SelectedRow.FindControl("lblFromHour")
        lblFromMinute = grdMngWeekDays.SelectedRow.FindControl("lblFromMinute")
        lblFromMeridiem = grdMngWeekDays.SelectedRow.FindControl("lblFromMeridiem")
        lblToHour = grdMngWeekDays.SelectedRow.FindControl("lblToHour")
        lblToMinute = grdMngWeekDays.SelectedRow.FindControl("lblToMinute")
        lblToMeridiem = grdMngWeekDays.SelectedRow.FindControl("lblToMeridiem")

        hdFldMngWeekDayID.Value = lblMngWeekDayID.Text
        drpWorkingDays.SelectedValue = lblWeekDays.Text
        drpFromHour.SelectedValue = lblFromHour.Text
        drpFromMin.SelectedValue = lblFromMinute.Text
        drpFromMeridiem.SelectedValue = lblFromMeridiem.Text

        drpToHour.SelectedValue = lblToHour.Text
        drpToMin.SelectedValue = lblToMinute.Text
        drpToMeridiem.SelectedValue = lblToMeridiem.Text

        btnSubmit.Enabled = False
        btnUpdate.Enabled = True

    End Sub
End Class
