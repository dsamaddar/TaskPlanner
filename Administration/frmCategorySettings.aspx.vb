Imports clsCategory

Partial Class Administration_frmCategorySettings
    Inherits System.Web.UI.Page

    Dim CatData As New clsCategory()
    Dim SubCatData As New clsSubCategory()
    Dim ItemData As New clsItems()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim MenuIDs As String
        MenuIDs = Session("PermittedMenus")
        If InStr(MenuIDs, "CatSettings~") = 0 Then
            Response.Redirect("~\Login.aspx")
        End If

        If Not IsPostBack Then
            GetCategoryDetailsInfo()
            GetActiveCategoryList()

            GetSubCategoryDetailsInfo()
            GetItemDetails()

            btnAddCategory.Enabled = True
            btnUpdateCategory.Enabled = False

            btnAddSubCategory.Enabled = True
            btnUpdateSubCategory.Enabled = False

            btnAddItems.Enabled = True
            btnUpdateItems.Enabled = False
        End If
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

#Region " Category "

    Protected Sub ClearCategoryForm()
        hdFldCategoryID.Value = ""
        txtCategory.Text = ""
        txtCategoryDescription.Text = ""
        chkIsCategoryActive.Checked = False
        chkODNotifiction.Checked = False
        btnAddCategory.Enabled = True
        btnUpdateCategory.Enabled = False
    End Sub

    Protected Sub btnAddCategory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddCategory.Click
        Dim Cat As New clsCategory()

        Cat.CategoryName = txtCategory.Text
        Cat.Details = txtCategoryDescription.Text
        If chkIsCategoryActive.Checked = True Then
            Cat.IsActive = True
        Else
            Cat.IsActive = False
        End If

        If chkODNotifiction.Checked = True Then
            Cat.IsODNotification = True
        Else
            Cat.IsODNotification = False
        End If

        Cat.EntryBy = Session("UserID")

        Dim res As clsResult = Cat.fnInsertCategory(Cat)

        If res.Success = True Then
            ClearCategoryForm()
            GetCategoryDetailsInfo()
            GetActiveCategoryList()
        End If
        MessageBox(res.Message)
    End Sub

    Protected Sub btnUpdateCategory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateCategory.Click
        Dim Cat As New clsCategory()

        If grdCategoryDetails.SelectedIndex = -1 Then
            MessageBox("Select A Category First.")
            Exit Sub
        End If

        If hdFldCategoryID.Value = "" Then
            MessageBox("Invalid Selection")
            Exit Sub
        End If

        Cat.CategoryID = hdFldCategoryID.Value
        Cat.CategoryName = txtCategory.Text
        Cat.Details = txtCategoryDescription.Text
        If chkIsCategoryActive.Checked = True Then
            Cat.IsActive = True
        Else
            Cat.IsActive = False
        End If

        If chkODNotifiction.Checked = True Then
            Cat.IsODNotification = True
        Else
            Cat.IsODNotification = False
        End If

        Cat.EntryBy = Session("UserID")

        Dim res As clsResult = Cat.fnUpdateCategory(Cat)

        If res.Success = True Then
            ClearCategoryForm()
            GetCategoryDetailsInfo()
            GetActiveCategoryList()
        End If

        MessageBox(res.Message)
    End Sub

    Protected Sub GetCategoryDetailsInfo()
        grdCategoryDetails.DataSource = CatData.fnGetDetailsCategoryInfo()
        grdCategoryDetails.DataBind()
    End Sub

    Protected Sub GetActiveCategoryList()
        drpCategoryList.DataTextField = "CategoryName"
        drpCategoryList.DataValueField = "CategoryID"
        drpCategoryList.DataSource = CatData.fnGetActiveCategoryList()
        drpCategoryList.DataBind()

        Dim A As New ListItem
        A.Text = "-- Select Category --"
        A.Value = "N\A"

        drpCategoryList.Items.Insert(0, A)

        drpItmCategoryList.DataTextField = "CategoryName"
        drpItmCategoryList.DataValueField = "CategoryID"
        drpItmCategoryList.DataSource = CatData.fnGetActiveCategoryList()
        drpItmCategoryList.DataBind()

        drpItmCategoryList.Items.Insert(0, A)

    End Sub

    Protected Sub btnCancelCategory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelCategory.Click
        ClearCategoryForm()
        grdCategoryDetails.SelectedIndex = -1
    End Sub

    Protected Sub GetSubCategoryDetailsInfo()
        grdSubCategory.DataSource = SubCatData.fnGetSubCategoryDetailsInfo()
        grdSubCategory.DataBind()
    End Sub

    Protected Sub grdCategoryDetails_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdCategoryDetails.SelectedIndexChanged
        Dim lblCategoryID, lblCategoryName, lblCategoryDetails, lblIsActive, lblODNotification As Label

        lblCategoryID = grdCategoryDetails.SelectedRow.FindControl("lblCategoryID")
        lblCategoryName = grdCategoryDetails.SelectedRow.FindControl("lblCategoryName")
        lblCategoryDetails = grdCategoryDetails.SelectedRow.FindControl("lblCategoryDetails")
        lblIsActive = grdCategoryDetails.SelectedRow.FindControl("lblIsActive")
        lblODNotification = grdCategoryDetails.SelectedRow.FindControl("lblODNotification")

        hdFldCategoryID.Value = lblCategoryID.Text
        txtCategory.Text = lblCategoryName.Text
        txtCategoryDescription.Text = lblCategoryDetails.Text

        If lblIsActive.Text = "YES" Then
            chkIsCategoryActive.Checked = True
        Else
            chkIsCategoryActive.Checked = False
        End If

        If lblODNotification.Text = "YES" Then
            chkODNotifiction.Checked = True
        Else
            chkODNotifiction.Checked = False
        End If

        btnAddCategory.Enabled = False
        btnUpdateCategory.Enabled = True

    End Sub

