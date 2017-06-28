<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false" CodeFile="WordTagRemoval.aspx.vb" Inherits="WordTagRemoval" title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" Runat="Server">
    <table style="width:100%;">
    <tr>
        <td>
            &nbsp;</td>
        <td>
            <asp:TextBox ID="TextBox1" runat="server" Height="300px" TextMode="MultiLine" 
                Width="500px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
        </td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td>
            &nbsp;</td>
        <td>
            <asp:Button ID="Button1" runat="server" Text="Button" />
        </td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td>
            &nbsp;</td>
        <td>
            <asp:TextBox ID="TextBox2" runat="server" Height="300px" TextMode="MultiLine" 
                Width="500px"></asp:TextBox>
            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        </td>
        <td>
            &nbsp;</td>
    </tr>
</table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" Runat="Server">
</asp:Content>

