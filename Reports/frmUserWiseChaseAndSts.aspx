<%@ Page Language="VB" Theme="CommonSkin" AutoEventWireup="false" CodeFile="frmUserWiseChaseAndSts.aspx.vb"
    Inherits="Reports_frmUserWiseChaseAndSts" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>.:Chaser : User Wise Chase:.</title>
    <link href="../Sources/css/Title.css" rel="stylesheet" type="text/css" />
    <link href="../Sources/css/GridStyle.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .linkbtn
        {
            font-family: Arial, Helvetica, sans-serif; /*font-family: Arial, Helvetica, sans-serif;*/
            font-size: 12px;
            text-decoration: underline;
            color: #006E12;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <script language="JavaScript" type="text/javascript">
    function openWindow(windowURL,windowName,windowWidth,windowHeight) {

    var left = (screen.width/2)-(windowWidth/2);
    var top = (screen.height/2)-(windowHeight/2);



    window.name = 'parentWnd';
    newWindow = window.open(windowURL,windowName,'top='+ top +',left='+ left +',width='+windowWidth+',height='+windowHeight+',toolbar=0,location=no,directories=0, status=0,menuBar=0,scrollBars=1,resizable=1');
    newWindow.focus();
    }
    </script>

    <table>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlAssignedChase" runat="server" Width="100%" SkinID="pnlInner">
                    <asp:GridView ID="grdAssignedChase" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                        <Columns>
                            <asp:TemplateField HeaderText="Chase ID">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkbtnGeneratedChaseID" runat="server" CausesValidation="False"
                                        CssClass="linkbtn" Font-Size="14px" OnClientClick='<%# Eval("MasterChaseID","openWindow(""../frmChaseDetailsView.aspx?GeneratedChaseID={0}"",""Popup"",1000,1100);") %>'
                                        Text='<%# Bind("Sequence") %>'>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="MasterChaseID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="lblMasterChaseID" runat="server" Text='<%# Bind("MasterChaseID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Chase">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("ChaseName") %>'></asp:Label>
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
                            <asp:TemplateField HeaderText="Status" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("ChaseStatus") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="AssignedTo" Visible="true">
                                <ItemTemplate>
                                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("AssignedTo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DataSource">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hplnkVoiceData" CssClass="linkbtn" runat="server" NavigateUrl='<%# ConfigurationManager.AppSettings("OutputChaserFile") + Eval("DataSource") %>'
                                        Target="_blank" Text='<%# Bind("DataSource") %>'></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description" Visible="true">
                                <ItemTemplate>
                                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
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
                </asp:Panel>
            </td>
        </tr>
    </table>
     <script language="javascript" type="text/javascript">
        $(document).ready(function(){
            var elem = document.getElementById('<%=grdAssignedChase.ClientID%>');
            $(elem).tablesorter();
         }); 
    </script>
    </form>
</body>
</html>
