<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Supervisor.aspx.cs" Inherits="supervisorcomponent.Supervisor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="inputForm" runat="server">
        <asp:Label ID="MainLabel" Text="Supervisor Page" runat="server"></asp:Label>
        <br />
        <br />
        <asp:Button ID="ListStudentInfo" runat="server" onClick="ListStudentInfo_Click" Text="List Student Names and Thesis Years" />
        <br />
        <br />
        <asp:TextBox ID="StudentIDBox" placeholder="Student ID" runat="server"></asp:TextBox>
        <asp:Button ID="ViewStudentPublications" runat="server" onClick="ViewStudentPublications_Click" Text="View Student Publications" />
        <br />
        <br />
        <asp:TextBox ID="AddDefenseThesis" runat="server" placeholder="Thesis Serial Number"></asp:TextBox>
        <asp:Textbox ID="AddDefenseDatetime" placeholder="Defense Datetime" runat="server"></asp:Textbox>
        <asp:TextBox ID="AddDefenseLocation" runat="server" placeholder="Defense Location"></asp:TextBox>
        <asp:Button ID="AddDefense" runat="server" onClick="AddDefense_Click" Text="Add Defend to Thesis" />
        <br />
        <br />
        <asp:TextBox ID="AddExaminerThesis" runat="server" placeholder="Thesis Serial Number"></asp:TextBox>
        <asp:TextBox ID="AddExaminerDate" placeholder="Defense Datetime" runat="server"></asp:TextBox>
        <asp:TextBox ID="AddExaminerName" runat="server" placeholder="Examiner Name"></asp:TextBox>
        <asp:TextBox ID="AddExaminerPassword" placeholder="Examiner Password" runat="server"></asp:TextBox>
        <asp:CheckBox ID="AddExaminerNational" runat="server" Text="National"></asp:CheckBox>
        <asp:TextBox ID="AddExaminerField" runat="server" placeholder="Examiner Field of Work"></asp:TextBox>
        <asp:Button ID="AddExaminer" runat="server" onClick="AddExaminer_Click" Text="Add Examiner to Defense" />
        <br />
        <br />
        <asp:TextBox ID="EvaluateThesis" runat="server" placeholder="Thesis Serial Number"></asp:TextBox>
        <asp:TextBox ID="EvaluateProgressNo" runat="server" placeholder="Progress Report Number"></asp:TextBox>
        <asp:TextBox ID="Evaluation" runat="server" placeholder="Evaluation (0-3)"></asp:TextBox>
        <asp:Button ID="EvaluateReport" runat="server" onClick="EvaluateReport_Click" Text="Evaluate Progress Report" />
        <br />
        <br />
        <asp:TextBox ID="CancelNumber" placeholder="Thesis Serial Number"  runat="server"></asp:TextBox>
        <asp:Button ID="CancelThesis" onClick="CancelThesis_Click" runat="server" Text="Cancel Thesis" />
        <br />
        <br /> 
        <asp:GridView ID="outputGrid" runat="server"></asp:GridView>
    </form>
    </body>
</html>
