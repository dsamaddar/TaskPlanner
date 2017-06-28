<%@ Page Language="VB" MasterPageFile="~/UserPanel/ChaserUserPanel.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmUsrPerformedChase.aspx.vb" Inherits="frmUsrPerformedChase"
    Title=".:Chaser:Performed Chase:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="Server">
    <script language="JavaScript" type="text/javascript">
        function openWindow(windowURL, windowName, windowWidth, windowHeight) {

            var left = (screen.width / 2) - (windowWidth / 2);
            var top = (screen.height / 2) - (windowHeight / 2);



            window.name = 'parentWnd';
            newWindow = window.open(windowURL, windowName, 'top=' + top + ',left=' + left + ',width=' + windowWidth + ',height=' + windowHeight + ',toolbar=0,location=no,directories=0, status=0,menuBar=0,scrollBars=1,resizable=1');
            newWindow.focus();
        }
    </script>
    <script type="text/javascript">
        $("#<%= btnAddNotes.ClientID%>").live("click", function () {

            var dialog = $("#modal_dialog_notes").dialog({
                title: ".:Add Notes:.",
                buttons: {
                    "Close": function () {
                        $(this).dialog('close');
                    }
                },
                height: 700,
                width: 800,
                modal: true
            });

            // Move the dialog back into the <form> element
            dialog.parent().appendTo(jQuery("form:first"));
            return false;
        });

        function OpenNoteInfo() {

            var dialog = $("#modal_dialog_notes").dialog({
                title: ".:Add Notes:.",
                buttons: {
                    "Close": function () {
                        $(this).dialog('close');
                    }
                },
                height: 700,
                width: 800,
                modal: true
            });

            // Move the dialog back into the <form> element
            dialog.parent().appendTo(jQuery("form:first"));
            return false;
        }
         
         
    </script>
    <table style="width: 100%;">
        <tr>
            <td>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <div id="modal_dialog_notes" style="display: none">
                    <asp:Panel ID="pnlAddNotes" runat="server" Width="600px" SkinID="pnlInner">
                        <table width="100%">
                            <tr align="left">
                                <td style="width: 20px">
                                </td>
                                <td class="label">
                                    Notes
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNotes" runat="server" CssClass="InputTxtBox" Height="70px" TextMode="MultiLine"
                                        Width="300px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reqFldAddNotes" runat="server" ControlToValidate="txtNotes"
                                        Display="None" ErrorMessage="Required: Notes" ValidationGroup="AddNotes"></asp:RequiredFieldValidator>
                                    <cc1:ValidatorCalloutExtender ID="reqFldEmpName_ValidatorCalloutExtender" runat="server"
                                        CloseImageUrl="~/Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                        TargetControlID="reqFldAddNotes" WarningIconImageUrl="~/Sources/img/Valwarning.png">
                                    </cc1:ValidatorCalloutExtender>
                                </td>
                            </tr>
                            <tr align="left">
                                <td>
                                </td>
                                <td class="label">
                                    Attachment
                                </td>
                                <td>
                                    <asp:FileUpload ID="flupNoteAttachment" runat="server" />
                                </td>
                            </tr>
                            <tr align="left">
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:Button ID="btnSubmitNote" runat="server" CssClass="styled-button-1" Text="Submit"
                                        ValidationGroup="AddNotes" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <div>
                                        <asp:GridView ID="grdNotesByChase" runat="server" AutoGenerateColumns="False" CssClass="mGrid"
                                            EmptyDataText="No Note Available">
                                            <Columns>
                                                <asp:BoundField DataField="ChaseNoteID" HeaderText="ChaseNoteID" Visible="False" />
                                                <asp:BoundField DataField="Notes" HeaderText="Notes" />
                                                <asp:TemplateField HeaderText="Attachment">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hplnkNoteAttachments" runat="server" CssClass="linkbtn" NavigateUrl='<%#  ConfigurationManager.AppSettings("OutputChaserFile")+ Eval("Attachments") %>'
                                                            Target="_blank" Text='<%# Bind("Attachments") %>'></asp:HyperLink>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="EntryBy" HeaderText="EntryBy" />
                                                <asp:BoundField DataField="Dated" HeaderText="Dated" />
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlPerformedChase" runat="server" Width="80%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td>
                                <div class="widget-title">
                                    Performed Chase</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                <asp:Button ID="btnAddNotes" runat="server" CssClass="styled-button-1" Text="Add Notes" />
                                &nbsp;<asp:HiddenField ID="hdFldGeneratedChaseID" runat="server" />
                                <asp:HiddenField ID="hdFldMasterChaseID" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr align="left">
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td class="label">
                                            Date From
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDateFrom" runat="server" CssClass="InputTxtBox" Width="190px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqFldDateFrom" runat="server" ControlToValidate="txtDateFrom"
                                                Display="None" ErrorMessage="Required: Date From" ValidationGroup="Required"></asp:RequiredFieldValidator>
                                            <cc1:CalendarExtender ID="txtDateFrom_CalendarExtender" runat="server" Enabled="True"
                                                TargetControlID="txtDateFrom">
                                            </cc1:CalendarExtender>
                                            <cc1:ValidatorCalloutExtender ID="reqFldDateFrom_ValidatorCalloutExtender" runat="server"
                                                CloseImageUrl="~/Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                                TargetControlID="reqFldDateFrom" WarningIconImageUrl="~/Sources/img/Valwarning.png">
                                            </cc1:ValidatorCalloutExtender>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td class="label">
                                            Date To
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDateTo" runat="server" CssClass="InputTxtBox" Width="190px"></asp:TextBox>
                                            <cc1:CalendarExtender ID="txtDateTo_CalendarExtender" runat="server" Enabled="True"
                                                TargetControlID="txtDateTo">
                                            </cc1:CalendarExtender>
                                            <asp:RequiredFieldValidator ID="reqFldDateTo" runat="server" ControlToValidate="txtDateTo"
                                                Display="None" ErrorMessage="Required: Date To" ValidationGroup="Required"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="reqFldDateTo_ValidatorCalloutExtender" runat="server"
                                                CloseImageUrl="~/Sources/img/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                                TargetControlID="reqFldDateTo" WarningIconImageUrl="~/Sources/img/Valwarning.png">
                                            </cc1:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnPerformedChase" ValidationGroup="Required" runat="server" CssClass="styled-button-1"
                                                Text="Performed Chase" />
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                <div>
                                    <asp:GridView ID="grdChaserReportDetails" runat="server" AutoGenerateColumns="False"
                                        CssClass="mGrid">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Chase ID">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnCanDetailsExamResult" runat="server" CausesValidation="False"
                                                        CssClass="linkbtn" Font-Size="14px" OnClientClick='<%# Eval("MasterChaseID","openWindow(""../frmChaseDetailsView.aspx?GeneratedChaseID={0}"",""Popup"",1000,1100);") %>'
                                                        Text='<%# Bind("Sequence") %>'>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Add Note" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkBtnAddNote" runat="server" CausesValidation="False" CommandName="Select"
                                                        Text="Note"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Category" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Category") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SubCategory" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("SubCategory") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Item" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("Item") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Chase">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("ChaseName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ContactPerson">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("ContactPerson") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Initiator">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Initiator") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Initiator Remarks">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("InitiatorRemarks") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Initiation Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("InitiationDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("ChaseStatus") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="AssignedTo">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("AssignedTo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="GeneratedChaseID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGeneratedChaseID" runat="server" Text='<%# Bind("GeneratedChaseID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="ChaseDefinitionID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblChaseDefinitionID" runat="server" Text='<%# Bind("ChaseDefinitionID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="MasterChaseID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMasterChaseID" runat="server" Text='<%# Bind("MasterChaseID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Description" Visible="true">
                                                <ItemStyle Wrap="true" Width="200px" />
                                                <ItemTemplate>
                                                    <asp:Label ID="Label11" runat="server" Text='<%#  Left(Eval("Description").ToString(), 200) %>'></asp:Label>
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
        <tr>
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
