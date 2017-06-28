<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/ChaserMaster.master"
    AutoEventWireup="false" CodeFile="frmRoleWiseMenuPermission.aspx.vb" Inherits="Administration_frmRoleWiseMenuPermission"
    Title=".:Chaser:Role Wise Menu Permission:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlAvailableProfile" runat="server" Width="700px" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="4">
                                <div class="widgettitle">
                                    Role Wise Menu Permission</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 230px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Select Role
                            </td>
                            <td>
                                <asp:DropDownList ID="drpRoleList" runat="server" CssClass="InputTxtBox" Width="200px"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnSave" runat="server" CssClass="styled-button-1" Text="Save Changes" />
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
                <asp:Panel ID="pnlMenuPermission" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td class="label">
                                Administration
                            </td>
                            <td class="label">
                                Voice Data
                            </td>
                            <td class="label">
                                Generate Chase
                            </td>
                            <td class="label">
                                User Wise Chase
                            </td>
                            <td class="label">
                                Reports
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <asp:GridView ID="grdAdministrationMenu" runat="server" AutoGenerateColumns="False"
                                    CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectAdminMenu" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAdminMenuID" runat="server" Text='<%# Bind("MenuID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuName">
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("MenuName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td valign="top">
                                <asp:GridView ID="grdVoiceDataCollection" runat="server" AutoGenerateColumns="False"
                                    CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectVoiceDataCollMenu" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVoiceDataMenuID" runat="server" Text='<%# Bind("MenuID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuName">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("MenuName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td valign="top">
                                <asp:GridView ID="grdGenerateChase" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectGenerateChaseMenu" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGenerateChaseMenuID" runat="server" Text='<%# Bind("MenuID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuName">
                                            <ItemTemplate>
                                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("MenuName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td valign="top">
                                <asp:GridView ID="grdUserWiseChase" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectUserWiseChaseMenu" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUserWiseChaseMenuID" runat="server" Text='<%# Bind("MenuID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuName">
                                            <ItemTemplate>
                                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("MenuName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td valign="top">
                                <asp:GridView ID="grdReports" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectReports" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblReportsID" runat="server" Text='<%# Bind("MenuID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuName">
                                            <ItemTemplate>
                                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("MenuName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" class="label">
                                Market Info</td>
                            <td valign="top">
                            </td>
                            <td valign="top">
                            </td>
                            <td valign="top">
                            </td>
                            <td valign="top">
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <asp:GridView ID="grdMarketInfoMenu" runat="server" AutoGenerateColumns="False"
                                    CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectMarketInfo" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMarketInfoMenuID" runat="server" Text='<%# Bind("MenuID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuName">
                                            <ItemTemplate>
                                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("MenuName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td valign="top">
                            </td>
                            <td valign="top">
                            </td>
                            <td valign="top">
                            </td>
                            <td valign="top">
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
