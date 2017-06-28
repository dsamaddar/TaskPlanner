<%@ Page Language="VB" AutoEventWireup="false" CodeFile="frmGetChaseDefGraphicalView.aspx.vb" Theme="CommonSkin" 
    Inherits="Reports_frmGetChaseDefGraphicalView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>.:Chase:Category Wise Graphical View:.</title>
    <link href="../Sources/css/ChaserCssClass.css" rel="stylesheet" type="text/css" />
    <link href="../Sources/css/Title.css" rel="stylesheet" type="text/css" />
    <link href="../Sources/css/GridStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <table style="width: 100%;">
        <tr>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td valign="top" >
                <asp:GridView ID="grdCDGraphData" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                    <Columns>
                        <asp:BoundField DataField="Chase" HeaderText="Chase" />
                        <asp:BoundField DataField="Count" HeaderText="Count" />
                    </Columns>
                </asp:GridView>
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
                                    <asp:ChartArea BorderWidth="0" Name="ChartArea1" />
                                </ChartAreas>
                            </asp:Chart>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
