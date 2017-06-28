<%@ Page Language="VB" AutoEventWireup="false" CodeFile="frmChaseEditView.aspx.vb"
    Inherits="frmChaseEditView" Theme="CommonSkin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>.:Chaser:Edit Chase:.</title>
    <link href="Sources/css/ChaserCssClass.css" rel="stylesheet" type="text/css" />
    <link href="Sources/css/Title.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <table style="width: 100%">
        <tr align="left">
            <td>
                <div class="widget-title">
                    Edit Chase<asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                </div>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlContactDetails" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
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
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td class="label">
                                Branch
                            </td>
                            <td>
                                <asp:DropDownList ID="drpULCBranchList" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                Contact Person
                            </td>
                            <td>
                                <asp:DropDownList ID="drpRequestFor" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnUpdateContactInfo" runat="server" CssClass="styled-button-1" 
                                    Text="Update" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td class="label">
                                Priority</td>
                            <td>
                                <asp:DropDownList ID="drpPriority" runat="server" CssClass="InputTxtBox" 
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnUpdatePriority" runat="server" CssClass="styled-button-1" 
                                    Text="Update" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                &nbsp;</td>
        </tr>
        <tr align="center">
            <td>
                &nbsp;</td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlGeneratedControls" runat="server" BorderStyle="None" SkinID="pnlInner">
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlUpdateChase" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
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
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="styled-button-1" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="styled-button-1" />
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
                </asp:Panel>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
