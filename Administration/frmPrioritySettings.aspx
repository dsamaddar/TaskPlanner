<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/ChaserMaster.master"
    AutoEventWireup="false" CodeFile="frmPrioritySettings.aspx.vb" Inherits="Administration_frmPrioritySettings"
    Title=".:Chaser:Priority Settings:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlPrioritySettings" runat="server" Width="70%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widget-title">
                                    Priority Settings<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                                <asp:RequiredFieldValidator ID="reqFldPriorityType" runat="server" ControlToValidate="txtPriorityText"
                                    Display="None" ErrorMessage="Required: Priority Type" ValidationGroup="PriorityType"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldPriorityType_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldPriorityType" WarningIconImageUrl="../Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td style="width: 250px">
                                <asp:HiddenField ID="hdFldPriorityID" runat="server" />
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Priority Text
                            </td>
                            <td>
                                <asp:TextBox ID="txtPriorityText" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Timing
                            </td>
                            <td>
                                <asp:DropDownList ID="drpTiming" runat="server">
                                    <asp:ListItem Value="1">1Hr</asp:ListItem>
                                    <asp:ListItem Value="2">2Hr</asp:ListItem>
                                    <asp:ListItem Value="3">3Hr</asp:ListItem>
                                    <asp:ListItem Value="4">4Hr</asp:ListItem>
                                    <asp:ListItem Value="24">1 Day</asp:ListItem>
                                    <asp:ListItem Value="48">2 Days</asp:ListItem>
                                    <asp:ListItem Value="72">3 Days</asp:ListItem>
                                    <asp:ListItem Value="168">1 Week</asp:ListItem>
                                    <asp:ListItem Value="336">2 Weeks</asp:ListItem>
                                    <asp:ListItem Value="504">3 Weeks</asp:ListItem>
                                    <asp:ListItem Value="672">4 Weeks</asp:ListItem>
                                    <asp:ListItem Value="1008">6 Weeks</asp:ListItem>
                                    <asp:ListItem Value="1344">8 Weeks</asp:ListItem>
                                    <asp:ListItem Value="1680">10 Weeks</asp:ListItem>
                                    <asp:ListItem Value="2016">12 Weeks</asp:ListItem>
                                    <asp:ListItem Value="2352">14 Weeks</asp:ListItem>
                                    <asp:ListItem Value="2688">16 Weeks</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                IsActive
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsActive" runat="server" Text="(Check If YES)" />
                            </td>
                            <td>
                            </td>
                            <td>
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
                                <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="PriorityType" />
                                &nbsp;<asp:Button ID="btnUpdate" runat="server" Text="Update" ValidationGroup="PriorityType" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" />
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
                <asp:Panel ID="pnlPriorityDetails" runat="server" Width="70%" SkinID="pnlInner">
                    <div>
                        <asp:GridView ID="grdPrirityDetails" runat="server" CssClass="mGrid" AutoGenerateColumns="False"
                            EmptyDataText="No Priority Available">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:TemplateField HeaderText="PriorityID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPriorityID" runat="server" Text='<%# Bind("PriorityID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Priority Text">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPriorityText" runat="server" Text='<%# Bind("PriorityText") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Timing(Hrs)">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTiming" runat="server" Text='<%# Bind("Timing") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsActive">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
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
                </asp:Panel>
            </td>
            <td>
            </td>
        </tr>
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
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
