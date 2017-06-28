<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmWhoAssignsChase.aspx.vb" Inherits="frmWhoAssignsChase"
    Title=".:Chaser:Initiator Report:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">

    <script language="JavaScript" type="text/javascript">
    function openWindow(windowURL,windowName,windowWidth,windowHeight) {

    var left = (screen.width/2)-(windowWidth/2);
    var top = (screen.height/2)-(windowHeight/2);



    window.name = 'parentWnd';
    newWindow = window.open(windowURL,windowName,'top='+ top +',left='+ left +',width='+windowWidth+',height='+windowHeight+',toolbar=0,location=no,directories=0, status=0,menuBar=0,scrollBars=1,resizable=1');
    newWindow.focus();
    }
    </script>

    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlSearchCriterion" runat="server" Width="60%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Task Initiator<asp:ScriptManager ID="ScriptManager1" runat="server">
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
                                Task Initiator
                            </td>
                            <td>
                                <asp:DropDownList ID="drpTaskInitiator" runat="server" CssClass="InputTxtBox" Width="200px">
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
                            <td class="label">
                                Date From
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateFrom_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateFrom">
                                </cc1:CalendarExtender>
                                &nbsp;
                            </td>
                            <td class="label">
                                Date To
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateTo_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateTo">
                                </cc1:CalendarExtender>
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                                <asp:Button ID="btnShow" runat="server" CssClass="styled-button-1" Text="Show" />
                            </td>
                            <td class="label">
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <div style="max-height: 500px; max-width: 80%; overflow: auto">
                    <asp:GridView ID="grdChaserReportDetails" runat="server" AutoGenerateColumns="False"
                        CssClass="mGrid" EmptyDataText="No Chase Information Available">
                        <Columns>
                            <asp:TemplateField HeaderText="Chase ID">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkbtnChaseDetails" runat="server" CausesValidation="False" CssClass="linkbtn"
                                        Font-Size="14px" OnClientClick='<%# Eval("MasterChaseID","openWindow(""frmChaseDetailsView.aspx?GeneratedChaseID={0}"",""Popup"",1000,1100);") %>'
                                        Text='<%# Bind("Sequence") %>'>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit" Visible="false">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkBtnEditChase" runat="server" CausesValidation="False" CssClass="linkbtn"
                                        Font-Size="14px" OnClientClick='<%# Eval("MasterChaseID","openWindow(""frmChaseEditView.aspx?MasterChaseID={0}"",""Popup"",800,600);") %>'
                                        Text="Edit">
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Add Note" Visible="false">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkBtnAddNote" runat="server" CausesValidation="False" CommandName="Select"
                                        Text="Note"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Category") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SubCategory" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("SubCategory") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Item" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("Item") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Chase">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("ChaseName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ContactPerson">
                                <ItemTemplate>
                                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("ContactPerson") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Initiator">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Initiator") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Initiator Remarks" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("InitiatorRemarks") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Initiation Date">
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("InitiationDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("ChaseStatus") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="AssignedTo">
                                <ItemTemplate>
                                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("AssignedTo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="GeneratedChaseID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblGeneratedChaseID" runat="server" Text='<%# Bind("GeneratedChaseID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ChaseDefinitionID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblChaseDefinitionID" runat="server" Text='<%# Bind("ChaseDefinitionID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="MasterChaseID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblMasterChaseID" runat="server" Text='<%# Bind("MasterChaseID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description" Visible="true">
                                <ItemStyle Wrap="true" Width="200px" />
                                <ItemTemplate>
                                    <asp:Label ID="Label11" runat="server" Text='<%#  Left(Eval("Description").ToString(), 200) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="AssignmentHistory" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="Label12" runat="server" Text='<%# Bind("AssignmentHistory") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FinalStatus">
                                <ItemTemplate>
                                    <asp:Label ID="lblFinalStatus" runat="server" Text='<%# Bind("FinalStatus") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
