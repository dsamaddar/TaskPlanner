<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmDepartmentalChaseRpt.aspx.vb" Inherits="frmDepartmentalChaseRpt"
    Title=".:Chaser:Departmental Review:." %>

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
        <tr>
            <td valign="top">
                <asp:Panel ID="pnlGlobalView" runat="server" Width="500px" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <div class="widget-title">
                                    Departmental Chase View</div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grdGlobalView" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                                    <Columns>
                                        <asp:CommandField HeaderText="Select" ShowSelectButton="True" />
                                        <asp:TemplateField HeaderText="AssignedToID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAssignedToID" runat="server" Text='<%# Bind("AssignedToID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Employee">
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Pending">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnPending" runat="server" CausesValidation="False" CssClass="linkbtn"
                                                    Font-Size="14px" OnClientClick='<%# Eval("AssignedToID","openWindow(""Reports/frmUserWiseChaseAndSts.aspx?EmployeeID={0}&ChaseStatus=Pending"",""Popup"",1000,1100);") %>'
                                                    Text='<%# Bind("Pending") %>'>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Forwarded" Visible="true" >
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnForwarded" runat="server" CausesValidation="False" CssClass="linkbtn"
                                                    Font-Size="14px" OnClientClick='<%# Eval("AssignedToID","openWindow(""Reports/frmUserWiseChaseAndSts.aspx?EmployeeID={0}&ChaseStatus=Forwarded"",""Popup"",1000,1100);") %>'
                                                    Text='<%# Bind("Forwarded") %>'>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Done">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnTerminated" runat="server" CausesValidation="False" CssClass="linkbtn"
                                                    Font-Size="14px" OnClientClick='<%# Eval("AssignedToID","openWindow(""Reports/frmUserWiseChaseAndSts.aspx?EmployeeID={0}&ChaseStatus=Terminated"",""Popup"",1000,1100);") %>'
                                                    Text='<%# Bind("Done") %>'>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
                &nbsp;</td> </tr>
    <tr>
        <td>
                <asp:Panel ID="pnlGraphicalView" runat="server" SkinID="pnlInner" 
                Width="450px" Visible="False">
                    <table width="100%">
                        <tr>
                            <td colspan="3">
                                <div class="widget-title">
                                    Year Wise Total Chase Graphical View</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                Year
                                <asp:DropDownList ID="drpYear" runat="server" AutoPostBack="True" Width="80px">
                                    <asp:ListItem>2012</asp:ListItem>
                                    <asp:ListItem>2013</asp:ListItem>
                                    <asp:ListItem>2014</asp:ListItem>
                                    <asp:ListItem>2015</asp:ListItem>
                                    <asp:ListItem>2016</asp:ListItem>
                                    <asp:ListItem>2017</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                &nbsp;3D
                                <asp:DropDownList ID="drp3DEnabled" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem Value="True">YES</asp:ListItem>
                                    <asp:ListItem Value="False">NO</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                &nbsp;Chart Type
                                <asp:DropDownList ID="drpChartType" runat="server" Width="70px" Height="16px">
                                    <asp:ListItem Value="13">Area</asp:ListItem>
                                    <asp:ListItem Value="7">Bar</asp:ListItem>
                                    <asp:ListItem Value="28">BoxPlot</asp:ListItem>
                                    <asp:ListItem Value="2">Bubble</asp:ListItem>
                                    <asp:ListItem Value="20">Candlestick</asp:ListItem>
                                    <asp:ListItem Value="10">Column</asp:ListItem>
                                    <asp:ListItem Value="18">Doughnut</asp:ListItem>
                                    <asp:ListItem Value="27">ErrorBar</asp:ListItem>
                                    <asp:ListItem Value="6">FastLine</asp:ListItem>
                                    <asp:ListItem Value="1">FastPoint</asp:ListItem>
                                    <asp:ListItem Value="33">Funnel</asp:ListItem>
                                    <asp:ListItem Value="31">Kagi</asp:ListItem>
                                    <asp:ListItem Value="3">Line</asp:ListItem>
                                    <asp:ListItem Value="17">Pie</asp:ListItem>
                                    <asp:ListItem Value="0">Point</asp:ListItem>
                                    <asp:ListItem Value="32">PointAndFigure</asp:ListItem>
                                    <asp:ListItem Value="26">Polar</asp:ListItem>
                                    <asp:ListItem Value="34">Pyramid</asp:ListItem>
                                    <asp:ListItem Value="25">Radar</asp:ListItem>
                                    <asp:ListItem Value="21">Range</asp:ListItem>
                                    <asp:ListItem Value="23">RangeBar</asp:ListItem>
                                    <asp:ListItem Value="24">RangeColumn</asp:ListItem>
                                    <asp:ListItem Value="29">Renko</asp:ListItem>
                                    <asp:ListItem Value="4">Spline</asp:ListItem>
                                    <asp:ListItem Value="14">SplineArea</asp:ListItem>
                                    <asp:ListItem Value="22">SplineRange</asp:ListItem>
                                    <asp:ListItem Value="15">StackedArea</asp:ListItem>
                                    <asp:ListItem Value="11">StackedColumn</asp:ListItem>
                                    <asp:ListItem Value="5">StepLine</asp:ListItem>
                                    <asp:ListItem Value="19">Stock</asp:ListItem>
                                    <asp:ListItem Value="30">ThreeLineBreak</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:Button ID="btnShow" runat="server" CssClass="styled-button-1" Text="Show" />
                            </td>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                &nbsp;</td>
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
