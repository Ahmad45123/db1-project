<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="PostgradSystem.admin" MasterPageFile="~/Base.Master" %>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">

    <!DOCTYPE html>

    <html>
    <head>
        <title></title>
    </head>
    <body>
        <form id="form1" runat="server">
        <asp:Button ID="listSup" runat="server" Text="List Supervisors" OnClick="listSup_Click" />

        <asp:Button ID="listThes" runat="server" Text="List all Theses" OnClick="listThes_Click" />

        <asp:Button ID="Button1" runat="server" Text="List all Theses" OnClick="listThes_Click" />

        <asp:Label ID="textOut" runat="server" Text=""></asp:Label>
        
            <div>
            </div>
        



        <div>
            <asp:GridView ID="outputGrid" Style="color: white; font-family: 'Lucida Console';" runat="server"></asp:GridView>
        </div>

        <br />

        <asp:Button ID="ThesPay" runat="server" Text="Issue Thesis Payment" OnClick="ThesPay_Click" />


        <asp:TextBox ID="ThesisSerialNo" runat="server" Text="ThesisSerialNo"></asp:TextBox>
        <asp:TextBox ID="amount" runat="server" Text="amount"></asp:TextBox>
        <asp:TextBox ID="noOfInstallments" runat="server" Text="noOfInstallments"></asp:TextBox>
        <asp:TextBox ID="fundPercentage" runat="server" Text="fundPercentage"></asp:TextBox>


        <br />
        <asp:Button ID="IsuInsta" runat="server" Text="Issue Instalment" OnClick="IsuInsta_Click" />


        <asp:TextBox ID="paymentID" runat="server" Text="paymentID"></asp:TextBox>
        <asp:TextBox ID="InstallStartDate" runat="server" Text="InstallStartDate"></asp:TextBox>




        <br />

        <asp:Button ID="AdminUpdateExtension" runat="server" Text="AdminUpdateExtension" OnClick="AdminUpdateExtension_Click" />


        <asp:TextBox ID="ThesisSerialNo2" runat="server" Text="ThesisSerialNo"></asp:TextBox>




            </form>
    </body>
    </html>


</asp:Content>