#End Region

#Region " Sub Category "

    Protected Sub ClearSubCatForm()

        hdFldSubCategoryID.Value = ""
        txtSubCategory.Text = ""
        txtSubCategoryDescription.Text = ""
        chkIsSubCategoryActive.Checked = False
        drpCategoryList.SelectedIndex = -1
        grdSubCategory.SelectedIndex = -1

        btnAddSubCategory.Enabled = True
        btnUpdateSubCategory.Enabled = False

    End Sub

    Protected Sub btnAddSubCategory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddSubCategory.Click
        Dim SubCat As New clsSubCategory()

        SubCat.CategoryID = drpCategoryList.SelectedValue
        SubCat.SubCategory = txtSubCategory.Text
        SubCat.Details = txtSubCategoryDescription.Text
        If chkIsSubCategoryActive.Checked = True Then
            SubCat.IsActive = True
        Else
            SubCat.IsActive = False
        End If
        SubCat.EntryBy = Session("UserID")

        Dim res As clsResult = SubCatData.fnInsertSubCategory(SubCat)

        If res.Success = True Then
            GetSubCategoryDetailsInfo()
            ClearSubCatForm()
        End If

        MessageBox(res.Message)

    End Sub

    Protected Sub btnCancelSubCategory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelSubCategory.Click
        ClearSubCatForm()
    End Sub

    Protected Sub btnUpdateSubCategory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateSubCategory.Click
        Dim SubCat As New clsSubCategory()

        If grdSubCategory.SelectedIndex = -1 Then
            MessageBox("Select A Sub-Category First")
            Exit Sub
        End If

        If hdFldSubCategoryID.Value = "" Then
            MessageBox("Select A Sub-Category First")
            Exit Sub
        End If

        SubCat.SubCategoryID = hdFldSubCategoryID.Value
        SubCat.CategoryID = drpCategoryList.SelectedValue
        SubCat.SubCategory = txtSubCategory.Text
        SubCat.Details = txtSubCategoryDescription.Text
        If chkIsSubCategoryActive.Checked = True Then
            SubCat.IsActive = True
        Else
            SubCat.IsActive = False
        End If
        SubCat.EntryBy = Session("UserID")

        Dim res As clsResult = SubCatData.fnUpdateSubCategory(SubCat)

        If res.Success = True Then
            GetSubCategoryDetailsInfo()
            ClearSubCatForm()
        End If

        MessageBox(res.Message)
    End Sub

    Protected Sub grdSubCategory_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdSubCategory.SelectedIndexChanged
        Dim lblSubCategoryID, lblSubCategory, lblSCCategoryID, lblSCDetails, lblSCIsActive As Label

        lblSubCategoryID = grdSubCategory.SelectedRow.FindControl("lblSubCategoryID")
        lblSubCategory = grdSubCategory.SelectedRow.FindControl("lblSubCategory")
        lblSCCategoryID = grdSubCategory.SelectedRow.FindControl("lblSCCategoryID")
        lblSCDetails = grdSubCategory.SelectedRow.FindControl("lblSCDetails")
        lblSCIsActive = grdSubCategory.SelectedRow.FindControl("lblSCIsActive")

        hdFldSubCategoryID.Value = lblSubCategoryID.Text
        txtSubCategory.Text = lblSubCategory.Text
        drpCategoryList.SelectedValue = lblSCCategoryID.Text
        txtSubCategoryDescription.Text = lblSCDetails.Text

        If lblSCIsActive.Text = "YES" Then
            chkIsSubCategoryActive.Checked = True
        Else
            chkIsSubCategoryActive.Checked = False
        End If

        btnAddSubCategory.Enabled = False
        btnUpdateSubCategory.Enabled = True

    End Sub

    Protected Sub GetSubCatListByCategory(ByVal CategoryID As String)
        drpItmSubCategoryList.DataTextField = "SubCategory"
        drpItmSubCategoryList.DataValueField = "SubCategoryID"
        drpItmSubCategoryList.DataSource = SubCatData.fnGetActiveSubCatListByCategory(CategoryID)
        drpItmSubCategoryList.DataBind()

        Dim A As New ListItem
        A.Text = "--Select Sub Category--"
        A.Value = "N\A"

        drpItmSubCategoryList.Items.Insert(0, A)
    End Sub

