<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="PostgradSystem.Courses" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table ID="Course" runat="server" Width="100%">
                <asp:TableRow>
                    <asp:TableCell>Course</asp:TableCell>
                    <asp:TableCell>Grade</asp:TableCell>
                    <asp:TableCell>Credit Hours</asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
    </form>
    <asp:Button ID="Student" runat="server" Text="Back To Profile" OnClick="Student_Click" />
</body>
</html>
