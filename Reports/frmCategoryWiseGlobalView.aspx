<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmCategoryWiseGlobalView.aspx.vb" Inherits="Reports_frmCategoryWiseGlobalView"
    Title=".:Chaser:Category Wise Global View:." %>

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
    <table width="80%">
        <tr>
            <td colspan="3">
                <div class="widget-title">
                    Category Wise Global View</div>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td valign="top">
                <asp:Panel ID="pnlCategoryWiseGlobalView" runat="server" Width="500px" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <asp:GridView ID="grdCategoryGlobalView" runat="server" AutoGenerateColumns="False"
                                    CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="CategoryID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("CategoryID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Category">
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Category") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Count">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnTerminated" runat="server" CausesValidation="False" CssClass="linkbtn"
                                                    Font-Size="14px" OnClientClick='<%# Eval("CategoryID","openWindow(""frmGetChaseDefGraphicalView.aspx?CategoryID={0}"",""Popup"",700,700);") %>'
                                                    Text='<%# Bind("Count") %>'>
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
                <table>
                    <tr>
                        <td>
                            3D :
                            <asp:DropDownList ID="drp3DEnabled" runat="server" CssClass="InputTxtBox" Width="50px"
                                AutoPostBack="True">
                                <asp:ListItem Value="True">YES</asp:ListItem>
                                <asp:ListItem Value="False">NO</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            Chart Type :<asp:DropDownList ID="drpChartType" runat="server" Width="70px" AutoPostBack="True">
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
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Chart ID="crtChaserCategoryWiseview" runat="server" BackColor="" BorderlineColor="Transparent"
                                Height="300px" Width="400px">
                                <Titles>
                                    <asp:Title Name="Items" ShadowOffset="3" />
                                </Titles>
                                <Legends>
                                    <asp:Legend Alignment="Center" Docking="Bottom" IsTextAutoFit="False" LegendStyle="Row"
                                        Name="Default" />
                                </Legends>
                                <Series>
                                    <asp:Series Name="Default" />
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
                            </asp:Chart>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
