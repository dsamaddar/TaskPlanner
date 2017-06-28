<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmChaserReporting.aspx.vb" Inherits="Reports_frmChaserReporting"
    Title=".:HRS:Chaser Reporting:." %>
<%@ Register TagPrefix="cc1" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.0.30930.28736, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>

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
            </td>
            <td>
                <asp:Panel ID="pnlChaserReportParameter" runat="server" Width="90%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widget-title"><asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                    Chaser Report</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 250px">
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
                            <td>
                            </td>
                            <td class="label">
                                Sub-Category
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
                                Items
                            </td>
                            <td>
                                <asp:DropDownList ID="drpItemList" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Chase</td>
                            <td>
                                <asp:DropDownList ID="drpChaseList" runat="server" AutoPostBack="True" 
                                    CssClass="InputTxtBox" Width="200px">
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
                            <td class="label">
                                Priority
                            </td>
                            <td>
                                <asp:DropDownList ID="drpPriority" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Branch
                            </td>
                            <td>
                                <asp:DropDownList ID="drpULCBranchList" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Final Status
                            </td>
                            <td>
                                <asp:DropDownList ID="drpFinalStatus" runat="server" CssClass="InputTxtBox" Width="200px">
                                    <asp:ListItem Text="All" Value="N\A"></asp:ListItem>
                                    <asp:ListItem Text="Open" Value="Open"></asp:ListItem>
                                    <asp:ListItem Text="Overdue" Value="Overdue"></asp:ListItem>
                                    <asp:ListItem Text="Closed" Value="Closed"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Date From</td>
                            <td>
                                 <asp:TextBox ID="txtDateFrom" runat="server" CssClass="InputTxtBox"  Width="190px" ></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateFrom_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateFrom">
                                </cc1:CalendarExtender>
                                
                                </td>
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Date To</td>
                            <td>
                                  <asp:TextBox ID="txtDateTo" runat="server" CssClass="InputTxtBox" Width="190px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateTo_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateTo">
                                </cc1:CalendarExtender>
                                </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Assigned To</td>
                            <td>
                                <asp:DropDownList ID="drpAssignedTo" runat="server" CssClass="InputTxtBox" 
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnGenerateReport" runat="server" CssClass="styled-button-1" Text="Generate Report" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnExport" runat="server" CssClass="styled-button-1" Text="Export" />
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
                <asp:Panel ID="pnlChaseReportDetails" runat="server" Width="90%" SkinID="pnlInner">
                    <div>
                        <asp:GridView ID="grdChaserReportDetails" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                            <Columns>
                                <asp:TemplateField HeaderText="Chase ID">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnCanDetailsExamResult" runat="server" CausesValidation="False"
                                            CssClass="linkbtn" Font-Size="14px" OnClientClick='<%# Eval("GeneratedChaseID","openWindow(""../frmChaseDetailsView.aspx?GeneratedChaseID={0}"",""Popup"",1000,1100);") %>'
                                            Text='<%# Bind("Sequence") %>'>
                                        </asp:LinkButton>
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
                                <asp:TemplateField HeaderText="Chase" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("ChaseName") %>'></asp:Label>
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
                                <asp:BoundField DataField="LastActionDate" HeaderText="Last Action Date" />
                                <asp:TemplateField HeaderText="ContactPerson">
                                    <ItemTemplate>
                                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("ContactPerson") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Primarily Assigned To">
                                    <ItemTemplate>
                                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("AssignedTo") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Current Holder" >
                                    <ItemTemplate>
                                        <asp:Label ID="Label19" runat="server" Text='<%# Bind("LastAssignedPerson") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Last Actor">
                                    <ItemTemplate>
                                        <asp:Label ID="Label29" runat="server" Text='<%# Bind("CurrentAssignee") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("ChaseStatus") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description" Visible="true">
                                    <ItemStyle Wrap="true" Width="200px" />
                                    <ItemTemplate>
                                        <asp:Label ID="Label10" runat="server" Text='<%# Left(Eval("Description").ToString(), 200) %>'></asp:Label>
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
