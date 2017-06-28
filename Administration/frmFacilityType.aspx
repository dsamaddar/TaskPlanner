<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    CodeFile="frmFacilityType.aspx.vb" Inherits="Administration_frmFacilityType"
    Theme="CommonSkin" Title=".:Chaser:Facility Type:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlFacilityType" runat="server" Width="60%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widget-title">
                                    Facility Type Definition</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 250px">
                                <asp:HiddenField ID="hdFldFacilityTypeID" runat="server" />
                            </td>
                            <td>
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Facility Type
                            </td>
                            <td>
                                <asp:TextBox ID="txtFacilityType" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldFacilityType" runat="server" ControlToValidate="txtFacilityType"
                                    Display="None" ErrorMessage="Required: Facility Type" ValidationGroup="FacilityType"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldFacilityType_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldFacilityType" WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Is Active
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="chkText" Text="(Check If YES)" />
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
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" Style="height: 26px" ValidationGroup="FacilityType" />
                                &nbsp;<asp:Button ID="btnUpdate" runat="server" Text="Update" ValidationGroup="FacilityType" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" />
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
                <div style="max-height: 300px; max-width: 60%; overflow: auto">
                    <asp:GridView ID="grdFacilityType" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:TemplateField HeaderText="FacilityTypeID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblFacilityTypeID" runat="server" Text='<%# Bind("FacilityTypeID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FacilityType">
                                <ItemTemplate>
                                    <asp:Label ID="lblFacilityType" runat="server" Text='<%# Bind("FacilityType") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IsActive">
                                <ItemTemplate>
                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EntryBy">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EntryDate">
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
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
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
