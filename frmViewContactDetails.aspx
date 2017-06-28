<%@ Page Language="VB" AutoEventWireup="false" CodeFile="frmViewContactDetails.aspx.vb"
    Theme="CommonSkin" Inherits="frmViewContactDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>.:Chaser:Contact Details:.</title>
    <link href="Sources/css/ChaserCssClass.css" rel="stylesheet" type="text/css" />
    <link href="Sources/css/Title.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <table width="100%">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlEmpInfo" runat="server" SkinID="pnlInner" Width="100%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="3">
                                <div class="widget-title">
                                    Contact Details
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 50px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                <asp:Label ID="lblEmpName" runat="server" CssClass="label"></asp:Label>
                            </td>
                            <td>
                                <asp:Image ID="imgEmp" runat="server" Width="100px" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Email
                            </td>
                            <td>
                                <asp:Label ID="lblEmail" runat="server" CssClass="label"></asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Mobile No
                            </td>
                            <td>
                                <asp:Label ID="lblMobileNo" runat="server" CssClass="label"></asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                UserID
                            </td>
                            <td>
                                <asp:Label ID="lblUserID" runat="server" CssClass="label"></asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Emp-Code
                            </td>
                            <td>
                                <asp:Label ID="lblEmpCode" runat="server" CssClass="label"></asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Designation
                            </td>
                            <td>
                                <asp:Label ID="lblDesignation" runat="server" CssClass="label"></asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Department
                            </td>
                            <td>
                                <asp:Label ID="lblDepartment" runat="server" CssClass="label"></asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Branch
                            </td>
                            <td>
                                <asp:Label ID="lblBranch" runat="server" CssClass="label"></asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Supervisor
                            </td>
                            <td>
                                <asp:Label ID="lblSupervisor" runat="server" CssClass="label"></asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
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
    </table>
    </form>
</body>
</html>
