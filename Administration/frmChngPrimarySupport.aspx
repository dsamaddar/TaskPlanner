<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmChngPrimarySupport.aspx.vb" Inherits="Administration_frmChngPrimarySupport"
    Title=".:Chaser:Change Primary Representative:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
            </td>
            <td align="center">
                <asp:Panel ID="pnlPrimarySuppRep" runat="server" Width="600px" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="3">
                                <div class="widget-title">
                                    Change Primary Support Representative<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
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
                                Select Representative
                            </td>
                            <td>
                                <asp:DropDownList ID="drpRepresentatives" runat="server" Width="200px" 
                                    AutoPostBack="True">
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
                <asp:Panel ID="pnlList" runat="server" Width="600px" SkinID="pnlInner">
                    <div style="max-height:500px;max-width:100%;overflow:auto">
                        <asp:GridView ID="grdChaseList" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ChaseDefinitionID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblChaseDefinitionID" runat="server" Text='<%# Bind("ChaseDefinitionID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PrimarySupportRep" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPrimarySupportRep" runat="server" Text='<%# Bind("PrimarySupportRep") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Chase">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("ChaseName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Instruction">
                                    <ItemTemplate>
                                        <asp:Label ID="lblChaseInstruction" runat="server" Text='<%# Bind("ChaseInstruction") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlUpdateInfo" runat="server" Width="600px" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 200px">
                                <asp:HiddenField ID="hdFldChaseDefinitionID" runat="server" />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldChangedTo" runat="server" ControlToValidate="drpChangedRepresentative"
                                    Display="None" ErrorMessage="Required: Representative" ValidationGroup="PrimaryRep"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldChangedTo_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldChangedTo" WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Change To
                            </td>
                            <td>
                                <asp:DropDownList ID="drpChangedRepresentative" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Instruction
                            </td>
                            <td>
                                <asp:TextBox ID="txtChaseInstruction" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="250px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldChaseInstruction" runat="server" ControlToValidate="txtChaseInstruction"
                                    Display="None" ErrorMessage="Required: Chase Instruction" ValidationGroup="PrimaryRep"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldChaseInstruction_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldChaseInstruction" WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                                <asp:Button ID="btnChange" runat="server" CssClass="styled-button-1" Text="Change"
                                    ValidationGroup="PrimaryRep" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
                            </td>
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
