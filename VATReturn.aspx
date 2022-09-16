<%@ Page Title="" Language="C#" MasterPageFile="~/Website.Master" AutoEventWireup="true" CodeBehind="VATReturn.aspx.cs" Inherits="AccountUI.VATReturn" %>



<asp:Content ID="Content2" ContentPlaceHolderID="cpHeading" runat="server">
    VAT Returns
     
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cpHelp" runat="server">
    <cc:AccountHelpLink ID="idHelp" HelpCode="11" runat="server" />

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cpHeaderRight" runat="server">
    <cc:LinkButtonEx ID="btnVATReturn" OnAccessControlAllowed="OnAccessControlAllowed" AccessControlID="5600801" runat="server" data-toggle="modal" data-target="#exampleModalCenter" data-placement="top" data-original-title="Add VAT Return" CssClass="btn btn-default bg-seagreen text-white btn-def"><i class="fa fa-plus"></i>&nbsp; New
    </cc:LinkButtonEx>
    <cc:LinkButtonEx ID="lnlBtnEmail" OnClientClick="sendEmail(); return false;" runat="server" data-placement="top" data-original-title="Send Mail" CssClass="btn btn-default bg-seagreen text-white btn-def"><i class="fa fa-envelope"></i>&nbsp;Send Mail</cc:LinkButtonEx>
  
    <%-- <cc:LinkButtonEx ID="lnlBtnEmail" OnClientClick="sendEmail(); return false;" runat="server" CssClass="dashOpt-e_fa hav_tooltip" data-toggle="tooltip" data-placement="top" data-original-title="Send Mail"><i class="fa fa-envelope"></i></cc:LinkButtonEx>--%>
    <%--<a href="Popup/SendSMSPopUp.aspx?FYCode=<%=this.FYCode%>&CompanyCode=<%=CurrentSessionInfo.Company.CompanyCode %>"
        class="dashOpt-e hav_tooltip cbpopup_prc_48_25 popHCF_p06" data-toggle="tooltip" data-placement="top" data-original-title="Send SMS">
        <span>Send SMS</span>
    </a>--%>
     <a href="#" title="Send SMS"
        class="btn btn-default bg-seagreen text-white btn-def" data-placement="top" data-toggle="modal" data-target="#SendSMSModalCenter" data-original-title="Send SMS">
        <i class="fa fa-comment-o"></i>&nbsp; &nbsp;<span>Send SMS</span>
    </a>

    <cc:LinkButtonEx ID="btnSMS" OnClientClick="sendSMS(); return false;" runat="server" data-toggle="tooltip" data-placement="top" data-original-title="Send Mail" Visible="false"  CssClass="btn btn-default bg-seagreen text-white btn-def"><i class="fa fa-comment"></i>&nbsp;Send SMS</cc:LinkButtonEx>

    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">

                <div class="cphHeader">
                    <button type="button" class="close close_bs" id="bsClose" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <%-- <div class="embed-responsive embed-responsive-16by9">--%>
                    <iframe id="childFrame" name="childFrame" src="Popup/AddVATReturn.aspx?FYCode=<%=this.FYCode%>&CompanyCode=<%=this.CurrentSessionInfo.Company.CompanyCode%>&VATReturnCode=0&action=Add" width="100%" height="235" frameborder="0"></iframe>
                    <%-- </div>--%>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="sendemailmodal" tabindex="-1" role="dialog" aria-labelledby="sendsmsmodalTitle" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">

                <div class="cphHeader">
                    <button type="button" class="close close_bs" id="sendsmsmodal1close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <iframe id="sendsmsmodalIframe1" name="sendsmsmodalIframe1" src=""
                        width="100%" height="420" frameborder="0"></iframe>
                </div>
            </div>
        </div>
    </div>

       <div class="modal fade" id="SendSMSModalCenter" tabindex="-1" role="dialog" aria-labelledby="SendSMSModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-md" role="document">
            <div class="modal-content">

                <div class="cphHeader">
                    <button type="button" class="close close_bs" id="SendSMSClose" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <iframe id="SendSMSFrame" name="SendSMSFrame" src="Popup/ClientSendSMS.aspx?FYCode=<%=this.FYCode%>&CompanyCode=<%=this.CurrentSessionInfo.Company.CompanyCode%>" width="100%" height="340" frameborder="0"></iframe>
                </div>
            </div>
        </div>
    </div>

