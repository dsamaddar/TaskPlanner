<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmChaseControlStructure.aspx.vb" Inherits="Administration_frmChaseControlStructure"
    Title=".:Chaser: Control Structure:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td style="width: 800px" align="right" valign="top">
                <asp:Panel ID="pnlChaseControlDef" runat="server" Width="800px" SkinID="pnlInner"
                    CssClass="label">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="2" align="left">
                                <div class="widget-title">
                                    Chase Control Structure<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <fieldset>
                                    <legend class="chkText">Select Chase</legend>
                                    <table width="100%">
                                        <tr align="left">
                                            <td style="width: 20px">
                                            </td>
                                            <td class="label" style="width: 150px">
                                                Select Category
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpCategory" runat="server" CssClass="InputTxtBox" Width="200px"
                                                    AutoPostBack="True">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td class="label">
                                                Select Sub-Category
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpSubCategory" runat="server" CssClass="InputTxtBox" Width="200px"
                                                    AutoPostBack="True">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td>
                                            </td>
                                            <td class="label">
                                                Select Chase
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpChaseList" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                                    Width="350px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:HiddenField ID="hdFldControlListID" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 50%" valign="top">
                                <fieldset>
                                    <legend class="chkText">Chase Property</legend>
                                    <table style="width: 100%;">
                                        <tr align="left">
                                            <td class="label" style="width: 150px">
                                                Control Type
                                            </td>
                                            <td style="width: 200px">
                                                <asp:DropDownList ID="drpControlType" runat="server" AutoPostBack="True" Width="120px">
                                                    <asp:ListItem>Label</asp:ListItem>
                                                    <asp:ListItem>TextBox</asp:ListItem>
                                                    <asp:ListItem>CheckBox</asp:ListItem>
                                                    <asp:ListItem>DropDownList</asp:ListItem>
                                                    <asp:ListItem>CheckBoxList</asp:ListItem>
                                                    <asp:ListItem>RadioButtonList</asp:ListItem>
                                                    <asp:ListItem>FileUpload</asp:ListItem>
                                                    <asp:ListItem>Editor</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td class="label" style="width: 150px">
                                                Column Order
                                            </td>
                                            <td style="width: 200px">
                                                <asp:TextBox ID="txtControlIndex" runat="server" Width="80px"></asp:TextBox>
                                                &nbsp;<asp:RequiredFieldValidator ID="reqFldCtrlIndex" runat="server" ControlToValidate="txtControlIndex"
                                                    Display="None" ErrorMessage="Required: Control Index" ValidationGroup="ChaseControl"></asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="reqFldCtrlIndex_ValidatorCalloutExtender" runat="server"
                                                    CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                                    TargetControlID="reqFldCtrlIndex" WarningIconImageUrl="../Sources/img/Valwarning.png">
                                                </cc1:ValidatorCalloutExtender>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td class="label" style="width: 150px">
                                                Control Label Info
                                            </td>
                                            <td style="width: 200px">
                                                <asp:TextBox ID="txtControlLabelInfo" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td class="label" style="width: 150px">
                                                &nbsp;
                                            </td>
                                            <td style="width: 200px">
                                                <asp:TextBox ID="txtControlID" runat="server" Visible="False"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td class="label" style="width: 150px">
                                                Control Value
                                            </td>
                                            <td style="width: 200px">
                                                <asp:TextBox ID="txtControlValue" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td class="label" style="width: 150px">
                                                Reporting Head
                                            </td>
                                            <td style="width: 200px">
                                                <asp:TextBox ID="txtReportingHead" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqFldReportingHead" runat="server" ControlToValidate="txtReportingHead"
                                                    Display="None" ErrorMessage="Required: Reporting Head" ValidationGroup="ChaseControl"></asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="reqFldReportingHead_ValidatorCalloutExtender" runat="server"
                                                    CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                                    TargetControlID="reqFldReportingHead" WarningIconImageUrl="../Sources/img/Valwarning.png">
                                                </cc1:ValidatorCalloutExtender>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td class="label" style="width: 150px">
                                                Active
                                            </td>
                                            <td style="width: 200px">
                                                <asp:CheckBox ID="chkIsActive" runat="server" Text="Is Active" />
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td class="label" style="width: 150px">
                                                Row Order
                                            </td>
                                            <td style="width: 200px">
                                                <asp:TextBox ID="txtViewOrder" runat="server" Width="80px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqFldVeiwOrder" runat="server" ControlToValidate="txtViewOrder"
                                                    Display="None" ErrorMessage="Required: View Order" ValidationGroup="ChaseControl"></asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="reqFldVeiwOrder_ValidatorCalloutExtender" runat="server"
                                                    CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                                    TargetControlID="reqFldVeiwOrder" WarningIconImageUrl="../Sources/img/Valwarning.png">
                                                </cc1:ValidatorCalloutExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                &nbsp;
                            </td>
                            <td align="left" style="width: 50%" valign="top">
                                <fieldset>
                                    <legend class="chkText">Group Control:</legend>
                                    <table width="100%">
                                        <tr align="left">
                                            <td colspan="2">
                                                <asp:CheckBox ID="chkIsGroupControl" runat="server" Text="Is Group Control" />
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td class="label" style="width: 150px">
                                                Select Group Control
                                            </td>
                                            <td style="width: 200px">
                                                <asp:DropDownList ID="drpGrpCtrlList" runat="server" CssClass="InputTxtBox" Width="200px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td class="label" style="width: 150px">
                                            </td>
                                            <td style="width: 200px">
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                &nbsp;<fieldset>
                                    <legend class="chkText">Data Representaton</legend>
                                    <table width="100%">
                                        <tr align="left">
                                            <td class="label" style="width: 150px">
                                                Data Type
                                            </td>
                                            <td style="width: 200px">
                                                <asp:DropDownList ID="drpDataType" runat="server" Width="120px">
                                                    <asp:ListItem>String</asp:ListItem>
                                                    <asp:ListItem>Int32</asp:ListItem>
                                                    <asp:ListItem>DateTime</asp:ListItem>
                                                    <asp:ListItem>Boolean</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td class="label" style="width: 150px">
                                                Data Source
                                            </td>
                                            <td style="width: 200px">
                                                <asp:TextBox ID="txtDataSource" runat="server" Width="150px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr align="left">
                                            <td class="label">
                                                From
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpDataPresentationForm" runat="server" Width="120px">
                                                    <asp:ListItem Value="0">Horizontal</asp:ListItem>
                                                    <asp:ListItem Value="1">Vertical</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr align="left" class="label">
                                            <td>
                                                Value Selection Type
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpValueSelectionType" runat="server" Width="120px">
                                                    <asp:ListItem>SingleValued</asp:ListItem>
                                                    <asp:ListItem>MultiValued</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                                <asp:Button ID="btnAdd" runat="server" CssClass="styled-button-1" Style="width: 37px"
                                    Text="Add" ValidationGroup="ChaseControl" />
                                &nbsp;<asp:Button ID="btnUpdate" runat="server" CssClass="styled-button-1" Text="Update" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td valign="top" style="width: 300px" align="left">
                <table width="100%">
                    <tr>
                        <td>
                            <asp:Panel ID="pnlGroupDefinition" runat="server" Width="350px" SkinID="pnlInner">
                                <table style="width: 100%;">
                                    <tr>
                                        <td colspan="3">
                                            <div class="widget-title">
                                                Group Definition
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td colspan="2">
                                            <asp:HiddenField ID="hdFldChaseGroupCtrlID" runat="server" />
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="reqFldGroupName" runat="server" ControlToValidate="txtGroupName"
                                                Display="None" ErrorMessage="Required: Group Name" ValidationGroup="GroupDef"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="reqFldGroupName_ValidatorCalloutExtender" runat="server"
                                                CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                                TargetControlID="reqFldGroupName" WarningIconImageUrl="../Sources/img/Valwarning.png">
                                            </cc1:ValidatorCalloutExtender>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="reqFldGroupControlCode" runat="server" ControlToValidate="txtGroupConrolCode"
                                                Display="None" ErrorMessage="Required: Control Code" ValidationGroup="GroupDef"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="reqFldGroupControlCode_ValidatorCalloutExtender"
                                                runat="server" CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle"
                                                Enabled="True" TargetControlID="reqFldGroupControlCode" WarningIconImageUrl="../Sources/img/Valwarning.png">
                                            </cc1:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td class="label">
                                            Control Type
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="drpGrpCtrlType" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                                Width="150px">
                                                <asp:ListItem>N\A</asp:ListItem>
                                                <asp:ListItem>CheckBoxList</asp:ListItem>
                                                <asp:ListItem>RadioButtonList</asp:ListItem>
                                                <asp:ListItem>DropDownList</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td class="label">
                                            Group Name
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtGroupName" runat="server" CssClass="InputTxtBox" Width="150px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td class="label">
                                            &nbsp;
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtGroupConrolCode" runat="server" CssClass="InputTxtBox" Width="150px"
                                                Enabled="False" Visible="False"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td class="label">
                                            Is Active
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkIsGroupActive" runat="server" CssClass="label" Text="(Check If YES)"
                                                Checked="True" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td class="label">
                                            &nbsp;
                                        </td>
                                        <td>
                                            <asp:RegularExpressionValidator ID="reqExpGrpCodeValidation" runat="server" ControlToValidate="txtGroupConrolCode"
                                                ErrorMessage="Write Correct Grp Code" ValidationExpression="^[a-zA-Z0-9_]*$"
                                                ValidationGroup="GroupDef"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnSubmitGroup" runat="server" CssClass="styled-button-1" Text="Submit"
                                                ValidationGroup="GroupDef" />
                                        </td>
                                        <td>
                                            &nbsp;<asp:Button ID="btnUpdateGroup" runat="server" CssClass="styled-button-1" Text="Update"
                                                ValidationGroup="GroupDef" />
                                            &nbsp;<asp:Button ID="btnCancelGroup" runat="server" CssClass="styled-button-1" Text="Cancel" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel ID="pnlGroups" runat="server" SkinID="pnlInner" Width="350px">
                                <div style="max-height: 300px; max-width: 100%; overflow: auto">
                                    <asp:GridView ID="grdGroups" runat="server" CssClass="mGrid" AutoGenerateColumns="False"
                                        EmptyDataText="No Group Control Found">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                        Text="Select"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ChaseGroupCtrlID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblChaseGroupCtrlID" runat="server" Text='<%# Bind("ChaseGroupCtrlID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Group">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGroupName" runat="server" Text='<%# Bind("GroupName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Code">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGroupCode" runat="server" Text='<%# Bind("GroupCode") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Ctrl Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCtrlType" runat="server" Text='<%# Bind("CtrlType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Is Active">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIsGroupActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Entry By">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <asp:Panel ID="pnlChaseControlList" runat="server" Width="800px" SkinID="pnlInner">
                    <div style="max-height: 500px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdControlList" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:TemplateField HeaderText="ControlListID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblControlListID" runat="server" Text='<%# Bind("ControlListID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ControlID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblControlID" runat="server" Text='<%# Bind("ControlID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Control Label">
                                    <ItemTemplate>
                                        <asp:Label ID="lblControlLabelInfo" runat="server" Text='<%# Bind("ControlLabelInfo") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Value">
                                    <ItemTemplate>
                                        <asp:Label ID="lblControlValue" runat="server" Text='<%# Bind("ControlValue") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ControlType">
                                    <ItemTemplate>
                                        <asp:Label ID="lblControlType" runat="server" Text='<%# Bind("ControlType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsGroupControl">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsGroupControl" runat="server" Text='<%# Bind("IsGroupControl") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Group Label">
                                    <ItemTemplate>
                                        <asp:Label ID="lblGroupControlLabelInfo" runat="server" Text='<%# Bind("GroupControlLabelInfo") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="GroupControlID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblGroupControlID" runat="server" Text='<%# Bind("GroupControlID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DataType">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDataType" runat="server" Text='<%# Bind("DataType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DataSource" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDataSource" runat="server" Text='<%# Bind("DataSource") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DataPresentationForm" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDataPresentationForm" runat="server" Text='<%# Bind("DataPresentationForm") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ReportingHead">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReportingHead" runat="server" Text='<%# Bind("ReportingHead") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SelectionType">
                                    <ItemTemplate>
                                        <asp:Label ID="lblValueSelectionType" runat="server" Text='<%# Bind("ValueSelectionType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Row Order" Visible="True">
                                    <ItemTemplate>
                                        <asp:Label ID="lblViewOrder" runat="server" Text='<%# Bind("ViewOrder") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Column Order" Visible="True">
                                    <ItemTemplate>
                                        <asp:Label ID="lblControlIndex" runat="server" Text='<%# Bind("ControlIndex") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsActive">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryBy">
                                    <ItemTemplate>
                                        <asp:Label ID="Label13" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
