<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/ChaserMaster.master"
    AutoEventWireup="false" CodeFile="frmCategorySettings.aspx.vb" Inherits="Administration_frmCategorySettings"
    Title=".:Chaser:Category Settings:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlCategory" runat="server" SkinID="pnlInner" Width="70%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Category<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 250px">
                                <asp:HiddenField ID="hdFldCategoryID" runat="server" />
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Category
                            </td>
                            <td>
                                <asp:TextBox ID="txtCategory" runat="server" Width="200px"></asp:TextBox>
                            </td>
                            <td class="label">
                                IsActive
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsCategoryActive" runat="server" Text="(Check If YES)" CssClass="label" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Description
                            </td>
                            <td>
                                <asp:TextBox ID="txtCategoryDescription" runat="server" TextMode="MultiLine" Width="200px"></asp:TextBox>
                            </td>
                            <td class="label">
                                OD Notification</td>
                            <td>
                                <asp:CheckBox ID="chkODNotifiction" runat="server" CssClass="label" 
                                    Text="(Check If YES)" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnAddCategory" runat="server" Text="Add" CssClass="styled-button-1"
                                    ValidationGroup="Category" />
                                &nbsp;<asp:Button ID="btnUpdateCategory" runat="server" CssClass="styled-button-1"
                                    Text="Update" ValidationGroup="Category" />
                                &nbsp;<asp:Button ID="btnCancelCategory" runat="server" Text="Cancel" CssClass="styled-button-1" />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldCategory" runat="server" 
                                    ControlToValidate="txtCategory" Display="None" 
                                    ErrorMessage="Required: Category Name" ValidationGroup="Category"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldCategory_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="../Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldCategory" 
                                    WarningIconImageUrl="../Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldCategoryDescription" runat="server" 
                                    ControlToValidate="txtCategoryDescription" Display="None" 
                                    ErrorMessage="Required: Category Description" ValidationGroup="Category"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldCategoryDescription_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="../Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldCategoryDescription" 
                                    WarningIconImageUrl="../Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <div style="max-width: 70%; max-height: 200px; overflow: auto">
                    <asp:GridView ID="grdCategoryDetails" runat="server" AutoGenerateColumns="False"
                        CssClass="mGrid" EmptyDataText="No Category Found">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:TemplateField HeaderText="CategoryID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblCategoryID" runat="server" Text='<%# Bind("CategoryID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category">
                                <ItemTemplate>
                                    <asp:Label ID="lblCategoryName" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Details">
                                <ItemTemplate>
                                    <asp:Label ID="lblCategoryDetails" runat="server" Text='<%# Bind("Details") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IsActive">
                                <ItemTemplate>
                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="OD Notification">
                                <ItemTemplate>
                                    <asp:Label ID="lblODNotification" runat="server" Text='<%# Bind("IsODNotification") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EntryBy">
                                <ItemTemplate>
                                    <asp:Label ID="lblEntryBy" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EntryDate">
                                <ItemTemplate>
                                    <asp:Label ID="lblEntryDate" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlSubCategory" runat="server" SkinID="pnlInner" Width="70%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Sub-Category</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 250px">
                                <asp:HiddenField ID="hdFldSubCategoryID" runat="server" />
                            </td>
                            <td style="width: 150px">
                                <asp:RequiredFieldValidator ID="reqFldCategoryList" runat="server" ControlToValidate="drpCategoryList"
                                    Display="None" ErrorMessage="Required: Category" ValidationGroup="SubCategory"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldCategoryList_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="../Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldCategoryList" WarningIconImageUrl="../Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Select Category
                            </td>
                            <td>
                                <asp:DropDownList ID="drpCategoryList" runat="server" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                Is Active
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsSubCategoryActive" runat="server" Text="(Check If YES)" CssClass="label" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Sub Category
                            </td>
                            <td>
                                <asp:TextBox ID="txtSubCategory" runat="server" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldSubCategory" runat="server" ControlToValidate="txtSubCategory"
                                    Display="None" ErrorMessage="Required: Sub Category" ValidationGroup="SubCategory"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldSubCategory_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="../Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldSubCategory" WarningIconImageUrl="../Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Description
                            </td>
                            <td>
                                <asp:TextBox ID="txtSubCategoryDescription" runat="server" TextMode="MultiLine" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldSubCategoryDescription" runat="server" ControlToValidate="txtSubCategoryDescription"
                                    Display="None" ErrorMessage="Required: Sub Category Description" ValidationGroup="SubCategory"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldSubCategoryDescription_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="../Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldSubCategoryDescription" WarningIconImageUrl="../Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnAddSubCategory" runat="server" Text="Add" CssClass="styled-button-1"
                                    ValidationGroup="SubCategory" />
                                &nbsp;<asp:Button ID="btnUpdateSubCategory" runat="server" CssClass="styled-button-1"
                                    Text="Update" ValidationGroup="SubCategory" />
                                &nbsp;<asp:Button ID="btnCancelSubCategory" runat="server" Text="Cancel" CssClass="styled-button-1" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <div style="max-height: 200px; max-width: 70%; overflow: auto">
                    <asp:GridView ID="grdSubCategory" runat="server" AutoGenerateColumns="False" CssClass="mGrid"
                        EmptyDataText="No Sub Category Found">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:TemplateField HeaderText="SubCategoryID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblSubCategoryID" runat="server" Text='<%# Bind("SubCategoryID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sub Category">
                                <ItemTemplate>
                                    <asp:Label ID="lblSubCategory" runat="server" Text='<%# Bind("SubCategory") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="CategoryID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblSCCategoryID" runat="server" Text='<%# Bind("CategoryID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category">
                                <ItemTemplate>
                                    <asp:Label ID="lblCategoryName" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Details">
                                <ItemTemplate>
                                    <asp:Label ID="lblSCDetails" runat="server" Text='<%# Bind("Details") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IsActive">
                                <ItemTemplate>
                                    <asp:Label ID="lblSCIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EntryDate">
                                <ItemTemplate>
                                    <asp:Label ID="lblSCEntryDate" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlItems" runat="server" SkinID="pnlInner" Width="70%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Items</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                                <asp:HiddenField ID="hdFldItemID" runat="server" />
                            </td>
                            <td style="width: 250px">
                                <asp:RequiredFieldValidator ID="reqFldItmCategoryList" runat="server" ControlToValidate="drpItmCategoryList"
                                    Display="None" ErrorMessage="Required: Category" ValidationGroup="Items"></asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 150px">
                                <cc1:ValidatorCalloutExtender ID="reqFldCategoryList_ValidatorCalloutExtender0" runat="server"
                                    CloseImageUrl="../Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldCategoryList" WarningIconImageUrl="../Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldItmSubCategoryList" runat="server" ControlToValidate="drpItmSubCategoryList"
                                    Display="None" ErrorMessage="Required: Sub Category" ValidationGroup="Items"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Select Category
                            </td>
                            <td>
                                <asp:DropDownList ID="drpItmCategoryList" runat="server" Width="200px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                Sub Category
                            </td>
                            <td>
                                <asp:DropDownList ID="drpItmSubCategoryList" runat="server" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Item
                            </td>
                            <td>
                                <asp:TextBox ID="txtItem" runat="server" Width="200px"></asp:TextBox>
                            </td>
                            <td class="label">
                                Is Active
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsItemActive" runat="server" CssClass="label" Text="(Check If YES)" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Description
                            </td>
                            <td>
                                <asp:TextBox ID="txtItemDescription" runat="server" TextMode="MultiLine" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldItem" runat="server" ControlToValidate="txtItem"
                                    Display="None" ErrorMessage="Required: Item" ValidationGroup="Items"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldSubCategory_ValidatorCalloutExtender0" runat="server"
                                    CloseImageUrl="../Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldSubCategory" WarningIconImageUrl="../Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldItemDescription" runat="server" ControlToValidate="txtItemDescription"
                                    Display="None" ErrorMessage="Required: Item Descriptoin" ValidationGroup="Items"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnAddItems" runat="server" Text="Add" CssClass="styled-button-1"
                                    ValidationGroup="Items" />
                                &nbsp;<asp:Button ID="btnUpdateItems" runat="server" CssClass="styled-button-1" Text="Update"
                                    ValidationGroup="Items" />
                                &nbsp;<asp:Button ID="btnCancelItems" runat="server" Text="Cancel" CssClass="styled-button-1" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <div style="max-height: 200px; max-width: 70%; overflow: auto">
                    <asp:GridView ID="grdItems" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:TemplateField HeaderText="ItemID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblItemID" runat="server" Text='<%# Bind("ItemID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ItemName">
                                <ItemTemplate>
                                    <asp:Label ID="lblItemName" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="CategoryID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblItmCategoryID" runat="server" Text='<%# Bind("CategoryID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category">
                                <ItemTemplate>
                                    <asp:Label ID="lblItmCategoryName" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SubCategoryID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblItmSubCategoryID" runat="server" Text='<%# Bind("SubCategoryID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sub-Category">
                                <ItemTemplate>
                                    <asp:Label ID="lblItmSubCategory" runat="server" Text='<%# Bind("SubCategory") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Details">
                                <ItemTemplate>
                                    <asp:Label ID="lblItmDetails" runat="server" Text='<%# Bind("Details") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IsActive">
                                <ItemTemplate>
                                    <asp:Label ID="lblItmIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EntryBy">
                                <ItemTemplate>
                                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EntryDate">
                                <ItemTemplate>
                                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
