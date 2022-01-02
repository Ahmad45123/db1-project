<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProgressReports.aspx.cs" Inherits="PostgradSystem.ProgressReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <asp:Table ID="Report" runat="server" Width="100%"> 
            <asp:TableRow>
                <asp:TableCell>Report Number</asp:TableCell>
                <asp:TableCell>Full Description</asp:TableCell>
                <asp:TableCell>Date</asp:TableCell>
                <asp:TableCell>State</asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        </div>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            Add Progress Report to my ongoing Thesis with the following Information:</p>
        <p>
            Report Number:&nbsp;
            <asp:TextBox ID="number1" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Calendar ID="Calendar" runat="server"></asp:Calendar>
        </p>
        <asp:Button ID="Add" runat="server" Text="Add Progress Report" OnClick="Add_Click" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        <br />
        --------------------------------------------------------------------------------------------------------------------------------<br />
        <br />
        Fill Progress Report for my ongoing Thesis with the following Information:<br />
        <br />
        Report Number:&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="number2" runat="server"></asp:TextBox>
        <br />
        <br />
        State:&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="state" runat="server"></asp:TextBox>
        <br />
        <br />
        Description:<br />
        <asp:TextBox TextMode="MultiLine" ID="description" runat="server" Height="200px" Width="600px"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="fill" runat="server" Text="Fill Report" OnClick="fill_Click"/>
        <br />
        <br />
        -------------------------------------------------------------------------------------------------------------------------------<br />
        <br />
        <asp:Button ID="Theses" runat="server" Text="Back to Theses" OnClick="Theses_Click" />
    </form>
</body>
</html>
