<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" Theme="CommonSkin"
    AutoEventWireup="false" CodeFile="frmMasterReportTool.aspx.vb" Inherits="Administration_frmMasterReportTool"
    Title=".:Chaser:Report Tool:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlChaseRptTool" runat="server" Width="600px" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widget-title">
                                    Master Report Tool<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 300">
                                <asp:HiddenField ID="hdFldMasterReportID" runat="server" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Select Chase Definition
                            </td>
                            <td>
                                <asp:DropDownList ID="drpChaseList" runat="server" Width="300px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Name Of Report
                            </td>
                            <td>
                                <asp:TextBox ID="txtReportHeaderName" runat="server" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldNameOfReport" runat="server" ControlToValidate="txtReportHeaderName"
                                    Display="None" ErrorMessage="Required: Name Of Report" ValidationGroup="ReportTool"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldNameOfReport_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="../Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldNameOfReport" WarningIconImageUrl="../Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
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
                            <td class="label">
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
                <asp:Panel ID="pnlItemChoice" runat="server" Width="600px" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td>
                                <asp:ListBox ID="lstbxReportHeader" runat="server" Width="250px" CssClass="InputTxtBox"
                                    Height="200px"></asp:ListBox>
                            </td>
                            <td>
                                <asp:Button ID="btnAdd" runat="server" CssClass="styled-button-1" Text="&gt;&gt;" />
                                <br />
                                <asp:Button ID="btnRemove" runat="server" CssClass="styled-button-1" Text="&lt;&lt;" />
                            </td>
                            <td>
                                <asp:ListBox ID="lstbxChosenItems" runat="server" Width="250px" CssClass="InputTxtBox"
                                    Height="200px"></asp:ListBox>
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
                <asp:Panel ID="pnlButtons" runat="server" Width="600px" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnSave" runat="server" CssClass="styled-button-1" Text="Save" ValidationGroup="ReportTool" />
                                &nbsp;<asp:Button ID="btnUpdate" runat="server" CssClass="styled-button-1" Text="Update"
                                    ValidationGroup="ReportTool" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
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
                <asp:Panel ID="pnlExistingReports" runat="server" SkinID="pnlInner" Width="600px">
                    <div>
                        <asp:GridView ID="grdMasterReports" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="MasterReportID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMasterReportID" runat="server" Text='<%# Bind("MasterReportID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ChaseDefinitionID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblChaseDefinitionID" runat="server" Text='<%# Bind("ChaseDefinitionID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Report Header">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReportName" runat="server" Text='<%# Bind("ReportName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Active">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Entry By">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntryBy" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Entry Date">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
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
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
