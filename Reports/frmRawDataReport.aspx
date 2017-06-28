<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmRawDataReport.aspx.vb" Inherits="Reports_frmRawDataReport"
    Title=".:Chaser:Raw Data Report:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlRawDataReport" runat="server" Width="70%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Raw Data Report<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width:20px">
                            </td>
                            <td style="width:150px">
                            </td>
                            <td style="width:200px">
                            </td>
                            <td style="width:150px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Date From
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateFrom" runat="server" Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateFrom_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateFrom">
                                </cc1:CalendarExtender>
                            </td>
                            <td class="label">
                                Date To
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateTo" runat="server"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateTo_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateTo">
                                </cc1:CalendarExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Report Format</td>
                            <td>
                                <asp:DropDownList ID="drpReportFormat" runat="server"  CssClass="inputtxtbox">
                                    <asp:ListItem Text="RichText" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="WordForWindows" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Excel" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="PorttableDocFormat" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="ExcelRecord" Value="8"></asp:ListItem>
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
                                <asp:Button ID="btnGenerateReport" runat="server" CssClass="styled-button-1" 
                                    Text="Generate Report" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
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
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
