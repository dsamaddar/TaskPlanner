<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmChangeAssignedPerson.aspx.vb" Inherits="frmChangeAssignedPerson"
    Title=".:Chaser:Change Assigned Person:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">

    <script language="JavaScript" type="text/javascript">
    function openWindow(windowURL,windowName,windowWidth,windowHeight) {

    var left = (screen.width/2)-(windowWidth/2);
    var top = (screen.height/2)-(windowHeight/2);



    window.name = 'parentWnd';
    newWindow = window.open(windowURL,windowName,'top='+ top +',left='+ left +',width='+windowWidth+',height='+windowHeight+',toolbar=0,location=no,directories=0, status=0,menuBar=0,scrollBars=1,resizable=1');
    newWindow.focus();
    }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlSelectAssignedPerson" runat="server" Width="80%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="3">
                                <div class="widget-title">
                                    Change Assigned Person</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 200px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label" align="right">
                                Assigned Person
                            </td>
                            <td>
                                <asp:DropDownList ID="drpAssignmentPendUsers" runat="server" CssClass="InputTxtBox"
                                    Width="200px" AutoPostBack="True">
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
                <div style="max-height: 300px; max-width: 80%; overflow: auto">
                    <asp:GridView ID="grdChasePendingAtUser" runat="server" AutoGenerateColumns="False"
                        CssClass="mGrid">
                        <Columns>
                            <asp:TemplateField HeaderText="Check">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelectChase" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Chase ID">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkbtnChaseDetails" runat="server" CausesValidation="False" CssClass="linkbtn"
                                        Font-Size="14px" OnClientClick='<%# Eval("MasterChaseID","openWindow(""frmChaseDetailsView.aspx?GeneratedChaseID={0}"",""Popup"",1000,1100);") %>'
                                        Text='<%# Bind("Sequence") %>'>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="GeneratedChaseID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblGeneratedChaseID" runat="server" Text='<%# Bind("GeneratedChaseID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="MasterChaseID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblMasterChaseID" runat="server" Text='<%# Bind("MasterChaseID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ChaseDefinitionID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblChaseDefinitionID" runat="server" Text='<%# Bind("ChaseDefinitionID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Chase">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("ChaseName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Contact-Person">
                                <ItemTemplate>
                                    <asp:Label ID="lblContactPerson" runat="server" Text='<%# Bind("ContactPerson") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Initiator">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Initiator") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="InitiationDate">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("InitiationDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="InitiatorRemarks">
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("InitiatorRemarks") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FinalStatus">
                                <ItemTemplate>
                                    <asp:Label ID="lblFinalStatus" runat="server" Text='<%# Bind("FinalStatus") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description" Visible="true">
                                <ItemStyle Wrap="true" Width="200px" />
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Left(Eval("Description").ToString(), 200) %>'></asp:Label>
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
                <asp:Panel ID="pnlChangeAssPerson" runat="server" SkinID="pnlInner" Width="80%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 200px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label" align="right">
                                Changed To
                            </td>
                            <td>
                                <asp:DropDownList ID="drpAllEmpList" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnChange" runat="server" Text="Change" CssClass="styled-button-1"
                                    OnClientClick="if (!confirm('Are you Sure to Change Support Person ?')) return false" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
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
