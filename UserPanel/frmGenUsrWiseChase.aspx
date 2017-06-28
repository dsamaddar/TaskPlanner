<%@ Page Language="VB" MasterPageFile="~/UserPanel/ChaserUserPanel.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmGenUsrWiseChase.aspx.vb" Inherits="UserPanel_frmGenUsrWiseChase"
    Title=".:Chaser:User Wise Chase:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headerPlaceHolder" runat="Server">
    <%--   <script type='text/javascript'>

        setTimeout("location.reload();",150000);

    </script>--%>
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
        $("#<%= btnViewChaseDetails.ClientID%>").live("click", function() {

            var dialog = $("#modal_dialog").dialog({
                title: ".:Chase Details:.",
                buttons: {
                    "Close": function() {
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

        $("#<%= btnAddNotes.ClientID%>").live("click", function() {

            var dialog = $("#modal_dialog_notes").dialog({
                title: ".:Add Notes:.",
                buttons: {
                    "Close": function() {
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
         
         
    </script>

    <table style="width: 100%;">
        <tr align="center">
            <td colspan="3">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td colspan="3">
                <div id="modal_dialog" style="display: none">
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:HiddenField ID="hdFldGeneratedChaseID" runat="server" />
                                <asp:HiddenField ID="hdFldMasterChaseID" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="widget-title">
                                    Chase Options
                                </div>
                            </td>
                        </tr>
                        <tr align="center">
                            <td align="left">
                                <asp:GridView ID="grdChaseInputValues" runat="server" AutoGenerateColumns="False"
                                    Font-Size="Small" CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="ReportingHead">
                                            <ItemTemplate>
                                                <asp:Label ID="lblReportingHead" runat="server" Text='<%# Bind("ReportingHead") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Value">
                                            <ItemTemplate>
                                                <asp:Label ID="lblValue" runat="server" Text='<%# Bind("Value") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="widget-title">
                                    Chase Feedback History</div>
                            </td>
                        </tr>
                        <tr align="center">
                            <td align="left">
                                <asp:GridView ID="grdChaseFeedBackHistory" runat="server" AutoGenerateColumns="False"
                                    CssClass="mGrid">
                                    <Columns>
                                        <asp:BoundField DataField="SLNo" HeaderText="SLNo" />
                                        <asp:BoundField DataField="InitiatorName" HeaderText="Initiator" />
                                        <asp:BoundField DataField="InitiationDate" HeaderText="Dated" />
                                        <asp:BoundField DataField="InitiatorRemarks" HeaderText="I.Remarks" />
                                        <asp:TemplateField HeaderText="Uploaded File">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="hpDocument" runat="server" CssClass="linkbtn" NavigateUrl='<%# ConfigurationManager.AppSettings("OutputChaserFile")+ Eval("UploadedFile") %>'
                                                    Target="_blank">View</asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="AssignedTo" HeaderText="Assigned To" />
                                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                        <asp:BoundField DataField="IsTerminated" HeaderText="Terminated" />
                                        <asp:BoundField DataField="TimeTaken" HeaderText="TimeTaken[min]" />
                                        <asp:BoundField DataField="ChaseProgress" HeaderText="Chase Progress" />
                                        <asp:BoundField DataField="ChaseStatus" HeaderText="Chase Status" />
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="widget-title">
                                    Provide Feedback
                                </div>
                            </td>
                        </tr>
                        <tr align="center">
                            <td>
                                <table width="100%">
                                    <tr align="left">
                                        <td class="label" style="width: 150px">
                                            Remarks
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRemarks" runat="server" Height="50px" Width="250px" TextMode="MultiLine"
                                                CssClass="InputTxtBox"></asp:TextBox>
                                            <%--   &nbsp;<asp:RequiredFieldValidator ID="reqFldRemarks" runat="server" ControlToValidate="txtRemarks"
                                                Display="None" ErrorMessage="Required: Remarks" ValidationGroup="UpdateChase"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="valCallRemarks" TargetControlID="reqFldRemarks"
                                                runat="server" Enabled="True" CloseImageUrl="~/Sources/img/valClose.png" CssClass="customCalloutStyle"
                                                WarningIconImageUrl="~/Sources/img/Valwarning.png">
                                            </cc1:ValidatorCalloutExtender>--%>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td class="label" style="width: 150px">
                                            Upload A File
                                        </td>
                                        <td>
                                            <asp:FileUpload ID="flupChaserAssignment" runat="server" />
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td class="label" style="width: 150px">
                                            Assign To
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="drpEmployeeList" runat="server" Width="200px" CssClass="InputTxtBox">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td class="label" style="width: 150px">
                                            Chase Progress
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="drpChaseProgress" runat="server" CssClass="InputTxtBox" Width="60px">
                                                <asp:ListItem>0%</asp:ListItem>
                                                <asp:ListItem>25%</asp:ListItem>
                                                <asp:ListItem>50%</asp:ListItem>
                                                <asp:ListItem>75%</asp:ListItem>
                                                <asp:ListItem>100%</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td class="label" style="width: 150px">
                                        </td>
                                        <td>
                                            <asp:Button runat="server" ID="btnForwardChase" Text="Forward Chase" ValidationGroup="UpdateChase"
                                                OnClientClick="if (!confirm('Are you Sure to Forward the Chase ?')) return false" />
                                            &nbsp;<asp:Button ID="btnTerminateChase" runat="server" Text="Terminate Chase" ValidationGroup="UpdateChase"
                                                OnClientClick="if (!confirm('Are you Sure to Terminate the Chase ?')) return false" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr align="center">
            <td colspan="3">
                <div id="modal_dialog_notes" style="display: none">
                    <asp:Panel ID="pnlAddNotes" runat="server" Width="600px" SkinID="pnlInner">
                        <table width="100%">
                            <tr align="left">
                                <td style="width: 20px">
                                </td>
                                <td class="label" style="width: 150px">
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
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlAssignedChase" runat="server" Width="80%" SkinID="pnlInner">
                    <table width="100%">
                        <tr align="left">
                            <td>
                                <div class="widget-title">
                                    Assigned Chase</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                <asp:Button ID="btnViewChaseDetails" runat="server" CssClass="styled-button-1" Text="ViewChaseDetails" />
                                <asp:Button ID="btnAddNotes" runat="server" CssClass="styled-button-1" Text="Add Notes" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grdAssignedChase" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkBtnSelectChase" runat="server" CausesValidation="False" Text='Select'
                                                    CommandName="Select"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Chase ID">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnChaseDetails" runat="server" CausesValidation="False" CssClass="linkbtn"
                                                    Font-Size="14px" OnClientClick='<%# Eval("MasterChaseID","openWindow(""../frmChaseDetailsView.aspx?GeneratedChaseID={0}"",""Popup"",1000,1100);") %>'
                                                    Text='<%# Bind("Sequence") %>'>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="GeneratedChaseID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGeneratedChaseID" runat="server" Text='<%# Bind("GeneratedChaseID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MasterChaseID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMasterChaseID" runat="server" Text='<%# Bind("MasterChaseID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ChaseDefinitionID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblChaseDefinitionID" runat="server" Text='<%# Bind("ChaseDefinitionID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Chase">
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("ChaseName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Contact-Person">
                                            <ItemTemplate>
                                                <asp:Label ID="lblContactPerson" runat="server" Text='<%# Bind("ContactPerson") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Initiator">
                                            <ItemTemplate>
                                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Initiator") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="InitiationDate">
                                            <ItemTemplate>
                                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("InitiationDate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="InitiatorRemarks">
                                            <ItemTemplate>
                                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("InitiatorRemarks") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="DataSource">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="hplnkVoiceData" runat="server" CssClass="linkbtn" NavigateUrl='<%#  ConfigurationManager.AppSettings("OutputChaserFile")+ Eval("DataSource") %>'
                                                    Target="_blank" Text='<%# Bind("DataSource") %>'></asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Description" Visible="true">
                                            <ItemStyle Wrap="true" Width="200px" />
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%#  Left(Eval("Description").ToString(), 200) %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
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
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="Server">
</asp:Content>
