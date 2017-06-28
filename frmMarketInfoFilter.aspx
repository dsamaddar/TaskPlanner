<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/ChaserMaster.master"
    AutoEventWireup="false" CodeFile="frmMarketInfoFilter.aspx.vb" Inherits="frmMarketInfoFilter"
    Title=".:Chaser:Market Info Filter:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlMktInfoFilter" runat="server" SkinID="pnlInner" Width="80%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Market Information Filter<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
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
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Date From
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="inputtxtbox" Width="150px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateFrom_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateFrom">
                                </cc1:CalendarExtender>
                            </td>
                            <td class="label">
                                Date To
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="inputtxtbox" Width="150px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateTo_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateTo">
                                </cc1:CalendarExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Contact Type
                            </td>
                            <td>
                                <asp:DropDownList ID="drpContactType" runat="server" CssClass="inputtxtbox" Width="150px">
                                    <asp:ListItem Text="N\A" Value="N\A"></asp:ListItem>
                                    <asp:ListItem Text="DMD" Value="DMD"></asp:ListItem>
                                    <asp:ListItem Text="GM" Value="GM"></asp:ListItem>
                                    <asp:ListItem Text="Manager Ac-Fin" Value="Manager Ac-Fin"></asp:ListItem>
                                    <asp:ListItem Text="MD" Value="MD"></asp:ListItem>
                                    <asp:ListItem Text="Others" Value="Others"></asp:ListItem>
                                    <asp:ListItem Text="Proprietor" Value="Proprietor"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                Purpose
                            </td>
                            <td>
                                <asp:DropDownList ID="drpPurpose" runat="server" CssClass="inputtxtbox" Width="150px">
                                    <asp:ListItem Text="N\A" Value="N\A"></asp:ListItem>
                                    <asp:ListItem Text="Customer Meeting" Value="Customer Meeting"></asp:ListItem>
                                    <asp:ListItem Text="Customer not available" Value="Customer not available"></asp:ListItem>
                                    <asp:ListItem Text="Data Capture" Value="Data Capture"></asp:ListItem>
                                    <asp:ListItem Text="Debtor Meeting" Value="Debtor Meeting"></asp:ListItem>
                                    <asp:ListItem Text="Documentation" Value="Documentation"></asp:ListItem>
                                    <asp:ListItem Text="Payment done" Value="Payment done"></asp:ListItem>
                                    <asp:ListItem Text="Re-visit schedule (from ULC end)" Value="Re-visit schedule (from ULC end)"></asp:ListItem>
                                    <asp:ListItem Text="Re-Visit to be Scheduled" Value="Re-Visit to be Scheduled"></asp:ListItem>
                                    <asp:ListItem Text="Schedule Event Cancelled" Value="Schedule Event Cancelled"></asp:ListItem>
                                    <asp:ListItem Text="Start" Value="Start"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Rating Type
                            </td>
                            <td>
                                <asp:DropDownList ID="drpRatingType" runat="server" Width="100px">
                                    <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Unrated" Value="Unrated"></asp:ListItem>
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
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
                                <asp:Button ID="btnShowReport" runat="server" CssClass="styled-button-1" Text="Show Report" />
                                &nbsp;
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
                <div style="max-height: 500px; max-width: 80%; overflow: auto">
                    <asp:GridView ID="grdMktInfoFilter" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="MarketInfoID" HeaderText="MarketInfoID" Visible="False" />
                            <asp:BoundField DataField="RE" HeaderText="RE" />
                            <asp:BoundField DataField="ClientCode" HeaderText="Client-Code" />
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                            <asp:BoundField DataField="CPDesignation" HeaderText="CP-Designation" />
                            <asp:BoundField DataField="DataStatus" HeaderText="Purpose" />
                            <asp:BoundField DataField="PrimaryRating" HeaderText="Primary-Rating" />
                            <asp:BoundField DataField="PrimaryRemarks" HeaderText="Primary-Remarks" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:TemplateField HeaderText="Attachment">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hpDocument" runat="server" CssClass="linkbtn" NavigateUrl='<%#"http://192.168.1.242/FileUploader/Attachments/"+ Eval("Attachment") %>'
                                        Target="_blank">View</asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Dated" HeaderText="Dated" />
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
            <td>
            </td>
        </tr>
        <tr>
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
