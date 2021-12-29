<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="student.aspx.cs" Inherits="PostgradSystem.student" MasterPageFile="~/Base.Master" %>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
<body>
    <form id="frontEnd" runat="server">
        <p id ="Welcome" runat ="server"> </p>
        <p id ="fullName" runat ="server"> </p>
        <p id ="ID" runat ="server"> </p>
        <p id ="Type" runat ="server"> </p>
        <p id ="Faculty" runat ="server"> </p>
        <p id ="Address" runat ="server"> </p>
        <p id ="GPA" runat ="server"> </p>
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
    </form>
</body>
</asp:Content>