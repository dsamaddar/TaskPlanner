<%@ Page Language="VB" AutoEventWireup="false" CodeFile="IFrameFMS.aspx.vb" Inherits="IFrameFMS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style type="text/css">
        #left_div
        {
            width: 74.5%;
            float: left;
        }
        #right_div
        {
            width: 30%;
        }
        body
        {
            margin: 0px;
            padding: 0px;
        }
        iframe
        {
            border: none; /*height: calc(100vh - 30px);*/
            height: 1000px;
            width: 100%;
        }
    </style>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table width="100%">
            <tr>
                <td valign="top">
                    <div>
                        <iframe id="frame1" scrolling="auto" runat="server" frameborder="0"></iframe>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
