﻿<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmReqLogView.aspx.vb" Inherits="Reports_frmReqLogView"
    Title=".:Chaser:Request Log View:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlReqLogView" runat="server" SkinID="pnlInner" Width="60%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Request Inbound</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
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
                                Select Query Type
                            </td>
                            <td>
                                <asp:DropDownList ID="drpQueryType" runat="server" Width="200px" 
                                    CssClass="InputTxtBox" AutoPostBack="True">
                                    <asp:ListItem Value="ThisWeek">This Week</asp:ListItem>
                                    <asp:ListItem Value="LastWeek">Last Week</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                Chart Type
                            </td>
                            <td>
                                <asp:DropDownList ID="drpChartType" runat="server" CssClass="InputTxtBox" 
                                    AutoPostBack="True">
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
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                3D
                            </td>
                            <td>
                                <asp:DropDownList ID="drp3DEnabled" runat="server" CssClass="InputTxtBox" 
                                    AutoPostBack="True">
                                    <asp:ListItem Value="True">YES</asp:ListItem>
                                    <asp:ListItem Value="False">NO</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" align="center">
                                <asp:Chart ID="crtChaser" runat="server" BackColor="" BorderlineColor="Transparent"
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
                </asp:Panel>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
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
