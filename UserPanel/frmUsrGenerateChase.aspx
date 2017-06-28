<%@ Page Language="VB" MasterPageFile="~/UserPanel/ChaserUserPanel.master" AutoEventWireup="false"
    CodeFile="frmUsrGenerateChase.aspx.vb" Inherits="UserPanel_frmUsrGenerateChase" Theme="CommonSkin" 
    Title=".:Chaser:Generate Chase:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Panel ID="pnlChase" runat="server" Width="80%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left" >
                            <td>
                                <div class="widget-title">
                                    Generate Chase
                                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="width: 100%; max-height: 400px; overflow: auto">
                                    <asp:GridView ID="grdVoiceDataColl" runat="server" AutoGenerateColumns="False" CssClass="mGrid"
                                        EmptyDataText="NO Voice Collected">
                                        <Columns>
                                            <asp:CommandField ShowSelectButton="True" />
                                            <asp:TemplateField HeaderText="VoiceDataCollectionID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVoiceDataCollectionID" runat="server" Text='<%# Bind("VoiceDataCollectionID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FacilityTypeID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFacilityTypeID" runat="server" Text='<%# Bind("FacilityTypeID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Facility">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFacility" runat="server" Text='<%# Bind("Facility") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ServiceManager">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("ServiceManager") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Client">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Client") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Agreement">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("Agreement") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Dated">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("Dated") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="DataFrequency">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("DataFrequency") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="DataSource">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="hplnkVoiceData" runat="server" CssClass="linkbtn" NavigateUrl='<%#  ConfigurationManager.AppSettings("OutputChaserFile")+ Eval("DataSource") %>'
                                                        Target="_blank" Text='<%# Bind("DataSource") %>'></asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="EntryBy">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlChaseParameter" runat="server" Width="80%" BorderStyle="None" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 200px">
                            </td>
                            <td style="width: 200px" class="label">
                                Select Chase From The List
                            </td>
                            <td>
                                <asp:DropDownList ID="drpChaseList" runat="server" AutoPostBack="True" Width="200px"
                                    CssClass="InputTxtBox">
                                </asp:DropDownList>
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
                &nbsp;
            </td>
            <td>
                <asp:Panel ID="pnlContactPerson" runat="server" SkinID="pnlInner" Width="80%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widget-title">
                                    Contact Person
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                                Branch
                            </td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="drpULCBranchList" runat="server" AutoPostBack="True" Width="200px"
                                    CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                            <td class="label" style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                                Contact Person
                            </td>
                            <td>
                                <asp:DropDownList ID="drpRequestFor" runat="server" Width="200px" CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlGeneratedControls" runat="server" Width="80%" BorderStyle="None"
                    SkinID="pnlInner">
                </asp:Panel>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlGenerateChase" runat="server" Width="80%" BorderStyle="None" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 200px">
                                &nbsp;
                            </td>
                            <td style="width: 200px" class="label">
                                &nbsp;
                            </td>
                            <td style="width: 200px">
                                &nbsp;
                            </td>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 200px">
                            </td>
                            <td class="label" style="width: 200px">
                                Mode Of Communication
                            </td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="drpModeOfCommunication" runat="server" Width="200px" CssClass="InputTxtBox">
                                    <asp:ListItem>Direct Communication</asp:ListItem>
                                    <asp:ListItem>E-Mail</asp:ListItem>
                                    <asp:ListItem>Phone Call</asp:ListItem>
                                    <asp:ListItem>Web Form</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                Priority
                            </td>
                            <td>
                                <asp:DropDownList ID="drpPriority" runat="server" Width="200px" CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Select Assigned Person
                            </td>
                            <td>
                                <asp:DropDownList ID="drpIntRepList" runat="server" Width="200px" CssClass="InputTxtBox">
                                </asp:DropDownList>
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
                                <asp:Button ID="btnGenerateChase" runat="server" CssClass="styled-button-1" Text="Generate Chase"
                                    ValidationGroup="CheckForm" />
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
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
