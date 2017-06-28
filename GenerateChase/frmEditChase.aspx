<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmEditChase.aspx.vb" Inherits="GenerateChase_frmEditChase"
    Title=".:Chaser:Edit Chase:." %>

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

    <style type="text/css">
        .paraGraphtext
        {
            white-space: pre-wrap;
        }
        .Grid .Shorter
        {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlSearchChase" runat="server" Width="90%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widget-title">
                                    Edit-Chase<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 400px">
                            </td>
                            <td style="width: 250px">
                                <asp:RequiredFieldValidator ID="reqFldChaseOrID" runat="server" ControlToValidate="txtChaseOrID"
                                    Display="None" ErrorMessage="Required: Chase ID" ValidationGroup="SearchChase"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldChaseOrID_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldChaseOrID" WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Search By Chase/ID/Contact Person/Content Description&nbsp;
                            </td>
                            <td>
                                <asp:TextBox ID="txtChaseOrID" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" runat="server" CssClass="styled-button-1" Text="Search"
                                    ValidationGroup="SearchChase" />
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
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlChaseReportDetails" runat="server" SkinID="pnlInner" Width="90%">
                    <div>
                        <asp:GridView ID="grdChaserReportDetails" runat="server" AutoGenerateColumns="False"
                            CssClass="mGrid">
                            <Columns>
                                <asp:TemplateField HeaderText="Chase ID">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnCanDetailsExamResult" runat="server" CausesValidation="False"
                                            CssClass="linkbtn" Font-Size="14px" OnClientClick='<%# Eval("MasterChaseID","openWindow(""../frmChaseDetailsView.aspx?GeneratedChaseID={0}"",""Popup"",1000,1100);") %>'
                                            Text='<%# Bind("Sequence") %>'>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkBtnEditChase" runat="server" CausesValidation="False" CssClass="linkbtn"
                                            Font-Size="14px" OnClientClick='<%# Eval("MasterChaseID","openWindow(""../frmChaseEditView.aspx?MasterChaseID={0}"",""Popup"",800,600);") %>'
                                            Text="Edit">
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ChaseDefinitionID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("ChaseDefinitionID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="MasterChaseID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="Label12" runat="server" Text='<%# Bind("MasterChaseID") %>'></asp:Label>
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
                                <asp:TemplateField HeaderText="Initiator Remarks">
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
                                <asp:TemplateField HeaderText="Description" Visible="True">
                                    <ItemStyle Wrap="true" Width="200px" />
                                    <ItemTemplate>
                                        <asp:Label ID="Label13" runat="server" CssClass="Shorter" Text='<%# Left(Eval("Description").ToString(), 200) %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
