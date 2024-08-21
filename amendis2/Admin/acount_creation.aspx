<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="acount_creation.aspx.cs" Inherits="amendis2.Admin.admin_acount_creation" Async="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main  class="container mx-auto mb-12 flex flex-col p-4 text-sm sm:text-base 2xl:text-lg">

    <div class="mb-6 flex items-center space-x-4">
        <label for="user" class="font-medium">enter username :</label>
       <asp:TextBox ID="UsernameTextBox" CssClass="rounded border border-gray-300 p-1 sm:w-72" runat="server" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
           ControlToValidate="UsernameTextBox"
           ErrorMessage="username is required." />
    </div>

      <div class="mb-6 flex items-center space-x-4">
         <label for="user" class="font-medium">enter email :</label>
         <asp:TextBox ID="EmailTextBox"  CssClass="rounded border border-gray-300 p-1 sm:w-72" runat="server" Required="true" />
         <asp:RequiredFieldValidator ID="EmailRequiredFieldValidator" runat="server"
                ControlToValidate="EmailTextBox"
                ErrorMessage="Email is required." />
      </div>



    <div class="mb-6 flex items-center space-x-4">
        <label for="pw" class="font-medium">enter PW :</label>
            <asp:TextBox ID="PasswordTextBox" CssClass="rounded border border-gray-300 p-1 sm:w-72" runat="server" TextMode="Password" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                ControlToValidate="PasswordTextBox"
                ErrorMessage="pw is required." />

    </div>

        <div class="mb-6 flex items-center space-x-4">
            <label for="<%= RoleDropDownList.ClientID %>" class="font-medium">role a donner :</label>
                <asp:DropDownList ID="RoleDropDownList" CssClass="rounded border border-gray-300 p-1 sm:w-72" runat="server">
                    <asp:ListItem Text="Superuser" Value="Superuser" />
                    <asp:ListItem Text="Admin" Value="Admin" />
                </asp:DropDownList>

                
            </div>
        
        <div class="mb-4 mt-11 flex">
            <asp:Button ID="CreateUserButton" runat="server" Text="Create User" OnClick="CreateUserButton_Click" CssClass="ml-52 rounded bg-neutral-700 px-10 py-2 text-white" />
        </div>
        
        <asp:Label ID="SuccessMessageLabel" runat="server" ForeColor="Green" Visible="false" />
        
        
        
    </main>
</asp:Content>