</asp:Content>


<asp:Content runat="server" ID="Content7" ContentPlaceHolderID="cphPeriod">

    <script type="text/javascript">
        $(function () {

            $("input:checkbox").on('click', function () {
                // in the handler, 'this' refers to the box clicked on
                var $box = $(this);
                if ($box.is(":checked")) {
                    // the name of the box is retrieved using the .attr() method
                    // as it is assumed and expected to be immutable
                    var group = "input:checkbox[name='" + $box.attr("name") + "']";
                    // the checked state of the group/box on the other hand will change
                    // and the current value is retrieved using .prop() method
                    $(group).prop("checked", false);
                    $box.prop("checked", true);
                } else {
                    $box.prop("checked", false);
                }
            });
        });

        function sendEmail() {

            if ($('._inputitem:checked').length <= 0) {
                alert('please select a VAT Period');
            }
            else {
                //var ids = "";
                //arr = new Array();
                var VATReturn_VATReturnCode;
                $('._inputitem:checked').each(function () {
                    // arr.push(($(this).val()).toString());  
                    VATReturn_VATReturnCode = $(this).val().toString();
                });

                <%-- var urlpopup = ('Popup/VATReturnEmail.aspx?FYCode=' +<%=this.FYCode%> +"&CompanyCode=" +<%=CurrentSessionInfo.Company.CompanyCode %> +"&r=" + VATReturn_VATReturnCode);

                $.colorbox({ width: "800px", height: "400px", iframe: true, esckey: false, overlayclose: false, href: urlpopup });--%>

                var url = 'VATReturnEmail.aspx?FYCode=' +<%=this.FYCode%> +"&CompanyCode=" +<%=this.CurrentSessionInfo.Company.CompanyCode%> +"&r=" + VATReturn_VATReturnCode;
                $('#sendsmsmodalIframe1').attr('src', url);
                $('#sendemailmodal').modal('show');
                $('#sendsmsmodalIframe1').css({ height: '370' });


            }
        }



        function sendSMS() {

            //var xhr = new XMLHttpRequest('https://platform.clickatell.com/messages/http/send?apiKey=kO1aqbkKTB-BwSvE-vXYuA==&to=9536032178&content=Test+message+text');
            //xhr.onreadystatechange = function () {
            //    if (xhr.readyState == 4 && xhr.status == 200) {
            //        alert('success');
            //    }
            //};
            //xhr.send();

            var urlpopup = ('Popup/SendSMSPopUp.aspx?FYCode=' +<%=this.FYCode%> +"&CompanyCode=" +<%=this.CurrentSessionInfo.Company.CompanyCode%> +"");

            $.colorbox({ width: "800px", height: "400px", iframe: true, esckey: false, overlayclose: false, href: urlpopup });



        }

    </script>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="cphError" runat="server">
    <div class="tableDashboard py-0">
        <asp:Literal runat="server" ID="ltMessage"></asp:Literal>
    </div>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="cPH" runat="server">
    <div class="tableDashboard pt-0">
        <div class="row">
            <div class="col-md-12">
                <div>
                    <div class="panel panel-default">
                        
                        <div class="panel-body py-0 px-0">
                    <table class="table table-head-bg" style="min-width: 768px;">
                        <thead>
                            <tr>
                                <th class="col_th_xs"></th>
                                <th class="col_th_m" style="display: none;">Date From</th>
                                <th class="col_th_m" style="display: none;">Date To</th>
                                <th>Period</th>
                                <th class="text-right col_th_m">Amount</th>
                                <th style="display: none;">Description</th>
                                <th class="text-center">Submission Status</th>
                                <th class="text-center" style="display: none;">Submission Type</th>
                                <th class="text-center" style="display: none;">EC Submission Status</th>
                                <th class="text-center col_th_xs"></th>
                                <th class="text-center  col_th_xs"></th>
                                <th class="col_th_s"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptrDisplayRecords" runat="server"
                                OnItemCommand="rptrDisplayRecords_ItemCommand"
                                OnItemDataBound="rptrDisplayRecords_ItemDataBound">
                                <ItemTemplate>
                                    <tr>
                                        <td class="text-center">
                                            <input type="checkbox" name="ChkName" value='<%# Eval("VATReturnCode")%>' class="_inputitem " /></td>
                                        <td style="display: none;">
                                            <%# Eval("DateFrom", "{0:dd-MMM-yyyy}")%></td>
                                        <td style="display: none;">
                                            <%# Eval("DateTo", "{0:dd-MMM-yyyy}")%></td>
                                        <td>
                                            <%# ((string)Eval("Description")).Replace("VAT Return for ", "") %>
                                        </td>
                                        <td class="text-right">
                                            <%# Eval("Amount", "{0:c}")%></td>
                                        <td style="display: none;">
                                            <%# Eval("Description")%></td>
                                        <td class="text-center">
                                            <%# Eval("SubmissionStatus.SubmissionStatusName")%>
                                            <%# Convert.ToString(DataBinder.Eval(Container, "DataItem.SubmissionType")) == "O" ? "(O)" : Convert.ToString(DataBinder.Eval(Container, "DataItem.SubmissionType")) == "M" ? "(M)" : ""%>
                                        </td>
                                        <td class="text-center" style="display: none;">
                                            <%# Convert.ToString(DataBinder.Eval(Container, "DataItem.SubmissionType")) == "O" ? "Online" : Convert.ToString(DataBinder.Eval(Container, "DataItem.SubmissionType")) == "M" ? "Manual" : "None"%>
                                        </td>


                                        <td class="text-center" style="display: none;">
                                            <asp:Literal ID="ltEUSubmissionStatus" runat="server" Visible="false"></asp:Literal>
                                        </td>


                                        <td class="text-center">
                                            <cc:LinkButtonEx ID="lnkEdit" runat="server" CssClass="report_icon hav_tooltip" data-placement="top" data-original-title="Edit" OnAccessControlAllowed="OnAccessControlAllowed" AccessControlID="5600802"
                                                CommandArgument='<%# Eval("VATReturnCode") %>' CommandName="RowEdit">
                                       <%-- <img src="../commonv2/images/edit.png" alt="Edit" title="Edit" width="16" height="16" />--%>
                                                 <i class="fa fa-pencil" title="Edit"></i>
                                            </cc:LinkButtonEx>
                                        </td>
                                        <td class="text-center">
                                            <cc:LinkButtonEx ID="lnkView" runat="server" CssClass="report_icon hav_tooltip" data-placement="top" data-original-title="View" OnAccessControlAllowed="OnAccessControlAllowed" AccessControlID="5600803"
                                                CommandArgument='<%# Eval("VATReturnCode") %>' CommandName="RowView">
                                       <%-- <img src="../commonv2/images/preview.png" alt="View" title="View" width="16" height="16" />--%>
                                                <i class="fa fa-eye" title="View"></i>
                                            </cc:LinkButtonEx>
                                        </td>
                                        <td class="settingsCell dropdown">
                                            <a href="javascript:void(0)" class="toggleSettings" aria-expanded="false">
                                                <img src="../commonv2/images/cogs.png" alt="">
                                            </a>

                                            <div class="settingsT-in dropdown-menu">


                                                <cc:LinkButtonEx ID="lnkVATReturnReport" runat="server" CssClass="setting-e" OnAccessControlAllowed="OnAccessControlAllowed" AccessControlID="5600803"
                                                    CommandArgument='<%# Eval("VATReturnCode") %>' CommandName="VATReturnReport" Visible="false">
                                        <figure>
                                            <img src="../commonv2/images/pdf_ico.png" alt="VAT Return Report" title="VAT Return Report" />
                                        </figure>
                                        <span>VAT Return</span>
                                                </cc:LinkButtonEx>

                                                <%--<a class="PopUp_70_92 setting-e" href='Popup/VATReturnReport.aspx?FYCode=<%=this.FYCode%>&CompanyCode=<%=CurrentSessionInfo.Company.CompanyCode %>&r=<%# Eval("VATReturnCode") %>'>
                                        <figure>
                                            <img src="../commonv2/images/pdf_ico.png" alt="VAT Return Report" title="VAT Return Report" />
                                        </figure>
                                        <span>VAT Return</span>
                                    </a>--%>

                                                <cc:LinkButtonEx ID="lnkVATReturnbackup" runat="server" CssClass="setting-e" OnAccessControlAllowed="OnAccessControlAllowed" AccessControlID="5600803"
                                                    CommandArgument='<%# Eval("VATReturnCode") %>' CommandName="VATReturnbackup" Visible="false">
                                      <figure>
                                            <img src="../commonv2/images/pdf_ico.png" alt="Backup Report" title="Backup Report" />
                                        </figure>
                                        <span>VAT Backup</span>
                                                </cc:LinkButtonEx>

                                                <%--      <a href='Popup/VATReturnBackupReport.aspx?FYCode=<%=this.FYCode%>&CompanyCode=<%=CurrentSessionInfo.Company.CompanyCode %>&r=<%# Eval("VATReturnCode") %>' class="PopUp_70_92 setting-e">
                                        <figure>
                                            <img src="../commonv2/images/pdf_ico.png" alt="Backup Report" title="Backup Report" />
                                        </figure>
                                        <span>VAT Backup</span>
                                    </a>--%>


                                                <cc:LinkButtonEx ID="lnkNewVATReturn" runat="server" CssClass="setting-e" OnAccessControlAllowed="OnAccessControlAllowed" AccessControlID="5600803"
                                                    CommandArgument='<%# Eval("VATReturnCode") %>' CommandName="NewVATReturn">
                                         <figure>
                                            <img src="../commonv2/images/pdf_ico.png" alt="VAT Return Report" title="VAT Return" />
                                        </figure>
                                        <span>VAT Return</span>
                                                </cc:LinkButtonEx>



                                                <%--        <a class="XX2LargePopupStaff setting-e" href='Popup/VATReturnReportModified.aspx?FYCode=<%=this.FYCode%>&CompanyCode=<%=CurrentSessionInfo.Company.CompanyCode %>&r=<%# Eval("VATReturnCode") %>&CompanyLoginName=<%=this.CurrentSessionInfo.CompanyLoginName%>'>

                                        <figure>
                                            <img src="../commonv2/images/pdf_ico.png" alt="VAT Return Report" title="New VAT Return" />
                                        </figure>
                                        <span>New VAT Return</span>
                                    </a>--%>

                                                <cc:LinkButtonEx ID="lnkNewVATbackup" runat="server" CssClass="setting-e" OnAccessControlAllowed="OnAccessControlAllowed" AccessControlID="5600803"
                                                    CommandArgument='<%# Eval("VATReturnCode") %>' CommandName="NewVATbackup">
                                  <figure>
                                            <img src="../commonv2/images/pdf_ico.png" alt="Backup Report" title="VAT Backup" />
                                        </figure>
                                        <span>VAT Backup</span>
                                                </cc:LinkButtonEx>



                                                <%--         <a href='Popup/VatreturnBackUpModifiedPaging.aspx?FYCode=<%=this.FYCode%>&CompanyCode=<%=CurrentSessionInfo.Company.CompanyCode %>&r=<%# Eval("VATReturnCode") %>&CompanyLoginName=<%=this.CurrentSessionInfo.CompanyLoginName%>' class="XX2LargePopupStaff setting-e">
                                        <figure>
                                            <img src="../commonv2/images/pdf_ico.png" alt="Backup Report" title="New VAT Backup" />
                                        </figure>
                                        <span>New VAT Backup</span>
                                    </a>--%>






                                                <div style="clear: both; margin-top: 1%; margin-bottom: 1%">&nbsp;</div>

                                                <cc:LinkButtonEx ID="lnkEUSalesReturnBackupReport" runat="server" CssClass="setting-e" Visible="false" CommandArgument='<%# Eval("VATReturnCode") %>' CommandName="EUBackup">

                                         <figure> <img src="../commonv2/images/pdf_ico.png" alt="Backup Report" title="Backup Report"
                                                            /></figure>
                                                        <span>EU Backup</span>




                                           <%--         <a href='Popup/EUSalesReturnBackupReport.aspx?FYCode=<%=this.FYCode%>&CompanyCode=<%=CurrentSessionInfo.Company.CompanyCode %>&r=<%# Eval("VATReturnCode") %>' class="PopUp_70_92">
                                                       <figure> <img src="../commonv2/images/pdf_ico.png" alt="Backup Report" title="Backup Report"
                                                            /></figure>
                                                        <span>EU Backup</span>
                                                    </a>--%>
                                                </cc:LinkButtonEx>

                                                <cc:LinkButtonEx ID="lnkEmail" runat="server" CssClass="setting-e" Visible="false" CommandArgument='<%# Eval("VATReturnCode") %>' CommandName="VATemailpop">
                                                <figure> <asp:Image ID="Image1" ImageUrl="../commonv2/images/emailIcon_grey.png"  runat="server" /> </figure>
                                          <span>Email</span>


