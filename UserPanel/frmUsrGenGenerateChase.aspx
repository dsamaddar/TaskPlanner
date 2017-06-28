<%@ Page Language="VB" MasterPageFile="~/UserPanel/ChaserUserPanel.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmUsrGenGenerateChase.aspx.vb" Inherits="UserPanel_frmUsrGenGenerateChase"
    Title=".:Chaser:General Gen. Chase:." %>
<%@ Register TagPrefix="cc1" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.0.30930.28736, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlChaseParameter" runat="server" Width="80%" BorderStyle="None" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widget-title">
                                    General Chase Generation<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
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
                                <asp:DropDownList ID="drpCategoryList" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                            </td>
                            <td class="label">
                                Sub Category
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSubCategoryList" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Select Chase
                            </td>
                            <td>
                                <asp:DropDownList ID="drpChaseList" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                &nbsp;
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
                            <td class="label">
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
                <asp:Panel ID="pnlChaseDetailsInfo" runat="server" Width="80%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Primary Support Rep.
                            </td>
                            <td>
                                <asp:Label ID="lblPrimarySuppRep" runat="server" CssClass="chkText" Width="200px"></asp:Label>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Instruction
                            </td>
                            <td>
                                <asp:Label ID="lblChaseInstruction" runat="server" CssClass="chkText" Width="200px"></asp:Label>
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
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
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
                                Branch
                            </td>
                            <td>
                                <asp:DropDownList ID="drpULCBranchList" runat="server" AutoPostBack="True" Width="200px"
                                    CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                            </td>
                            <td class="label">
                                Contact Person
                            </td>
                            <td>
                                <asp:DropDownList ID="drpRequestFor" runat="server" Width="200px" CssClass="InputTxtBox">
                                </asp:DropDownList>
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
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td class="label">
                            </td>
                            <td>
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
                            <td class="label">
                                Activation Time
                            </td>
                            <td>
                                <asp:TextBox ID="txtActivationTime" runat="server" CssClass="InputTxtBox" Width="190px"></asp:TextBox>
                                <cc1:calendarextender id="txtActivationTime_CalendarExtender" runat="server" enabled="True"
                                    targetcontrolid="txtActivationTime" format="dd-MMM-yyyy">
                                </cc1:calendarextender>
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
