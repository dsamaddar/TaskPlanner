<%@ Page Language="VB" AutoEventWireup="false" CodeFile="frmChaseDetailsView.aspx.vb"
    Theme="CommonSkin" Inherits="frmChaseDetailsView" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>.:Chaser:Chase Details View:.</title>
    <link href="Sources/css/Title.css" rel="stylesheet" type="text/css" />
    <link href="Sources/css/GridStyle.css" rel="stylesheet" type="text/css" />
    <link href="Sources/css/ChaserCssClass.css" rel="stylesheet" type="text/css" />
    <link href="Sources/css/Tab.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <table style="width: 100%">
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
        </tr>
        <tr align="center">
            <td align="center">
                <cc1:TabContainer ID="tabBenefitComponents" CssClass="MyTabStyle" runat="server"
                    ActiveTabIndex="0" Width="100%">
                    <cc1:TabPanel ID="tabPnlChaseDetails" runat="server" HeaderText="Chase Info">
                        <HeaderTemplate>
                            <table width="100%">
                                <tr align="left">
                                    <td align="left" valign="top">
                                        <img src="Sources/img/details_icon.jpg" style="max-height: 30px; max-width: 30px" />
                                    </td>
                                    <td align="left" valign="top">
                                        <b>Chase Details</b>
                                    </td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ContentTemplate>
                            <asp:Panel ID="pnlChaseDetailsVeiw" runat="server" SkinID="pnlInner" Width="100%">
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <div class="widget-title">
                                                Contact Person Details</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblContactDetails" runat="server" CssClass="label"></asp:Label>
                                            &#160;|
                                            <asp:Label ID="lblPriorityInfo" runat="server" CssClass="chkText"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td>
                                            <div class="widget-title">
                                                Chase Options
                                            </div>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td>
                                            <asp:GridView ID="grdChaseInputValues" runat="server" AutoGenerateColumns="False"
                                                CssClass="mGrid" Font-Size="Small">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="ReportingHead">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblReportingHead" runat="server" Text='<%# Bind("ReportingHead") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Value">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblValue" runat="server" Text='<%# Bind("Value") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td>
                                            <div class="widget-title">
                                                Chase Feedback History</div>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td>
                                            <asp:GridView ID="grdChaseFeedBackHistory" runat="server" AutoGenerateColumns="False"
                                                CssClass="mGrid" EmptyDataText="No Feed Back Found" ShowFooter="True">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SLNo">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("SLNo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Initiator">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("InitiatorName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Dated">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("InitiationDate") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="I.Remarks">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("InitiatorRemarks") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Uploaded File">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="hpDocument" runat="server" CssClass="linkbtn" NavigateUrl='<%#  ConfigurationManager.AppSettings("OutputChaserFile") + Eval("UploadedFile") %>'
                                                                Target="_blank">View</asp:HyperLink>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Assigned To">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("AssignedTo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Remarks">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("Remarks") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Terminated">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("IsTerminated") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="TimeTaken[min]">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTimeTaken" runat="server" Text='<%# Bind("TimeTaken") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Chase Progress">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("ChaseProgress") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Chase Status">
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label10" runat="server" Text='<%# Bind("ChaseStatus") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <EmptyDataRowStyle ForeColor="Red" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <asp:Chart ID="crtChaser" runat="server" BackColor="" BorderlineColor="Transparent"
                                                Width="400px">
                                                <Titles>
                                                    <asp:Title Name="Items" ShadowOffset="3" />
                                                </Titles>
                                                <Series>
                                                    <asp:Series Name="Default" ChartArea="ChartArea1" Legend="Default" />
                                                </Series>
                                                <ChartAreas>
                                                    <asp:ChartArea Name="ChartArea1">
                                                        <AxisY>
                                                            <MajorGrid LineWidth="0" />
                                                        </AxisY>
                                                        <AxisX>
                                                            <MajorGrid LineWidth="0" />
                                                        </AxisX>
                                                    </asp:ChartArea>
                                                </ChartAreas>
                                                <Legends>
                                                    <asp:Legend Alignment="Center" Docking="Bottom" IsTextAutoFit="False" LegendStyle="Row"
                                                        Name="Default" />
                                                </Legends>
                                            </asp:Chart>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            &#160;
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </ContentTemplate>
                    </cc1:TabPanel>
                    <cc1:TabPanel ID="tabPnlChaseNotes" runat="server" HeaderText="Notes">
                        <HeaderTemplate>
                            <table width="100%">
                                <tr align="left">
                                    <td align="left" valign="top">
                                        <img src="Sources/img/note_icon.jpg" style="max-height: 30px; max-width: 30px" />
                                    </td>
                                    <td align="left" valign="top">
                                        <b>Note</b>
                                    </td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ContentTemplate>
                            <asp:Panel ID="pnlNotes" runat="server" SkinID="pnlInner">
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <div class="widget-title">
                                                Chase Notes</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div style="max-height: 300px; max-width: 100%; overflow: auto">
                                                <asp:GridView ID="grdNotesByChase" runat="server" AutoGenerateColumns="False" CssClass="mGrid"
                                                    EmptyDataText="No Note Available">
                                                    <Columns>
                                                        <asp:BoundField DataField="ChaseNoteID" HeaderText="ChaseNoteID" Visible="False" />
                                                        <asp:BoundField DataField="Notes" HeaderText="Notes" />
                                                        <asp:TemplateField HeaderText="Attachment">
                                                            <ItemTemplate>
                                                                <asp:HyperLink ID="hplnkNoteAttachments" runat="server" CssClass="linkbtn" NavigateUrl='<%#  ConfigurationManager.AppSettings("OutputChaserFile") + Eval("Attachments") %>'
                                                                    Target="_blank" Text='<%# Bind("Attachments") %>'></asp:HyperLink></ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="EntryBy" HeaderText="EntryBy" />
                                                        <asp:BoundField DataField="Dated" HeaderText="Dated" />
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </ContentTemplate>
                    </cc1:TabPanel>
                </cc1:TabContainer>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
