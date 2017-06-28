<%@ Page Language="VB" MasterPageFile="~/UserPanel/ChaserUserPanel.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmSupervisorRptView.aspx.vb" Inherits="UserPanel_frmSupervisorRptView"
    Title=".:Chaser:Subordinate Reporting:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlSearchCriteria" runat="server" Width="80%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widget-title">
                                    Subordinate Reporting</div>
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
                                Select Subordinate
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSubordinateList" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                            </td>
                            <td class="label">
                                Chase
                            </td>
                            <td>
                                <asp:DropDownList ID="drpChaseList" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Status
                            </td>
                            <td>
                                <asp:DropDownList ID="drpChaseStatus" runat="server" CssClass="InputTxtBox" Width="200px">
                                    <asp:ListItem>N\A</asp:ListItem>
                                    <asp:ListItem>Assigned</asp:ListItem>
                                    <asp:ListItem>Forwarded</asp:ListItem>
                                    <asp:ListItem>Terminated</asp:ListItem>
                                </asp:DropDownList>
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
                                <asp:Button ID="btnShow" runat="server" CssClass="styled-button-1" Text="Show" />
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
                <asp:Panel ID="pnlReportView" runat="server" Width="80%" SkinID="pnlInner">
                    <div>
                        <asp:GridView ID="grdSupervisorView" runat="server" AutoGenerateColumns="False" CssClass="mGrid"
                            EmptyDataText="No Data Available">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="GeneratedChaseID" HeaderText="GeneratedChaseID" Visible="False" />
                                <asp:BoundField DataField="MasterChaseID" HeaderText="MasterChaseID" Visible="False" />
                                <asp:BoundField DataField="Category" HeaderText="Category" Visible="False" />
                                <asp:BoundField DataField="SubCategory" HeaderText="SubCategory" Visible="False" />
                                <asp:BoundField DataField="Item" HeaderText="Item" Visible="False" />
                                <asp:BoundField DataField="ChaseName" HeaderText="ChaseName" />
                                <asp:BoundField DataField="Initiator" HeaderText="Initiator" />
                                <asp:BoundField DataField="InitiatorRemarks" HeaderText="InitiatorRemarks" />
                                <asp:BoundField DataField="InitiationDate" HeaderText="InitiationDate" />
                                <asp:BoundField DataField="ChaseStatus" HeaderText="ChaseStatus" />
                                <asp:BoundField DataField="AssignedTo" HeaderText="AssignedTo" />
                                <asp:TemplateField HeaderText="Description" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
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
