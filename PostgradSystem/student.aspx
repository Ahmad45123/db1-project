<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="student.aspx.cs" Inherits="PostgradSystem.student" MasterPageFile="~/Base.Master" %>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <form id="form1" class="p-2" runat="server">
        <p id ="Welcome" runat ="server"> </p>
        <p id ="fullName" runat ="server"> </p>
        <p id ="ID" runat ="server"> </p>
        <p id ="Type" runat ="server"> </p>
        <p id ="Faculty" runat ="server"> </p>
        <p id ="Address" runat ="server"> </p>
        <p id ="GPA" runat ="server"> </p>
        <p id ="underGradID" runat ="server"> </p>
        <div>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </div>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="Theses" runat="server" OnClick="ShowTheses" Text="View My Theses" />
        </p>
        <p>
            <asp:Button ID="Courses" runat="server" OnClick ="ShowCourses" Text="View Courses"/>
        </p>
        <p>
            <asp:Button ID="addPhone" runat="server" Text="Manage Phone Numbers" OnClick="addPhone_Click" />
        </p>
        <p>
            <asp:Button ID="LogOut" runat="server" Text="Log Out" OnClick="LogOut_Click" />
        </p>
    </form>
</asp:Content>