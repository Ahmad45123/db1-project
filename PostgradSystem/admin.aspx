<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="PostgradSystem.admin" MasterPageFile="~/Base.Master" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <script language="javascript">

        $(document).ready(function () {
            var tab = document.getElementById('<%= hidTAB.ClientID%>').value;
            $('#' + tab).addClass('active');
            $('#' + tab).addClass('show');
            $('#' + tab + '-tab').addClass('active');
            console.log("Went back to " + tab);

            $('#v-pills-listThesisSups-tab').click(() => {
                document.getElementById('<%=hidTAB.ClientID %>').value = 'v-pills-listThesisSups';
            });
            $('#v-pills-listThesis-tab').click(() => {
                document.getElementById('<%=hidTAB.ClientID %>').value = "v-pills-listThesis";
            });
            $('#v-pills-addPayment-tab').click(() => {
                document.getElementById('<%=hidTAB.ClientID %>').value = "v-pills-addPayment";
            });
            $('#v-pills-addInstallment-tab').click(() => {
                document.getElementById('<%=hidTAB.ClientID %>').value = "v-pills-addInstallment";
            });
            $('#v-pills-issueExtension-tab').click(() => {
                document.getElementById('<%=hidTAB.ClientID %>').value = "v-pills-issueExtension";
            });
        });
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    
    <div class="d-flex align-items-start p-2 h-100" style="background-color: #eee;">
        <div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
            <button class="nav-link" id="v-pills-listThesisSups-tab" data-bs-toggle="pill" data-bs-target="#v-pills-listThesisSups" type="button" role="tab" aria-controls="v-pills-listThesisSups" aria-selected="true">List Supervisors</button>
            <button class="nav-link" id="v-pills-listThesis-tab" data-bs-toggle="pill" data-bs-target="#v-pills-listThesis" type="button" role="tab" aria-controls="v-pills-listThesis" aria-selected="false">List all thesis</button>
            <button class="nav-link" id="v-pills-addPayment-tab" data-bs-toggle="pill" data-bs-target="#v-pills-addPayment" type="button" role="tab" aria-controls="v-pills-addPayment" aria-selected="false">Issue Thesis Payment</button>
            <button class="nav-link" id="v-pills-addInstallment-tab" data-bs-toggle="pill" data-bs-target="#v-pills-addInstallment" type="button" role="tab" aria-controls="v-pills-addInstallment" aria-selected="false">Issue Installment</button>
            <button class="nav-link" id="v-pills-issueExtension-tab" data-bs-toggle="pill" data-bs-target="#v-pills-issueExtension" type="button" role="tab" aria-controls="v-pills-issueExtension" aria-selected="false">Update Thesis Extension</button>
        </div>
        <form runat="server" class="w-100 h-100">
            <p>
                <asp:Button ID="LogOut" runat="server" Text="Log Out" OnClick="LogOut_Click" />
            </p>
            <asp:HiddenField ID="hidTAB" runat="server" Value="v-pills-listThesisSups" />
            <div class="tab-content h-100" id="v-pills-tabContent">
                <div class="tab-pane fade h-100" id="v-pills-listThesisSups" role="tabpanel" aria-labelledby="v-pills-listThesisSups-tab">
                    <div class="card p-2 h-100 overflow-auto">
                        <asp:Button CssClass="btn btn-primary" Text="Refresh" ID="listSup" OnClick="listSup_Click" runat="server"/>
                        <asp:GridView CssClass="table table-borderless table-striped mt-2" runat="server" ID="supOutputGrid"></asp:GridView>
                    </div>
                </div>
                <div class="tab-pane fade h-100" id="v-pills-listThesis" role="tabpanel" aria-labelledby="v-pills-listThesis-tab">
                    <div class="card p-2 h-100 overflow-auto">
                        <div class="align-self-center">
                            <asp:Button CssClass="btn btn-primary" Text="Refresh" ID="listThes" OnClick="listThes_Click" runat="server"/>
                            <label id="countLabel" style="font-weight: bold" runat="server">Ongoing Theses: -</label>
                        </div>
                        <asp:GridView CssClass="table table-borderless table-striped mt-2" runat="server" ID="thesisGrid"></asp:GridView>
                    </div>
                </div>
                <div class="tab-pane fade h-100" id="v-pills-addPayment" role="tabpanel" aria-labelledby="v-pills-addPayment-tab">
                    <div class="card p-2 h-100">
                        <div class="mb-3">
                            <label for="paymentThesisSerial" class="form-label">Thesis Serial</label>
                            <input type="number" class="form-control" id="paymentThesisSerial" runat="server" />
                        </div>
                        <div class="mb-3">
                            <label for="paymentAmount" class="form-label">Amount</label>
                            <input type="number" step="0.01" min="0" max="99999.99" class="form-control" id="paymentAmount" runat="server" />
                        </div>
                        <div class="mb-3">
                            <label for="paymentNoInstallments" class="form-label">No. Of Installments</label>
                            <input type="number" min="1" class="form-control" id="paymentNoInstallments" runat="server" />
                        </div>
                        <div class="mb-3">
                            <label for="paymentFuncPerc" class="form-label">Fund Percentage</label>
                            <input type="number" step="0.01" min="0" max="100" class="form-control" id="paymentFuncPerc" runat="server" />
                        </div>
                        <asp:Button ID="ThesPay" type="submit" CssClass="btn btn-primary w-25" Text="Save Payment" OnClick="ThesPay_Click" runat="server" />
                        <asp:Label runat="server" ID="savePaymentLabel" CssClass="alert alert-success d-block mt-2" role="alert" Visible="false"/> 

                    </div>
                </div>
                <div class="tab-pane fade h-100" id="v-pills-addInstallment" role="tabpanel" aria-labelledby="v-pills-addPayment-tab">
                    <div class="card p-2 h-100">
                        <div class="mb-3">
                            <label for="installmentPaymentId" class="form-label">Payment ID</label>
                            <input type="number" class="form-control" id="installmentPaymentId" runat="server" />
                        </div>
                        <div class="mb-3">
                            <label for="installmentDate" class="form-label">Installment Start Date</label>
                            <input type="date" class="form-control" id="installmentDate" runat="server" />
                        </div>
                        <asp:Button ID="IsuInsta" type="submit" CssClass="btn btn-primary w-25" Text="Issue Installment" OnClick="IsuInsta_Click" runat="server" />
                        <asp:Label runat="server" ID="installmentLabel" CssClass="alert alert-success d-block mt-2" role="alert" Visible="false"/> 

                    </div>
                </div>
                <div class="tab-pane fade h-100" id="v-pills-issueExtension" role="tabpanel" aria-labelledby="v-pills-issueExtension-tab">
                    <div class="card p-2 h-100">
                        <div class="mb-3">
                            <label for="extensionThesisSerial" class="form-label">Thesis Serial</label>
                            <input type="number" class="form-control" id="extensionThesisSerial" runat="server" />
                        </div>
                        <asp:Button ID="AdminUpdateExtension" type="submit" CssClass="btn btn-primary w-25" Text="Issue Extension" OnClick="AdminUpdateExtension_Click" runat="server" />
                        <asp:Label runat="server" ID="updateExtensionLabel" CssClass="alert alert-success d-block mt-2" role="alert" Visible="false"/> 

                    </div>
                </div>
            </div>
        </form>
    </div>
</asp:Content>
