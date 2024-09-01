<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="acount_creation.aspx.cs" Inherits="amendis2.Admin.admin_acount_creation" Async="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main  class="container mx-auto mb-12 flex flex-col p-4 text-xl">

    <div class="mb-16 flex justify-center p-7">
        <p class="text-3xl font-medium">Creation de Compte </p>
    </div>
   <div class="mb-6 ml-32 flex items-center">
       <div class="flex">
            <label for="user" class="mr-9 font-medium">Saisir le Username :</label>
            <asp:TextBox ID="UsernameTextBox" CssClass="ml-9 rounded border border-gray-300 p-1 sm:w-72" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ControlToValidate="UsernameTextBox"
                ErrorMessage="username is required."
                CssClass="text-red-500" />
        </div>
       <div class="mr-5 flex">
            <label for="email" class="mr-9 font-medium">Saisir L'email :</label>
            <asp:TextBox ID="EmailTextBox" CssClass="rounded border border-gray-300 p-1 sm:w-72" runat="server" />
            <asp:RequiredFieldValidator ID="EmailRequiredFieldValidator" runat="server"
                ControlToValidate="EmailTextBox"
                ErrorMessage="Email is required."
                CssClass="text-red-500" />
       </div>
    </div>

    <div class="mb-6 ml-32 mt-10 flex items-center">
        <div class="flex">
            <label for="pw" class="mr-9 font-medium">Saisir le Mots de Passe :</label>
            <asp:TextBox ID="PasswordTextBox" CssClass="mr-14 rounded border border-gray-300 p-1 sm:w-72" runat="server" TextMode="Password" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                ControlToValidate="PasswordTextBox"
                ErrorMessage="pw is required."
                CssClass="text-red-500" />
        </div>
        <div class="flex">
            <label for="<%= RoleDropDownList.ClientID %>" class="mr-9 font-medium">Role a Donner :</label>
            <asp:DropDownList ID="RoleDropDownList" CssClass="rounded border border-gray-300 p-1 sm:w-64" runat="server">
                <asp:ListItem Text="Superuser" Value="Superuser" />
                <asp:ListItem Text="Admin" Value="Admin" />
            </asp:DropDownList>
        </div>
    </div>


        
        <div class="mb-4 mt-14 flex justify-center">
            <asp:Button ID="CreateUserButton" runat="server" Text="Create User" OnClick="CreateUserButton_Click" CssClass="cursor-pointer rounded bg-neutral-700 px-14 py-2 text-white" />
        </div>
        <div class="mt-3 flex justify-center">
            <asp:HyperLink ID="ModifyUserLink" runat="server" NavigateUrl="~/Admin/modify_userRoles.aspx" CssClass="text-blue-500 underline hover:text-blue-800">
                Modifier un Utilisateur
            </asp:HyperLink>
        </div>
        
        <asp:Label ID="SuccessMessageLabel" runat="server" ForeColor="Green" Visible="false" />
        
        
        
    </main>
</asp:Content>
