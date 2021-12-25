<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="PostgradSystem.register" MasterPageFile="~/Base.Master" %>

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

                            <h3>Register new account</h3>

                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="student-tab" data-bs-toggle="tab" data-bs-target="#student" type="button" role="tab" aria-controls="student" aria-selected="true">Student</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="supervisor-tab" data-bs-toggle="tab" data-bs-target="#supervisor" type="button" role="tab" aria-controls="supervisor" aria-selected="false">Supervisor</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="examiner-tab" data-bs-toggle="tab" data-bs-target="#examiner" type="button" role="tab" aria-controls="examiner" aria-selected="false">Examiner</button>
                                </li>
                            </ul>
                            <form runat="server">
                                <div class="tab-content" id="myTabContent">
                                    <div class="tab-pane fade show active" id="student" role="tabpanel" aria-labelledby="student-tab">
                                        <div class="mt-2">
                                            <div class="mb-3 d-flex">
                                                <div class="w-50 me-2">
                                                    <label for="studentFirstName" class="form-label">First Name</label>
                                                    <input type="text" class="form-control" id="studentFirstName" runat="server" />
                                                </div>
                                                <div class="w-50">
                                                    <label for="studentLastName" class="form-label">Last Name</label>
                                                    <input type="text" class="form-control" id="studentLastName" runat="server" />
                                                </div>
                                            </div>
                                            <div class="mb-3">
                                                <label for="studentEmail" class="form-label">Email</label>
                                                <input type="email" class="form-control" id="studentEmail" runat="server" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="studentPassword" class="form-label">Password</label>
                                                <input type="password" class="form-control" id="studentPassword" runat="server" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="studentFaculty" class="form-label">Faculty</label>
                                                <input type="text" class="form-control" id="studentFaculty" runat="server" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="studentAddress" class="form-label">Address</label>
                                                <input type="text" class="form-control" id="studentAddress" runat="server" />
                                            </div>
                                            <div class="mb-3 form-check">
                                                <input type="checkbox" class="form-check-input" id="studentGucian" runat="server" />
                                                <label class="form-check-label" for="studentGucian">GUCian ?</label>
                                            </div>
                                            <asp:Button ID="studentSubmit" type="submit" CssClass="btn btn-primary float-start w-25" OnClick="studentSubmit_OnServerClick" Text="Register" runat="server" />
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="supervisor" role="tabpanel" aria-labelledby="supervisor-tab">
                                        <div class="mt-2">
                                            <div class="mb-3 d-flex">
                                                <div class="w-50 me-2">
                                                    <label for="supervisorFirstName" class="form-label">First Name</label>
                                                    <input type="text" class="form-control" id="supervisorFirstName" runat="server" />
                                                </div>
                                                <div class="w-50">
                                                    <label for="supervisorLastName" class="form-label">Last Name</label>
                                                    <input type="text" class="form-control" id="supervisorLastName" runat="server" />
                                                </div>
                                            </div>
                                            <div class="mb-3">
                                                <label for="supervisorEmail" class="form-label">Email</label>
                                                <input type="email" class="form-control" id="supervisorEmail" runat="server" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="supervisorPassword" class="form-label">Password</label>
                                                <input type="password" class="form-control" id="supervisorPassword" runat="server" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="supervisorFaculty" class="form-label">Faculty</label>
                                                <input type="text" class="form-control" id="supervisorFaculty" runat="server" />
                                            </div>
                                            <asp:Button ID="supervisorRegsister" type="submit" CssClass="btn btn-primary float-start w-25" OnClick="supervisorRegsister_OnClick" Text="Register" runat="server" />
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="examiner" role="tabpanel" aria-labelledby="examiner-tab">
                                        <div class="mt-2">
                                            <div class="mb-3 d-flex">
                                                <div class="w-50 me-2">
                                                    <label for="examinerFirstName" class="form-label">First Name</label>
                                                    <input type="text" class="form-control" id="examinerFirstName" runat="server" />
                                                </div>
                                                <div class="w-50">
                                                    <label for="examinerLastName" class="form-label">Last Name</label>
                                                    <input type="text" class="form-control" id="examinerLastName" runat="server" />
                                                </div>
                                            </div>
                                            <div class="mb-3">
                                                <label for="exmainerEmail" class="form-label">Email</label>
                                                <input type="email" class="form-control" id="exmainerEmail" runat="server" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="examinerPassword" class="form-label">Password</label>
                                                <input type="password" class="form-control" id="examinerPassword" runat="server" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="examinerField" class="form-label">Field of Work</label>
                                                <input type="text" class="form-control" id="examinerField" runat="server" />
                                            </div>
                                            <div class="mb-3 form-check">
                                                <input type="checkbox" class="form-check-input" id="exmainerIsNational" runat="server" />
                                                <label class="form-check-label" for="exmainerIsNational">Is National ?</label>
                                            </div>
                                            <asp:Button ID="examinerRegister" type="submit" CssClass="btn btn-primary float-start w-25" OnClick="examinerRegister_OnClick" Text="Register" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <asp:Button ID="alreadyHaveAccountBtn" CssClass="btn btn-outline-secondary float-end" Text="Already have an account ?" OnClick="alreadyHaveAccountBtn_OnClick" runat="server"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
