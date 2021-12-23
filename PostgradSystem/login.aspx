<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="PostgradSystem.login" MasterPageFile="~/Base.Master" %>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">

        <div class="p-5 h-100" style="background-color: #eee;">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="card rounded-3 text-black w-50">
                        <div class="row">
                            <div class="col">
                                <div class="card-body p-md-5 mx-md-4">

                                    <div class="text-center">
                                        <h1 class="mt-1 mb-5 pb-1">Postgrad System</h1>
                                    </div>

                                    <h5>Please login to your account</h5>
                                    
                                    <form id="loginForm" runat="server">
                                        <div class="mb-4">
                                            <label class="form-label">Username</label>
                                            <asp:TextBox id="emailTextBox" type="email" CssClass="form-control" runat="server"/>
                                        </div>

                                        <div class="mb-4">
                                            <label class="form-label">Password</label>
                                            <asp:TextBox ID="passwordTextBox" type="password" CssClass="form-control" runat="server" />
                                        </div>

                                        <div class="text-center pt-1 mb-5 pb-1">
                                            <asp:Button Text="Login" type="button" CssClass="btn btn-primary mb-3" runat="server"/>
                                        </div>

                                        <div class="d-flex align-items-center justify-content-center pb-4">
                                            <p class="mb-0 me-2">Don't have an account?</p>
                                            <asp:Button ID="registerButton" Text="Create new account" type="button" OnClick="registerButton_OnClick" CssClass="btn btn-outline-danger" runat="server"/>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </div>

</asp:Content>
