<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmMktInfoRatingPrimary.aspx.vb" Inherits="frmMktInfoRatingPrimary"
    Title=".:Chaser:Primary Market Info:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlMarketInfo" runat="server" SkinID="pnlInner" Width="80%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td>
                                <div class="widget-title">
                                    Market Info Rating
                                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                <div style="max-width: 100%; max-height: 500px; overflow: auto">
                                    <asp:GridView ID="grdMktInfo" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                                        <Columns>
                                            <asp:CommandField ShowSelectButton="True" />
                                            <asp:TemplateField HeaderText="MarketInfoID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMarketInfoID" runat="server" Text='<%# Bind("MarketInfoID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="RE" HeaderText="RE" />
                                            <asp:BoundField DataField="Branch" HeaderText="Branch" />
                                            <asp:BoundField DataField="Client" HeaderText="Client" />
                                            <asp:BoundField DataField="DataStatus" HeaderText="Purpose" />
                                            <asp:BoundField DataField="CPDesignation" HeaderText="CP-Designation" />
                                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                            <asp:TemplateField HeaderText="Attachment">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="hpDocument" runat="server" CssClass="linkbtn" NavigateUrl='<%#"http://192.168.1.242/FileUploader/Attachments/"+ Eval("Attachment") %>'
                                                        Target="_blank">View</asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlRating" runat="server" Width="80%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:HiddenField ID="hdFldMktInfoID" runat="server" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Rating
                            </td>
                            <td>
                                <asp:DropDownList ID="drpRating" runat="server">
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Remarks
                            </td>
                            <td>
                                <asp:TextBox ID="txtPrimaryRemarks" runat="server" Height="50px" TextMode="MultiLine"
                                    Width="300px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldRatingRemarks" runat="server" ControlToValidate="txtPrimaryRemarks"
                                    Display="None" ErrorMessage="Required: Remarks" ValidationGroup="Rating"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldRatingRemarks_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="../Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldRatingRemarks" WarningIconImageUrl="../Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnRateVisit" runat="server" CssClass="styled-button-1" Text="Rate Visit"
                                    ValidationGroup="Rating" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel Selection" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
