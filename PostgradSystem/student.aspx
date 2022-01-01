<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="student.aspx.cs" Inherits="PostgradSystem.student" MasterPageFile="~/Base.Master" %>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <body>
    <form id="form1" runat="server">
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
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Courses" runat="server" OnClick ="ShowCourses" Text="View Courses"/>
        </p>
        <p>
            Add The following Phone Number:</p>
        <p>
            <asp:TextBox ID="Phone" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="addPhone" runat="server" Text="Add Phone Number" OnClick="addPhone_Click" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="LogOut" runat="server" Text="Log Out" OnClick="LogOut_Click" />
        </p>
    </form>
</body>
</asp:Content>