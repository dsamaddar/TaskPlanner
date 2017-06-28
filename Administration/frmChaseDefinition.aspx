<%@ Page Language="VB" MasterPageFile="~/ChaserMaster.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmChaseDefinition.aspx.vb" Inherits="Administration_frmChaseDefinition"
    Title=".:Chaser:Chase Definition:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlChaseDefinition" runat="server" Width="90%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widget-title">
                                    Chase Definition<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 250px">
                                <asp:HiddenField ID="hdChaseDefID" runat="server" />
                            </td>
                            <td>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Facility Type
                            </td>
                            <td>
                                <asp:DropDownList ID="drpFacilityType" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldChaseName" runat="server" ControlToValidate="txtChaseName"
                                    Display="None" ErrorMessage="Required: Name Of Chase" ValidationGroup="ChaseDef"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldChaseName_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldChaseName" WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RegularExpressionValidator ID="reqExpShortCode" runat="server" ControlToValidate="txtShortCode"
                                    ErrorMessage="Avoid Space" ValidationExpression="^[a-zA-Z0-9_]*$" ValidationGroup="ChaseDef"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Chase
                            </td>
                            <td>
                                <asp:TextBox ID="txtChaseName" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="250px"></asp:TextBox>
                            </td>
                            <td class="label">
                            </td>
                            <td class="label">
                                Short Code
                            </td>
                            <td>
                                <asp:TextBox ID="txtShortCode" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqFldShortCode" runat="server" ControlToValidate="txtShortCode"
                                    Display="None" ErrorMessage="Required: Short Code" ValidationGroup="ChaseDef"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldShortCode_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldShortCode" WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Category
                            </td>
                            <td>
                                <asp:DropDownList ID="drpCategoryList" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Sub Category
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSubCategoryList" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Items
                            </td>
                            <td>
                                <asp:DropDownList ID="drpItemList" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Priority
                            </td>
                            <td>
                                <asp:DropDownList ID="drpPriorityList" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Interested Parties
                            </td>
                            <td>
                                <asp:ListBox ID="lstBxAllEmployees" runat="server" Width="200px" CssClass="InputTxtBox"
                                    Height="100px"></asp:ListBox>
                            </td>
                            <td>
                                <asp:ImageButton ID="imgBtnAddIntReps" runat="server" ImageUrl="~/Sources/icons/rightarrow.png"
                                    ToolTip="Add Support Representatives" Width="30px" />
                                <br />
                                <asp:ImageButton ID="imgBtnRemoveIntReps" runat="server" ImageUrl="~/Sources/icons/leftarrow.png"
                                    ToolTip="Remove Support Representatives" Width="30px" />
                            </td>
                            <td>
                                <asp:ListBox ID="lstBxInterestedEmployees" runat="server" Width="200px" CssClass="InputTxtBox"
                                    Height="100px"></asp:ListBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldCategory" runat="server" ControlToValidate="drpCategoryList"
                                    Display="None" ErrorMessage="Required: Category" ValidationGroup="ChaseDef"></asp:RequiredFieldValidator>
                                <br />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td>
                                <asp:ImageButton ID="imgBtnAddInfParties" runat="server" ImageUrl="~/Sources/icons/downarrow.png"
                                    ToolTip="Add Informed Parties" Width="30px" />
                                <asp:ImageButton ID="imgBtnRemoveInfParties" runat="server" ImageUrl="~/Sources/icons/uparrow.png"
                                    ToolTip="Remove Informed Parties" Width="30px" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Is A Open Chase
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsOpenChase" runat="server" CssClass="label" Text="(Check If YES)"
                                    AutoPostBack="True" Checked="True" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Informed Parties
                            </td>
                            <td>
                                <asp:ListBox ID="lstBxInformedParties" runat="server" CssClass="InputTxtBox" Height="100px"
                                    Width="200px"></asp:ListBox>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Select Department
                            </td>
                            <td>
                                <div style="max-height: 150px; max-width: 100%; overflow: auto">
                                    <br />
                                    <asp:CheckBox ID="chkBxSelectAllDept" runat="server" AutoPostBack="True" CssClass="label"
                                        Text="Select All" />
                                    <asp:CheckBoxList ID="chkBxLstDepartments" runat="server" CssClass="label">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Primary Support Rep.
                            </td>
                            <td>
                                <asp:DropDownList ID="drpAllUsers" runat="server" Width="200px" CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                            User Can Change Primary
                                <br />
                                Support Person
                            </td>
                            <td>
                                <asp:CheckBox ID="chkUserCanChange" runat="server" CssClass="label" Text="(Check If YES)"
                                    Checked="True" />
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
                                    Width="200px" TextMode="MultiLine"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Is Active
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="label" Text="(Check If YES)"
                                    Checked="True" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnSubmit" runat="server" CssClass="styled-button-1" Text="Submit"
                                    ValidationGroup="ChaseDef" />
                                &nbsp;<asp:Button ID="btnUpdate" runat="server" CssClass="styled-button-1" Text="Update"
                                    ValidationGroup="ChaseDef" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldChaseInstruction" runat="server" ControlToValidate="txtChaseInstruction"
                                    Display="None" ErrorMessage="Required: Chase Instruction" ValidationGroup="ChaseDef"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldChaseInstruction_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="../Sources/img/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldChaseInstruction" WarningIconImageUrl="../Sources/img/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
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
                <asp:Panel ID="pnlChaseDefList" runat="server" Width="90%" SkinID="pnlInner">
                    <div style="max-width: 100%; max-height: 500px; overflow: auto">
                        <asp:GridView ID="grdChaseDefList" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:TemplateField HeaderText="ChaseDefinitionID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblChaseDefinitionID" runat="server" Text='<%# Bind("ChaseDefinitionID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FacilityTypeID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFacilityTypeID" runat="server" Text='<%# Bind("FacilityTypeID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FacilityType">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("FacilityType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ChaseName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblChaseName" runat="server" Text='<%# Bind("ChaseName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ChaseShortCode">
                                    <ItemTemplate>
                                        <asp:Label ID="lblChaseShortCode" runat="server" Text='<%# Bind("ChaseShortCode") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CategoryID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCategoryID" runat="server" Text='<%# Bind("CategoryID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Category">
                                    <ItemTemplate>
                                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SubCategoryID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSubCategoryID" runat="server" Text='<%# Bind("SubCategoryID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sub-Category">
                                    <ItemTemplate>
                                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("SubCategory") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ItemID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblItemID" runat="server" Text='<%# Bind("ItemID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Item">
                                    <ItemTemplate>
                                        <asp:Label ID="Label10" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PriorityID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPriorityID" runat="server" Text='<%# Bind("PriorityID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Priority">
                                    <ItemTemplate>
                                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("PriorityText") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryBy">
                                    <ItemTemplate>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Open Chase">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsOpenChase" runat="server" Text='<%# Bind("IsOpenChase") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsActive">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Primary Supp Rep" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPrimarySupportRep" runat="server" Text='<%# Bind("PrimarySupportRep") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Primary Sup Rep">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("PrimarySupporter") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Instruction">
                                    <ItemTemplate>
                                        <asp:Label ID="lblChaseInstruction" runat="server" Text='<%# Bind("ChaseInstruction") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryDate">
                                    <ItemTemplate>
                                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="User Can Change Primary Support Representative" Visible ="false" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblUserChangePrimarySupPerson" runat="server" Text='<%# Bind("UserChangePrimarySupPerson") %>'></asp:Label>
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
                &nbsp;
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
