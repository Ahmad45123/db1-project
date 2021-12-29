<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Publications.aspx.cs" Inherits="PostgradSystem.Publications" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <asp:Table ID="Publication" runat="server" Width="100%"> 
            <asp:TableRow>
                <asp:TableCell>ID</asp:TableCell>
                <asp:TableCell>Title</asp:TableCell>
                <asp:TableCell>Date Of Publication</asp:TableCell>
                <asp:TableCell>Location</asp:TableCell>
                <asp:TableCell>Accepted</asp:TableCell>
                <asp:TableCell>Host</asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        </div>
        <br />
        <br />
        <p>
            <asp:Button ID="add" runat="server" Text="Add Publication" OnClick="add_Click" />
        </p>
        <p>Link the Publication with following ID to your ongoing thesis:</p>&nbsp;&nbsp;
        <asp:TextBox ID="PublicationID" runat="server"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Link" runat="server" Text="Link To Thesis" OnClick="Link_Click" />
        <br />
        <br />
        <asp:Button ID="Theses" runat="server" Text="Back To Theses" OnClick="Theses_Click" />
    </form>
    <asp:Label ID="invalid" runat="server">
        <font color="#F00" size="4px"> Error: You either have No Ongoing Thesis
            or You Entered a wrong publication ID.
        </font>
    </asp:Label>
</body>
</html>