<%--                                      <a href='Popup/VATReturnEmail.aspx?FYCode=<%=this.FYCode%>&CompanyCode=<%=CurrentSessionInfo.Company.CompanyCode %>&r=<%# Eval("VATReturnCode") %>' class="PopUp_70_65 setting-e">
                                   <figure> <asp:Image ID="Image1" ImageUrl="../commonv2/images/mail1.png"  runat="server" /> </figure>
                                          <span>Email</span>
                                </a--%>>
                                                </cc:LinkButtonEx>



                                                                 
                                                <cc:LinkButtonEx ID="lnkSubmission" runat="server" CssClass="setting-e" Visible="false" CommandArgument='<%# Eval("VATReturnCode") + "," +  Eval("SubmissionStatusCode")%>' CommandName="Submissionpop">
                                      <figure>    <img src="../commonv2/images/preview.png" alt="Submission Report" title="Submission Report"  /></figure>
                                          <span>Submission</span>

                             
                                        <%--            <a href='Popup/VATReturnSubmissionReport.aspx?FYCode=<%=this.FYCode%>&CompanyCode=<%=CurrentSessionInfo.Company.CompanyCode %>&r=<%# Eval("VATReturnCode") %>' class="setting-e PopUp_70_92" >
                                <figure>    <img src="../commonv2/images/preview.png" alt="Submission Report" title="Submission Report"  /></figure>
                                          <span>Submission</span>

                                </a>--%>
                                                </cc:LinkButtonEx>




                                                <cc:LinkButtonEx ID="lnkEditVatPeriod" CssClass="setting-e" runat="server" CommandArgument='<%# Eval("VATReturnCode") %>' CommandName="EditvatPeriod">
                                         <figure> <asp:Image ID="Image2" ImageUrl="../commonv2/images/edit.png"  runat="server" alt="Edit" title="Edit" /> </figure>
                                          <span>Edit VAT Period</span>
                                                                                
                                        <%--<a href='Popup/EditVatPeriodEditor.aspx?FYCode=<%=this.FYCode%>&CompanyCode=<%=CurrentSessionInfo.Company.CompanyCode %>&r=<%# Eval("VATReturnCode") %>' class="PopUp_70_65 setting-e">
                                   <figure> <asp:Image ID="Image2" ImageUrl="../commonv2/images/edit.png"  runat="server" alt="Edit" title="Edit" /> </figure>
                                          <span>Edit VAT Period</span>
                                </a>--%>

                                                </cc:LinkButtonEx>

                                                <cc:LinkButtonEx ID="lnkVatReturnSubmitted" CssClass="setting-e" runat="server" CommandArgument='<%# Eval("VATReturnCode") %>' CommandName="VATReturnSubmitted">
                                        <figure> <img src="../commonv2/images/preview.png" alt="View Return Submitted" title="View Return Submitted" width="16" height="16" /></figure>
                                          <span>VAT Return Submitted</span>
                                         
                           <%--              <a href='Popup/VatReturnViewpdf.aspx?ReportType=vr&FYCode=<%=this.FYCode%>&CompanyCode=<%=CurrentSessionInfo.Company.CompanyCode %>&r=<%# Eval("VATReturnCode") %>' class="PopUp_70_65 setting-e">
                                   <figure> <img src="../commonv2/images/preview.png" alt="View Return Submitted" title="View Return Submitted" width="16" height="16" /></figure>
                                          <span>VAT Return Submitted</span>
                                </a>--%>
                                                </cc:LinkButtonEx>

                                                <cc:LinkButtonEx ID="lnkVatBackupSubmitted" CssClass="setting-e" runat="server" CommandArgument='<%# Eval("VATReturnCode") %>' CommandName="VATBackupSubmitted">
                                          <figure> <img src="../commonv2/images/preview.png" alt="View VatBackup Submitted" title="View VatBackup Submitted" width="16" height="16" /></figure>
                                          <span>VAT Backup Submitted</span>

                                <%--      <a href='Popup/VatReturnViewpdf.aspx?ReportType=vb&FYCode=<%=this.FYCode%>&CompanyCode=<%=CurrentSessionInfo.Company.CompanyCode %>&r=<%# Eval("VATReturnCode") %>' class="PopUp_70_65 setting-e">
                                   <figure> <img src="../commonv2/images/preview.png" alt="View VatBackup Submitted" title="View VatBackup Submitted" width="16" height="16" /></figure>
                                          <span>VAT Backup Submitted</span>
                                </a>--%>
                                                </cc:LinkButtonEx>

                                            </div>
                                        </td>
                                    </tr>
                                </ItemTemplate>

                                <FooterTemplate>


                                    <tr class="rowFinal">
                                        <td colspan="1">Total</td>
                                        <td colspan="2" class="text-right">
                                            <asp:Literal ID="lblAmount" runat="server"></asp:Literal></td>
                                        <td colspan="8">&nbsp;</td>
                                    </tr>

                                </FooterTemplate>

                            </asp:Repeater>
                        </tbody>
                    </table>
                   
                   </div>

                    </div>
                    
                </div>
            </div>

        </div>
    </div>
   <%-- <style>
        .paginationInner {
            position: relative;
            top: -298px;
        }
    </style>--%>
    <script type="text/javascript">
        function showModal(url) {
            var urlPop = url;
            $('#EditModalFrame').attr('src', urlPop);
            $("#EditPopUp").modal('show');
        }
        function showModalsmall(url) {
            var urlPop = url;
            $('#EditModalFramesmall').attr('src', urlPop);
            $("#EditPopUpsmall").modal('show');
        }
    </script>
    <div class="modal fade" id="EditPopUp" tabindex="-1" role="dialog" aria-labelledby="EditPopUpTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">

                <div class="cphHeader">
                    <button type="button" class="close close_bs" id="EditPopUpClose" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <iframe id="EditModalFrame" name="EditModalFrame" src="" width="100%" height="500" frameborder="0"></iframe>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="EditPopUpsmall" tabindex="-1" role="dialog" aria-labelledby="EditPopUpTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-md" role="document">
            <div class="modal-content">

                <div class="cphHeader">
                    <button type="button" class="close close_bs" id="EditPopUpClosesm" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <iframe id="EditModalFramesmall" name="EditModalFramesm" src="" width="550" height="330" frameborder="0"></iframe>
                </div>
            </div>
        </div>
    </div>

</asp:Content>




<asp:Content ID="Content6" ContentPlaceHolderID="cpHFooter" runat="server">
</asp:Content>


