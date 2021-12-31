<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Theses.aspx.cs" Inherits="PostgradSystem.Theses" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <asp:Table ID="Thesis" runat="server" Width="100%"> 
            <asp:TableRow>
                <asp:TableCell>Serial Number</asp:TableCell>
                <asp:TableCell>Field</asp:TableCell>
                <asp:TableCell>Type</asp:TableCell>
                <asp:TableCell>Title</asp:TableCell>
                <asp:TableCell>Start Date</asp:TableCell>
                <asp:TableCell>End Date</asp:TableCell>
                <asp:TableCell>Defense Date</asp:TableCell>
                <asp:TableCell>Grade</asp:TableCell>
                <asp:TableCell>Extensions</asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        </div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <p>
    <asp:Button ID="Publication" runat="server" Text="View Publications" OnClick="Publication_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="ProgressReport" runat="server" Text="View Progress Reports" OnClick="ProgressReport_Click"/>
        </p>
        <asp:Button ID="Student" runat="server" Text="Back to Profile" OnClick="Student_Click"/>
    </form>
    </body>
</html>
