<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddPublication.aspx.cs" Inherits="PostgradSystem.AddPublication" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="invalid" runat="server">
                <font color="#F00" size="6px"> Invalid Title/Date </font>
            </asp:Label>
            <br />
            <br />
            <asp:Label runat="server" Text="Title:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="Title" runat="server" Width="600px"></asp:TextBox>
            <br />
            <br />
            <asp:Label runat="server" Text="Publication Date:"></asp:Label>
            <asp:Calendar ID="Date" runat="server" OnSelectionChanged="Date_SelectionChanged"></asp:Calendar>
            <br />
            <br />
            <asp:Label runat="server" Text="Host:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="Host" runat="server" Width="600px"></asp:TextBox>

            <br />
            <br />
            <asp:Label runat="server" Text="Place:"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="Place" runat="server" Width="600px"></asp:TextBox>
            <br />
            <br />
            <asp:CheckBox Text= "Accepted" ID="Accept" runat="server"/>
            <br />
            <br />
            <asp:Button ID="Submit" runat="server" Text="Submit" OnClick="Submit_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Cancel" runat="server" Text="Cancel" OnClick="Cancel_Click" />
        </div>
    </form>
</body>
</html>
