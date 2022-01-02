<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="supervisor.aspx.cs" Inherits="PostgradSystem.supervisor" MasterPageFile="~/Base.Master" %>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">

<div style="background-color:rgb(30,51,86); background-image: linear-gradient(to right, rgb(30,51,86), rgb(54,65,83)); ">
    
    <form id="inputForm"  runat="server">

        <!--- Page label  --->

        <div style="background-color: rgb(37, 39, 117);">
        <asp:Button style="margin:auto; font-family: 'Lucida Console'" ID="Logout" runat="server" onClick="Logout_Click" Text="Logout"/>
        <asp:Label ID="MainLabel" style="color:white; font: 900 24px/1.4 -system-ui, sans-serif; margin-left:25em" Text="Supervisor Page" runat="server"></asp:Label>
        </div>


         <!--- List all my student names label and inputs  --->

        <div style=" background-color: rgba(0,0,0,0.35); color:white; text-align: center; font: 900 24px/1.4 -system-ui, sans-serif;">
            <label> List all my students' names and years spent in the thesis </label>
        </div>
        <br/>

        <div style="text-align:center;" >
        <asp:Button ID="ListStudentInfo" runat="server" style="font-family: 'Lucida Console'" onClick="ListStudentInfo_Click" Text="List Student Names and Thesis Years"/>
        </div>
        <br />


        <!--- View all student publications label and inputs  --->

        <div style=" background-color: rgba(0,0,0,0.35); color:white; text-align: center; font: 900 24px/1.4 -system-ui, sans-serif;">
        <label> View all publications of a student </label>
        </div>
        <br/>

        <div style="text-align:center;">
        <asp:TextBox ID="StudentIDBox" placeholder="Student ID" style="margin-right: 30px;" runat="server"></asp:TextBox>
        <asp:Button ID="ViewStudentPublications" runat="server" style="font-family: 'Lucida Console';margin: auto;" onClick="ViewStudentPublications_Click" Text="View Student Publications" />
        </div>
        <br />

        <!--- Add defense for thesis label and inputs  --->

        <div style=" background-color: rgba(0,0,0,0.35); color:white; text-align: center; font: 900 24px/1.4 -system-ui, sans-serif;">
        <label> Add a defense for a thesis </label>
        </div>
        <br/>

        <div style="text-align:center;">
        <asp:TextBox ID="AddDefenseThesis" runat="server" style="margin-right: 30px;" placeholder="Thesis Serial Number"></asp:TextBox>
        <Input ID="AddDefenseDatetime" type="date" placeholder="Defense Date" style="margin-right: 30px;" runat="server"/>
        <asp:TextBox ID="AddDefenseLocation" style="margin-right: 30px;" runat="server" placeholder="Defense Location"></asp:TextBox>
        <asp:Button ID="AddDefense" runat="server"  style="font-family: 'Lucida Console'" onClick="AddDefense_Click" Text="Add Defend to Thesis" />
        </div>
        <br />
        
        <!--- Add examiner for defense label and inputs  --->
        
        <div style=" background-color: rgba(0,0,0,0.35); color:white; text-align: center; font: 900 24px/1.4 -system-ui, sans-serif;">
        <label> Add examiner for the defense. </label>
        </div>
        <br/>
        
        <div style="text-align:center;">
        <asp:TextBox ID="AddExaminerThesis" style="margin-right: 30px;" runat="server" placeholder="Thesis Serial Number"></asp:TextBox>
        <Input ID="AddExaminerDate" type="date" style="margin-right: 30px;" placeholder="Defense Datetime" runat="server"></Input>
        <asp:TextBox ID="AddExaminerName"  style="margin-right: 30px;" runat="server" placeholder="Examiner Name"></asp:TextBox>
        <asp:TextBox ID="AddExaminerPassword" style="margin-right: 30px;" placeholder="Examiner Password" runat="server"></asp:TextBox>
        <asp:CheckBox ID="AddExaminerNational" style="margin-right: 30px; color: white; font-family: 'Lucida Console'"  runat="server" Text="National"></asp:CheckBox>
        <asp:TextBox ID="AddExaminerField" runat="server" style="margin-right: 30px;" placeholder="Examiner Field of Work"></asp:TextBox>
        <asp:Button ID="AddExaminer" style="font-family: 'Lucida Console'" runat="server" onClick="AddExaminer_Click" Text="Add Examiner to Defense" />
        </div>
        <br />

        <!--- Evaluate progress report label and inputs  --->

        <div style=" background-color: rgba(0,0,0,0.35); color:white; text-align: center; font: 900 24px/1.4 -system-ui, sans-serif;">
        <label> Evaluate a progress report of a student, and give evaluation value 0 to 3 </label>
        </div>
        <br/>

        <div style="text-align:center;">
        <asp:TextBox ID="EvaluateThesis"  style="margin-right: 30px;" runat="server" placeholder="Thesis Serial Number"></asp:TextBox>
        <asp:TextBox ID="EvaluateProgressNo"  style="margin-right: 30px;" runat="server" placeholder="Progress Report Number"></asp:TextBox>
        <asp:TextBox ID="Evaluation" style="margin-right: 30px;"  runat="server" placeholder="Evaluation (0-3)"></asp:TextBox>
        <asp:Button ID="EvaluateReport"   style="font-family: 'Lucida Console'"  runat="server" onClick="EvaluateReport_Click" Text="Evaluate Progress Report" />
        </div>
        <br />

        <!--- Cancel a thesis label and inputs  --->

        <div style=" background-color: rgba(0,0,0,0.35); color:white; text-align: center; font: 900 24px/1.4 -system-ui, sans-serif;">
        <label> Cancel a Thesis if the evaluation of the last progress report is zero </label>
        </div>
        <br/>

        <div style="text-align:center;">
        <asp:TextBox ID="CancelNumber" style="margin-right: 30px;"  placeholder="Thesis Serial Number"  runat="server"></asp:TextBox>
        <asp:Button ID="CancelThesis" style="font-family: 'Lucida Console'"  onClick="CancelThesis_Click" runat="server" Text="Cancel Thesis" />
        </div>
        <br />

        <!--- Manage Phone Numbers page  --->

        <div style=" background-color: rgba(0,0,0,0.35); color:white; text-align: center; font: 900 24px/1.4 -system-ui, sans-serif;">
            <label> Manage Phone Numbers </label>
        </div>
        <br/>

        <div style="text-align:center;" >
        <asp:Button ID="AddPhoneButton" runat="server" style="font-family: 'Lucida Console'" onClick="AddPhoneButton_Click" Text="Manage Phone Numbers"/>
        </div>
        <br />


        <!--- Output grid of the page  --->
        
        <div>
        <asp:GridView ID="outputGrid" CssClass="table table-borderless table-striped mt-2 bg-white" runat="server"></asp:GridView>
        </div>
    
    </form>
    </div>
</asp:Content>