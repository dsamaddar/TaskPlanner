
Partial Class frmVoiceDataCollection
    Inherits System.Web.UI.Page
    Dim FacilityTypeData As New clsFacilityTypeDataAccess()
    Dim AgreementData As New clsAgreementInfoDataAccess()
    Dim VoiceCollData As New clsVoiceDataCollDataAccess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "VoiceDataColl~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then
            GetFacilityType()
            txtCollectionDate.Text = Now.Date
            GetVoiceDataCollection()
        End If
    End Sub

    Protected Sub GetVoiceDataCollection()
        grdVoiceDataColl.DataSource = VoiceCollData.fnGetVoiceDataColl()
        grdVoiceDataColl.DataBind()
    End Sub

    Protected Sub GetFacilityType()
        drpFacilityType.DataTextField = "FacilityType"
        drpFacilityType.DataValueField = "FacilityTypeID"
        drpFacilityType.DataSource = FacilityTypeData.fnGetActiveFacilityTypeList()
        drpFacilityType.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpFacilityType.Items.Insert(0, A)
    End Sub

    Protected Sub drpFacilityType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpFacilityType.SelectedIndexChanged

        drpAgreementList.DataSource = ""
        drpAgreementList.DataBind()

        drpClientList.DataSource = ""
        drpClientList.DataBind()

        drpExecutiveList.DataSource = ""
        drpExecutiveList.DataBind()

        GetExecutivesByFacility(drpFacilityType.SelectedValue)
    End Sub

    Protected Sub GetExecutivesByFacility(ByVal FacilityTypeID As String)
        drpExecutiveList.DataTextField = "EmployeeName"
        drpExecutiveList.DataValueField = "EmployeeID"
        drpExecutiveList.DataSource = AgreementData.fnGetExecutivesByFacilityType(FacilityTypeID)
        drpExecutiveList.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpExecutiveList.Items.Insert(0, A)

    End Sub

    Protected Sub GetClientListByFacAndSM()
        Dim AgrInfo As New clsAgreementInfo()
        AgrInfo.FacilityTypeID = drpFacilityType.SelectedValue
        AgrInfo.ServiceManager = drpExecutiveList.SelectedValue

        drpClientList.DataTextField = "ClientName"
        drpClientList.DataValueField = "ClientID"
        drpClientList.DataSource = AgreementData.fnGetClientListByFacSM(AgrInfo)
        drpClientList.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpClientList.Items.Insert(0, A)

    End Sub

    Protected Sub GetAgrListByFac_SM_Client()
        Dim AgrInfo As New clsAgreementInfo()
        AgrInfo.FacilityTypeID = drpFacilityType.SelectedValue
        AgrInfo.ServiceManager = drpExecutiveList.SelectedValue
        AgrInfo.ClientID = drpClientList.SelectedValue

        drpAgreementList.DataTextField = "AgreementNo"
        drpAgreementList.DataValueField = "AgreementInfoID"
        drpAgreementList.DataSource = AgreementData.fnGetAgrListByFac_SM_Client(AgrInfo)
        drpAgreementList.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpAgreementList.Items.Insert(0, A)

    End Sub

    Protected Sub drpExecutiveList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpExecutiveList.SelectedIndexChanged
        GetClientListByFacAndSM()
    End Sub

    Protected Sub drpClientList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpClientList.SelectedIndexChanged
        GetAgrListByFac_SM_Client()
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub ClearForm()
        drpAgreementList.DataSource = ""
        drpAgreementList.DataBind()

        drpClientList.DataSource = ""
        drpClientList.DataBind()

        drpExecutiveList.DataSource = ""
        drpExecutiveList.DataBind()

        drpFacilityType.DataSource = ""
        drpFacilityType.DataBind()

        drpDataFrequency.SelectedIndex = -1
    End Sub

    Protected Sub btnSubmitData_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmitData.Click

        If drpFacilityType.SelectedValue = "N\A" Then
            MessageBox("Select Facility Type")
            Exit Sub
        End If

        If drpExecutiveList.SelectedValue = "N\A" Then
            MessageBox("Select An Executive")
            Exit Sub
        End If

        If drpClientList.SelectedValue = "N\A" Then
            MessageBox("Select A Client.")
            Exit Sub
        End If

        If drpAgreementList.SelectedValue = "N\A" Then
            MessageBox("Select An Agreement.")
            Exit Sub
        End If

        Dim folder As String
        Dim DocFileName As String = ""
        Dim DocFileNameSign As String = ""
        Dim DocExt As String
        Dim AttachmentFileName As String
        Dim DocPrefix As String
        Dim FileSize As Integer
        'folder = Server.MapPath("~/Attachments/")
        folder = ConfigurationManager.AppSettings("InputChaserFile")
        Dim VoiceColl As New clsVoiceDataColl()

        VoiceColl.FacilityTypeID = drpFacilityType.SelectedValue
        VoiceColl.ServiceManager = drpExecutiveList.SelectedValue
        VoiceColl.ClientID = drpClientList.SelectedValue
        VoiceColl.AgreementInfoID = drpAgreementList.SelectedValue
        VoiceColl.DataFrequency = drpDataFrequency.SelectedValue
        VoiceColl.CollectionDate = Convert.ToDateTime(txtCollectionDate.Text)

        If flupVoiceData.HasFile Then

            FileSize = flupVoiceData.PostedFile.ContentLength()

            If FileSize > 10485760 Then
                MessageBox("File size should be within 10MB")
                Exit Sub
            End If

            DocPrefix = Title.Replace(" ", "")

            DocExt = System.IO.Path.GetExtension(flupVoiceData.FileName)

            If DocExt <> ".wav" And DocExt <> ".WAV" And DocExt <> ".wma" And DocExt <> ".WMA" And DocExt <> ".mp3" And DocExt <> ".MP3" Then
                MessageBox("Select Audio File Only")
                Exit Sub
            End If

            DocFileName = "VD" & "_" & DateTime.Now.ToString("ddMMyyHHmmss") & DocExt
            VoiceColl.DataSource = DocFileName
            AttachmentFileName = folder & DocFileName
            flupVoiceData.SaveAs(AttachmentFileName)
        Else
            MessageBox("Select A Voice Data To Upload")
            Exit Sub
        End If

        VoiceColl.EntryBy = Session("UserID")

        Dim Result As clsResult = VoiceCollData.fnInsertVoiceDataCollection(VoiceColl)

        If Result.Success = True Then
            ClearForm()
            GetVoiceDataCollection()
        End If

        MessageBox(Result.Message)

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

End Class
