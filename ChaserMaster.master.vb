
Partial Class ChaserMaster
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.UserAgent.IndexOf("AppleWebKit") > 0 Then
            Request.Browser.Adapters.Clear()

        End If

        If Not IsPostBack Then
            lblEmpName.Text = "Welcome " + Session("EmployeeName") + " ! "

            Dim mnu As New Menu
            Dim MenuIDs As String

            mnu = Me.FindControl("mnuChaser")
            MenuIDs = Session("PermittedMenus")
            ' Administration Menu
            mnu.Items(0).Enabled = IIf(InStr(MenuIDs, "Administration~"), True, False)
            mnu.Items(0).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "EmpInfo~"), True, False)
            mnu.Items(0).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "FacilityType~"), True, False)
            mnu.Items(0).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "ChaseDef~"), True, False)
            mnu.Items(0).ChildItems(3).Enabled = IIf(InStr(MenuIDs, "CatSettings~"), True, False)
            mnu.Items(0).ChildItems(4).Enabled = IIf(InStr(MenuIDs, "PrioritySett~"), True, False)
            mnu.Items(0).ChildItems(5).Enabled = IIf(InStr(MenuIDs, "MngULCBranch~"), True, False)
            mnu.Items(0).ChildItems(6).Enabled = IIf(InStr(MenuIDs, "ChaseCtrlStructure~"), True, False)
            mnu.Items(0).ChildItems(7).Enabled = IIf(InStr(MenuIDs, "MasterRptTool~"), True, False)
            mnu.Items(0).ChildItems(8).Enabled = IIf(InStr(MenuIDs, "WebAdmin~"), True, False)
            mnu.Items(0).ChildItems(8).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "RoleManagement~"), True, False)
            mnu.Items(0).ChildItems(8).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "RoleWiseMenu~"), True, False)
            mnu.Items(0).ChildItems(8).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "UsrWiseRole~"), True, False)
            mnu.Items(0).ChildItems(9).Enabled = IIf(InStr(MenuIDs, "MngHolidays~"), True, False)
            mnu.Items(0).ChildItems(10).Enabled = IIf(InStr(MenuIDs, "MngWeekDays~"), True, False)
            mnu.Items(0).ChildItems(11).Enabled = IIf(InStr(MenuIDs, "chngSupRep~"), True, False)
            mnu.Items(0).ChildItems(12).Enabled = IIf(InStr(MenuIDs, "AddNewlyAddEmp~"), True, False)
            mnu.Items(0).ChildItems(13).Enabled = IIf(InStr(MenuIDs, "EmpSync~"), True, False)

            ' Administration Menu Ends

            'mnu.Items(1).Enabled = IIf(InStr(MenuIDs, "VoiceDataColl~"), True, False)

            ' Generate Chase Menu
            mnu.Items(1).Enabled = IIf(InStr(MenuIDs, "GenerateChase~"), True, False)
            mnu.Items(1).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "GenerateChaseCSFDF~"), True, False)
            mnu.Items(1).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "GenGenerateChase~"), True, False)
            mnu.Items(1).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "EditChase~"), True, False)
            mnu.Items(1).ChildItems(3).Enabled = IIf(InStr(MenuIDs, "ChngAssPerson~"), True, False)
            ' Generate Chase Menu Ends

            mnu.Items(2).Enabled = IIf(InStr(MenuIDs, "AllChases~"), True, False)
            mnu.Items(2).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "UsrWiseChase~"), True, False)
            mnu.Items(2).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "AssignedChase~"), True, False)
            mnu.Items(2).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "PerformedChase~"), True, False)
            mnu.Items(2).ChildItems(3).Enabled = IIf(InStr(MenuIDs, "DeptChase~"), True, False)
            mnu.Items(2).ChildItems(4).Enabled = IIf(InStr(MenuIDs, "TskIniReport~"), True, False)

            ' Reports Menu
            mnu.Items(3).Enabled = IIf(InStr(MenuIDs, "Reports~"), True, False)
            mnu.Items(3).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "ChaserReporting~"), True, False)
            mnu.Items(3).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "GlobalView~"), True, False)
            mnu.Items(3).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "GenerateReport~"), True, False)
            mnu.Items(3).ChildItems(3).Enabled = IIf(InStr(MenuIDs, "ReqLogView~"), True, False)
            mnu.Items(3).ChildItems(4).Enabled = IIf(InStr(MenuIDs, "CatWiseView~"), True, False)
            mnu.Items(3).ChildItems(5).Enabled = IIf(InStr(MenuIDs, "RawDataReport~"), True, False)
            ' Reports Menu Ends

            ' Market Info Menu
            'mnu.Items(5).Enabled = IIf(InStr(MenuIDs, "MktInfo~"), True, False)
            'mnu.Items(5).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "PrimaryRating~"), True, False)
            'mnu.Items(5).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "SecRating~"), True, False)
            'mnu.Items(5).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "AllMktInfo~"), True, False)
            ' End Market Info Menu
        End If
    End Sub
End Class

