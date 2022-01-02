<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManagePhones.aspx.cs" Inherits="PostgradSystem.ManagePhones" MasterPageFile="~/Base.Master" %>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    
    <form class="p-2" runat="server">
        <div class="card p-2 h-25">
            <div class="mb-3">
                <label for="numberInput" class="form-label">Phone Number</label>
                <input type="number" class="form-control" id="numberInput" runat="server" />
            </div>
            <asp:Button ID="saveButton" type="submit" CssClass="btn btn-primary w-25 align-self-end" Text="Save Number" OnClick="saveButton_OnClick" runat="server" />
            <asp:Label runat="server" ID="saveNumberLabel" CssClass="alert alert-success d-block mt-2" role="alert" Visible="false"/> 

        </div>
        <asp:GridView CssClass="table table-borderless table-striped mt-2" runat="server" ID="numbersGrid"></asp:GridView>
    </form>

</asp:Content>
