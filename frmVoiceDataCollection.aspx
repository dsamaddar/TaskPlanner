<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmVoiceDataCollection.aspx.vb" Inherits="frmVoiceDataCollection"
    Title=".:Chaser:Voice Data Collection:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlVoiceDataCollection" runat="server" Width="70%" BorderStyle="Solid"
                    SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widget-title">
                                    Voice Data Collection</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                                <asp:RequiredFieldValidator ID="reqFldClientList" runat="server" ControlToValidate="drpClientList"
                                    Display="None" ErrorMessage="Required: Client List" ValidationGroup="DataCollection"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldClientList_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldClientList" WarningIconImageUrl="~/Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldExecutiveList" runat="server" ControlToValidate="drpExecutiveList"
                                    Display="None" ErrorMessage="Required: Executive List" ValidationGroup="DataCollection"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldExecutiveList_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldExecutiveList" WarningIconImageUrl="~/Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Facility
                            </td>
                            <td>
                                <asp:DropDownList ID="drpFacilityType" runat="server" Width="200px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                            </td>
                            <td class="label">
                                Executive
                            </td>
                            <td>
                                <asp:DropDownList ID="drpExecutiveList" runat="server" Width="200px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Client
                            </td>
                            <td>
                                <asp:DropDownList ID="drpClientList" runat="server" Width="200px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                            </td>
                            <td class="label">
                                Agreement
                            </td>
                            <td>
                                <asp:DropDownList ID="drpAgreementList" runat="server" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Data Frequency
                            </td>
                            <td>
                                <asp:DropDownList ID="drpDataFrequency" runat="server" Width="120px">
                                    <asp:ListItem>Regular</asp:ListItem>
                                    <asp:ListItem>Monthly</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                            </td>
                            <td class="label">
                                Voice Source
                            </td>
                            <td>
                                <asp:FileUpload ID="flupVoiceData" runat="server" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Collection Date
                            </td>
                            <td>
                                <asp:TextBox ID="txtCollectionDate" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldAgreementList" runat="server" ControlToValidate="drpAgreementList"
                                    Display="None" ErrorMessage="Required: Agreement List" ValidationGroup="DataCollection"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldAgreementList_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldAgreementList" WarningIconImageUrl="~/Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldDataCollectionDate" runat="server" ControlToValidate="txtCollectionDate"
                                    Display="None" ErrorMessage="Required: Collection Date" ValidationGroup="DataCollection"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="valCallUserID" runat="server" TargetControlID="reqFldDataCollectionDate"
                                    CloseImageUrl="~/Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    WarningIconImageUrl="~/Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
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
                                <asp:Button ID="btnSubmitData" runat="server" Text="Submit" CssClass="styled-button-1"
                                    ValidationGroup="DataCollection" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="styled-button-1" />
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
                <div style="width: 70%; max-height: 400px; overflow: auto">
                    <asp:GridView ID="grdVoiceDataColl" runat="server" AutoGenerateColumns="False" CssClass="mGrid"
                        EmptyDataText="NO Voice Collected">
                        <Columns>
                            <asp:TemplateField HeaderText="VoiceDataCollectionID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("VoiceDataCollectionID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Facility">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Facility") %>'></asp:Label>
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
                                    <asp:HyperLink ID="hplnkVoiceData" CssClass="linkbtn" runat="server" NavigateUrl='<%# ConfigurationManager.AppSettings("OutputChaserFile") +  Eval("DataSource") %>'
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
