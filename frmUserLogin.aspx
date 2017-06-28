<%@ Page Language="VB" AutoEventWireup="false" CodeFile="frmUserLogin.aspx.vb" Inherits="frmUserLogin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="Sources/css/ChaserCssClass.css" rel="stylesheet" type="text/css" />
    <link href="Sources/css/ValidatorStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Panel ID="pnlUserLogin" runat="server" Width="500px">
            <table style="width: 100%;">
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td class="label">
                        User ID
                    </td>
                    <td>
                        <asp:TextBox ID="txtUserID" runat="server"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="reqFldUserID" runat="server" ControlToValidate="txtUserID"
                            Display="None" ErrorMessage="Required: UserID" ValidationGroup="Login"></asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="valCallUserID" TargetControlID="reqFldUserID" runat="server"
                            Enabled="True" CloseImageUrl="~/Sources/img/valClose.png" CssClass="customCalloutStyle"
                            WarningIconImageUrl="~/Sources/img/Valwarning.png">
                        </cc1:ValidatorCalloutExtender>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td class="label">
                        Password
                    </td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                        &nbsp;<asp:RequiredFieldValidator ID="reqFldUserPassword" runat="server" ControlToValidate="txtPassword"
                            Display="None" ErrorMessage="Required: User Password" ValidationGroup="Login"></asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="valCallUserPassword" TargetControlID="reqFldUserPassword"
                            runat="server" Enabled="True" CloseImageUrl="~/Sources/img/valClose.png" CssClass="customCalloutStyle"
                            WarningIconImageUrl="~/Sources/img/Valwarning.png">
                        </cc1:ValidatorCalloutExtender>
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
                        <asp:Button ID="btnLogin" runat="server" Text="Login" ValidationGroup="Login" />
                        &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