#End Region

    Protected Sub ClearItems()
        txtItem.Text = ""
        txtItemDescription.Text = ""
        btnAddItems.Enabled = True
        btnUpdateItems.Enabled = False
        grdItems.SelectedIndex = -1
    End Sub

    Protected Sub drpItmCategoryList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpItmCategoryList.SelectedIndexChanged
        GetSubCatListByCategory(drpItmCategoryList.SelectedValue)
    End Sub

    Protected Sub GetItemDetails()
        grdItems.DataSource = ItemData.fnGetDetailsItems()
        grdItems.DataBind()
    End Sub

    Protected Sub btnAddItems_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddItems.Click
        Dim Items As New clsItems()

        If drpItmCategoryList.SelectedValue = "N\A" Then
            MessageBox("Select Proper Category")
            Exit Sub
        End If

        If drpItmSubCategoryList.SelectedValue = "N\A" Then
            MessageBox("Select Proper Sub-Category")
            Exit Sub
        End If

        Items.CategoryID = drpItmCategoryList.SelectedValue
        Items.SubCategoryID = drpItmSubCategoryList.SelectedValue
        Items.ItemName = txtItem.Text
        Items.Details = txtItemDescription.Text
        Items.EntryBy = Session("UserID")

        Dim res As clsResult = Items.fnInsertItems(Items)

        If res.Success = True Then
            ClearItems()
            GetItemDetails()
        End If

        MessageBox(res.Message)
    End Sub

    Protected Sub btnUpdateItems_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateItems.Click
        Dim Items As New clsItems()

        If hdFldItemID.Value = "" Then
            MessageBox("Select An Item First.")
            Exit Sub
        End If

        If drpItmCategoryList.SelectedValue = "N\A" Then
            MessageBox("Select Proper Category")
            Exit Sub
        End If

        If drpItmSubCategoryList.SelectedValue = "N\A" Then
            MessageBox("Select Proper Sub-Category")
            Exit Sub
        End If

        Items.ItemID = hdFldItemID.Value
        Items.CategoryID = drpItmCategoryList.SelectedValue
        Items.SubCategoryID = drpItmSubCategoryList.SelectedValue
        Items.ItemName = txtItem.Text
        If chkIsItemActive.Checked = True Then
            Items.IsActive = True
        Else
            Items.IsActive = False
        End If
        Items.Details = txtItemDescription.Text
        Items.EntryBy = Session("UserID")

        Dim res As clsResult = Items.fnUpdateItems(Items)

        If res.Success = True Then
            GetItemDetails()
            ClearItems()
        End If

        MessageBox(res.Message)
    End Sub

    Protected Sub btnCancelItems_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelItems.Click
        ClearItems()
    End Sub

    Protected Sub grdItems_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdItems.SelectedIndexChanged
        Dim lblItemID, lblItemName, lblItmCategoryID, lblItmSubCategoryID, lblItmDetails, lblItmIsActive As Label

        lblItemID = grdItems.SelectedRow.FindControl("lblItemID")
        lblItemName = grdItems.SelectedRow.FindControl("lblItemName")
        lblItmCategoryID = grdItems.SelectedRow.FindControl("lblItmCategoryID")
        lblItmSubCategoryID = grdItems.SelectedRow.FindControl("lblItmSubCategoryID")
        lblItmDetails = grdItems.SelectedRow.FindControl("lblItmDetails")
        lblItmIsActive = grdItems.SelectedRow.FindControl("lblItmIsActive")

        hdFldItemID.Value = lblItemID.Text
        txtItem.Text = lblItemName.Text
        txtItemDescription.Text = lblItmDetails.Text
        drpItmCategoryList.SelectedValue = lblItmCategoryID.Text
        GetSubCatListByCategory(drpItmCategoryList.SelectedValue)
        drpItmSubCategoryList.SelectedValue = lblItmSubCategoryID.Text

        If lblItmIsActive.Text = "YES" Then
            chkIsItemActive.Checked = True
        Else
            chkIsItemActive.Checked = False
        End If

        btnAddItems.Enabled = False
        btnUpdateItems.Enabled = True

    End Sub

End Class
